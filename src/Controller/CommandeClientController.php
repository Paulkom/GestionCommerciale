<?php

namespace App\Controller;

use DateTime;
use NumberFormatter;
use App\Entity\Client;
use App\Entity\Facture;
use App\Entity\Paiement;
use App\Services\ApiMecef;
use App\Entity\ModePaiement;
use PharIo\Manifest\Library;
use App\Entity\CommandeClient;
use App\Entity\FactureProforma;
use Doctrine\ORM\EntityManager;
use App\Form\CommandeClientType;
use App\Entity\ProduitCondComClit;
use App\Services\LibrairieService;
use App\Repository\CaisseRepository;
use App\Repository\FactureRepository;
use App\Repository\SocieteRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Repository\CommandeClientRepository;
use App\Repository\ProduitCondMagRepository;
use App\Repository\ModelSignataireRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Security;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Repository\ProduitCondComClitRepository;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/admin/commande/client')]
class CommandeClientController extends AbstractController
{

    private $mecefService;
    private $session;
    protected $security;
    
    public function __construct(SessionInterface $session, ApiMecef $mecef, Security $security)
    {
        $this->session=$session;
        $this->mecefService = $mecef;
        $this->security = $security;
    }

    #[Route('/{proformatid}', name: 'app_commande_client_index', methods: ['GET', 'POST'], defaults: ['proformatid' => 'cmd'])]
    public function index(Request $request, EntityManagerInterface $em, CommandeClientRepository $commandeClientRepository,CaisseRepository $caisseRepository,$proformatid): Response
    {
        $commandeClient = new CommandeClient();

        if (is_numeric($proformatid)) {
            ///dd($proformatid);
            /**
             * @var FactureProforma $proformat
             */
            $proformat = $em->getRepository(FactureProforma::class)->find($proformatid);
            if($proformat){
                $commandeClient->setMontantHtToAprRse($proformat->getMontantHtToAprRse());
                $commandeClient->setMontantHt($proformat->getMontantHt());
                $commandeClient->setMontantTtc($proformat->getMontantTtc());
                $commandeClient->setMontantTva($proformat->getMontantTva());
                $commandeClient->setAcheteur($proformat->getAcheteur());

                foreach($proformat->getProduitCondFactures() as $produit) {
                    $prodClit = new ProduitCondComClit;
                    $prodClit->setProduit($produit->getProduit());
                    $prodClit->setLibelleProduit($produit->getProduit()->getNomProCond().' [ '.$produit->getProduit()->getProduit()->getGroupeTaxe()->getCodeGr().' ]');
                    $prodClit->setPrix($produit->getPrix());
                    $prodClit->setPrixHt($produit->getPrixHt());
                    $prodClit->setQtite($produit->getQtite());
                    $prodClit->setMontant($produit->getMontant());
                    $prodClit->setMontantTtcp($produit->getMontantTtcp());
                    $prodClit->setMontantHtAprRse($produit->getMontantHtAprRse());
                    $prodClit->setMontantTvap($produit->getMontantTvap());
                    $prodClit->setTypeRemise($produit->getTypeRemise());
                    $prodClit->setRemise($produit->getRemise());
                    $prodClit->setValeurRemise($produit->getValeurRemise());

                    $commandeClient->addProduitCondComClit($prodClit);
                }
            }
        }else{
            $client= $em->getRepository(Client::class)->findOneBy(['nom' => "Ordinaire"]);
            $commandeClient->setAcheteur($client);
        }
       
        $form = $this->createForm(CommandeClientType::class, $commandeClient);
        $form->handleRequest($request);

        if($form->isSubmitted() && $form->isValid()) {
            if ($commandeClient->getTypeCommande() == 'Au comptoir') {
                $session = $request->getSession();
                if (!$session->get('caisse')) 
                    return new JsonResponse("Veuillez ouvrir une caisse avant d'effectuer l'opération.§§§§msg_error");
            }
            $commande_client = $request->request->get("commande_client");
            
            //Ajout du nouveau client lors de la commande
            if (!$commandeClient->getAcheteur()) {
                $client = new Client;
                $date = null;
                if ($commande_client['dateNais']) {
                    $dd = $commande_client['dateNais'] . " 00:00:00";
                    $date = new DateTime($dd);
                }
                $client->setStatut($commande_client["statut"]);
                $client->setAdresse($commande_client["adresse"]);
                $client->setEmail($commande_client["email"]);
                $client->setIfu($commande_client["ifu"]);
                $client->setTelephone1($commande_client["telephone1"]);
                $client->setTelephone2($commande_client["telephone2"]);
                $client->setDateNais($date);
                if ($commande_client["statut"] == "Physique") {
                    $client->setNom($commande_client["nom"]);
                    $client->setPrenom($commande_client["prenom"]);
                } elseif ($commande_client["statut"] == "Moral") {
                    $client->setDenomination($commande_client["denomination"]);
                    $client->setRaisonSociale($commande_client["raisonSociale"]);
                    $client->setRccm($commande_client["rccm"]);
                    $client->setSigle($commande_client["sigle"]);
                }
                $em->persist($client);
                $commandeClient->setAcheteur($client);
            }

            $typeFacture = $commandeClient->getTypeFacture();
            // gestion de facture lors de la vente
            $facture = new Facture();
            $facture->setMontantTotal($commandeClient->getMontantTtc());
            $facture->setDateFac(new Datetime);
            if($typeFacture == 'EV')
                $facture->setTypeFacture('EV');
            $em->persist($facture);
            $commandeClient->addFacture($facture);


            // gestion du paiement lors de la vente
            if ($commandeClient->getTypeCommande() == 'Au comptoir') {
                $paiement =  new Paiement();
                $paiement->setMontantPaye($commandeClient->getMontantTtc());
                $modePaiement = $em->getRepository(ModePaiement::class)->findOneBy(['code' => 'ESP']);
                $paiement->setModePaiement($modePaiement);
                $paiement->setMontantRAPayer(0);
                $paiement->setMontantRecu($commande_client["montantRecu"]);
                $paiement->setReliquat($commande_client["reliquat"]);
                $paiement->setDatePaie(new Datetime);
                $facture->setMontantRest(0);
                $paiement->setFacture($facture);
                $session =$request->getSession();
                $paiement->setCaisse($caisseRepository->find($session->get('caisse')));
                $em->persist($paiement);
                $em->flush();
                $facture->setStatut('Payée');
                $commandeClient->setStatut('Payée');
            }
            $commandeClient->setStatutLiv('Non livrée');
            $commandeClientRepository->add($commandeClient);
           
            
            if($commandeClient->getId() != null){

                //NORMALISATION MECEF
                // $checknet = $request->request->get("checknet");
                $sessionSociete = $this->session->get('societe', []);
               
                if($sessionSociete['estModeMecef'] == true){

                
                    $checknet = $request->request->get('commande_client')['checknet'];

                    if($checknet == 1){
                        
                        // switch ($typeFacture) {
                        //     case 'FV':
                        //         $data = $this->mecefService->normalise('FV', $commandeClient, $this->security->getUser(),  $this->session->get('societe', []));
                        //         break;

                        //     case 'EV':
                        //         $data = $this->mecefService->normalise('EV', $commandeClient, $this->security->getUser(),  $this->session->get('societe', []));
                        //         break;
                        //     default:
                        //         $data = null;
                        //         break;
                        // }
                        
                        // if($data && $data != null){
                        //     $facture->setMecefDate($data['date_time']);
                        //     $facture->setMecefCode($data['code_me_ce_fdgi']);
                        //     $facture->setMecefCompteur($data['counters']);
                        //     $facture->setMecefQrCode($data['qr_code']);
                        //     $facture->setMecefNim($data['nim']);
                        //     $facture->setEstNormalisee(true);
                        //     $facture->getCommandeCli()->setEstNormalisee(true);
                        //     $em->flush($facture);
                        // }
                    }
                }
                //FIN

                // $id = $commandeClient->getId();
                $id = $commandeClient->getFactures()->first()->getId();
                $statu = $form->get("truc")->getData();
                $formatpp = $request->request->get("commande_client")['formatImpression'];

                $commandeClient = new CommandeClient();
                $client= $em->getRepository(Client::class)->findOneBy(['nom' => "Ordinaire"]);
                $commandeClient->setAcheteur($client);

                

                $form = $this->createForm(CommandeClientType::class, $commandeClient);
                $html = $this->renderView('commande_client/partials/_card_form.html.twig', ['commande_client' => $commandeClient,'form' => $form->createView() ]);
                $comp ="§".$id."§".$statu."§".$html."§".$formatpp;
                return new JsonResponse("La vente a été éffectué avec succès. ". $comp);
            }
        }
        return $this->renderForm('commande_client/index.html.twig', [
            'commande_client' => $commandeClient,
            'form' => $form,
        ]);
    }

    private function getFormattedNumber($value,$locale = 'fr_FR',$style = NumberFormatter::DECIMAL,$precision = 2,$groupingUsed = true,$currencyCode = 'XOF',
    ) {
        $formatter = new NumberFormatter($locale, $style);
        $formatter->setAttribute(NumberFormatter::FRACTION_DIGITS, $precision);
        $formatter->setAttribute(NumberFormatter::GROUPING_USED, $groupingUsed);
        if ($style == NumberFormatter::CURRENCY) {
            $formatter->setTextAttribute(NumberFormatter::CURRENCY_CODE, $currencyCode);
        }
    
        return $formatter->format($value);
    }

    #[Route('/impression/docu', name: 'imprime_commande', methods: ['GET', 'POST'])]
    public function impression(LibrairieService $library, ModelSignataireRepository $modelRep , SocieteRepository $sociRep, Request $request, CommandeClientRepository $commandeCliRe, FactureRepository $factRe){
        $id = $request->request->get('id');
        $estCommande = $request->request->get('commande');
        $type = ((!empty($request->request->get('type')))) ? $request->request->get('type') : "" ; 
        $formatpp = ((!empty($request->request->get('formatPapier')))) ? $request->request->get('formatPapier') : "" ; 
        
        switch ($formatpp) {
            case '1':
                $format = "A4-P";
                break;
            case '2':
                $format = "A5-L";
                break;
            
            default:
                $format = "A4-P";
                break;
        }
        
        $ent = null;

        if($sociRep->findAll()){
            $ent = ($sociRep->findAll())[0];
        }
        
        $signataires = $modelRep->findOneBy(["estDefault"=>true]);

        if($estCommande != null){
            $commande = $commandeCliRe->find($id);
            $facture = $commande->getFactures()->last(); // la facture d'avoir
        }else{
            $facture = $factRe->find($id); // la facture de vente
            $commande = $commandeCliRe->find($facture->getCommandeCli()->getId());
        }
        //dd($signataires);
        
        $htmlPage = $this->renderView( ($format == "A4-P") ? "commande_client/document/factureA4_.html.twig" : "commande_client/document/factureA5.html.twig",[
            'commande'=>$commande,
            'format'=>$format,
            'signataires'=>$signataires,
            'societe'=>$ent,
            "qr"=> ($commande->getEstNormalisee()) ? $library->codeQr($facture->getMecefQrCode()) : null,
            'facture' => $facture,
            'valeur'=> $library->getFormattedNumber(value:$commande->getMontantTtc(),  style: NumberFormatter::SPELLOUT)
        ]);

        $bonHtml = $this->renderView("commande_client/document/bon.html.twig",[
            'commande'=>$commande,
            'format'=>$format,
            'signataires'=>$signataires,
            'societe'=>$ent,
        ]);
        
        

        if($type !== ""){
            return $library->mpdf([$htmlPage,$htmlPage],"Facture",$format);
        }else{
            return $library->mpdf([$htmlPage,$htmlPage,$bonHtml],"Facture",$format);
        }
        
        // return $library->mpdf([$htmlPage],"Facture",$format);
    }


    #[Route('/new', name: 'app_commande_client_new', methods: ['GET', 'POST'])]
    public function new(Request $request, CommandeClientRepository $commandeClientRepository): Response
    {
        $commandeClient = new CommandeClient();
        $form = $this->createForm(CommandeClientType::class, $commandeClient);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $commandeClientRepository->add($commandeClient);
            return $this->redirectToRoute('app_commande_client_index', [], Response::HTTP_SEE_OTHER);
        }
        return $this->renderForm('commande_client/new.html.twig', [
            'commande_client' => $commandeClient,
            'form' => $form,
        ]);
    }


    /**
     * @Route("/loader/produit/commander", name="app_loader_prod_comd", methods={"GET", "POST"})
     */
    public function loadProduitByCommande(Request $request,ProduitCondComClitRepository $produitCondComClitRepository)
    {
        set_time_limit(0);
        $em = $this->getDoctrine()->getManager();
        $id = $request->query->get('id');
        $magid = $request->query->get('magid');

        /** @var ProduitCondComClit[] $produictcommanders */
       // $produictcommanders = $em->getRepository(CommandeClient::class)->find($id)->getProduitCondComClits();
        $produictcommanders = $produitCondComClitRepository->getProdCmdMag($id,$magid);
        //$produictcommanders = $produitCondComClitRepository->findBy(["magasin"=>$magid,"commandeClit"=>$id]);
        $options = [];
        foreach ($produictcommanders as $key=>$produit) {
            $options[$key]= '<option  value="' . $produit->getId() . 
            '" data-restaliv="' . $produit->getRestAliv() . 
            '" data-prix="' . $produit->getPrix() . 
            '" data-qtite="' . $produit->getQtite() . 

            '" piece-par-carton="' .     $produit->getProduit()->getProduit()->getPieceParCarton() . 
            '" piece-par-metrecarre="' . $produit->getProduit()->getProduit()->getPieceParMetreCarre() . 
            '" surface-par-piece="' .    $produit->getProduit()->getProduit()->getSurfaceParPiece() . 
            '" m2-par-carton="' .        $produit->getProduit()->getProduit()->getMetreCarreParCarton() . 
            '" est-mode-carreau="' .     (($produit->getProduit()->getProduit()->getEstModeCarreau()) ? 1 : 0) . 
            '" est-service="' .          (($produit->getProduit()->getProduit()->getEstService()) ? 1 : 0) . 

            '" data-montant="' . $produit->getMontant() . '">' . $produit->getProduit() . '</option>';
        }
        return new JsonResponse($options);
        // return new JsonResponse($produictcommanders);
        // dd($produictcommanders);
        // return $produictcommanders;
    }


    /**
     * @Route("/loader/magasin/produit/commander", name="app_loader_mag_comd", methods={"GET", "POST"})
     */
    public function loadMagsCommande(Request $request,ProduitCondComClitRepository $produitCondComClitRepository)
    {
        set_time_limit(0);
        $em = $this->getDoctrine()->getManager();
        $id = $request->query->get('id');

        /** @var ProduitCondComClit[] $produictcommanders */
        $produictcommanders = $produitCondComClitRepository->findBy(['commandeClit' => $id]);

        $magasins = [];
        foreach ($produictcommanders as $pc) {
            if( !in_array($pc->getMagasin(), $magasins)){
                $magasins[] = $pc->getMagasin();
            }
        }
        $options = [];
        $options[0]= '<option> Sélectionnez le magasin </option>';
        foreach ($magasins as $key => $mag) {
            $options[$key+1]= '<option  value="' . $mag->getId() . '">' . $mag->getNomMag() . '</option>';
        }
        
        return new JsonResponse($options);
    }

    /**
     * @Route("/loader/produit/magasin", name="app_loader_prod_par_magasin", methods={"GET", "POST"})
     */
    public function loadProduitByMagasin(Request $request,ProduitCondMagRepository $produitCondMagRepository)
    {
        set_time_limit(0);
        $em = $this->getDoctrine()->getManager();
        $produitid = $request->query->get('produitid');
        $magid = $request->query->get('magid');

        /** @var ProduitCondMag $produictmag */;
        $produictmag = $produitCondMagRepository->findOneBy(["magasin"=>$magid,"produitConditionnement"=>$produitid]);
        //dd($produictmag);
        if($produictmag) {
            $quantit = $produictmag->getQteStockMag() ;
            if((int)$quantit) {
                return new JsonResponse([(int)$quantit]);
            }
        }
        return new JsonResponse([0])
        ;
    }

    #[Route('/verifie/statut', name: 'app_commande_verifie_statut', methods: ['POST','GET'])]
    public function verifie_statut(Request $request, CommandeClientRepository $commandeClientRepository): Response
    {
        $code = $request->query->get('code');
        $motif = $request->query->get('motif');
       $statut = $commandeClientRepository->findOneBy(['refCom'=>$code,'statut'=>'Annuler']);
       if ($statut) {
            return new JsonResponse(['estannuler'=>false,'motif'=>$motif]);
       }else{
            return new JsonResponse(['estannuler'=>true,'motif'=>$motif]);
       }
    }

    /**
     * @param Request $request
     * @Route("/annulation/{key}/commande", name="app_annulationCommande", methods={"GET", "POST"})
     */
    public function annulationCommande($key,Request $request,EntityManagerInterface $em)
    {
        $motif=$request->query->get('motif');
        $facture = new Facture();

        /** @var CommandeClient */
        $commandeClient = $em->getRepository(CommandeClient::class)->find((int)$key);
        $facture->setMontantTotal($commandeClient->getMontantTtc());
        $commandeClient->setStatut('Annuler');
        $commandeClient->setMotifAnnulation($motif);
        $commandeClient->setEstSup(true);
        $commandeClient->setDeletedAt(new \DateTime());

        $facture->setCommandeCli($commandeClient);
        $facture->setTypeFacture('FA');
        $facture->setDateFac(new Datetime);

       if($commandeClient->getId() != null){
            /**
             * @var Facture $fact
             */
            $fact = $commandeClient->getFactures()->first();
            if($fact->getTypeFacture() === 'FV' || $fact->getTypeFacture() === 'EV'){
                if($commandeClient->getEstNormalisee()){
                    $reference = $fact->getMecefCode();
                    $typeFactureCmd = $commandeClient->getTypeFacture();
                    
                    //NORMALISATION MECEF ANNULATION
                    if( $typeFactureCmd == 'EV'){
                        $data = $this->mecefService->normalise('EA', $commandeClient, $this->security->getUser(),  $this->session->get('societe', []), $reference);
                        $facture->setTypeFacture('EA');
                    }else{
                        $data = $this->mecefService->normalise('FA', $commandeClient, $this->security->getUser(),  $this->session->get('societe', []), $reference);
                        $facture->setTypeFacture('FA');
                    }
                    
                    if($data){
                        $facture->setMecefDate($data['date_time']);
                        $facture->setMecefCode($data['code_me_ce_fdgi']);
                        $facture->setMecefCompteur($data['counters']);
                        $facture->setMecefQrCode($data['qr_code']);
                        $facture->setMecefNim($data['nim']);
                        $facture->setEstNormalisee(true);
                    }else{
                        return new JsonResponse("Impossible d'annuler la facture, veuillez revérifier votre connexion interent!!!§§§§msg_error");
                    }
                    //FIN
                }
                $facture->setStatut('Annuler');
                $em->getRepository(Facture::class)->add($facture);
                $id = $fact->getCommandeCli();
                return new JsonResponse("La commande a été annulée avec succès");
            }else{
                return new JsonResponse("Erreur, facture non trouvée!!!§§§§msg_error");       
            }
        } 
    }

    #[Route('/show/{id}', name: 'app_commande_client_show', methods: ['GET','POST'])]
    public function show(CommandeClient $commandeClient):Response
    {
        $results['html'] = $this->renderView('commande_client/show.html.twig', ['commande_client' => $commandeClient,]);
        return new JsonResponse($results);
    }

    #[Route('/{id}/edit', name: 'app_commande_client_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, CommandeClient $commandeClient, CommandeClientRepository $commandeClientRepository): Response
    {
        $form = $this->createForm(CommandeClientType::class, $commandeClient);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $commandeClientRepository->add($commandeClient);
            return $this->redirectToRoute('app_commande_client_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('commande_client/edit.html.twig', [
            'commande_client' => $commandeClient,
            'form' => $form,
        ]);
    }

   

    #[Route('/{id}', name: 'app_commande_client_delete', methods: ['POST'])]
    public function delete(Request $request, CommandeClient $commandeClient, CommandeClientRepository $commandeClientRepository): Response
    {
        if ($this->isCsrfTokenValid('delete' . $commandeClient->getId(), $request->request->get('_token'))) {
            $commandeClientRepository->remove($commandeClient);
        }

        return $this->redirectToRoute('app_commande_client_index', [], Response::HTTP_SEE_OTHER);
    }
}
