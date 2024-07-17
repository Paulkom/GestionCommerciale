<?php

namespace App\Controller;

use App\Entity\Client;
use App\Entity\FactureProforma;
use App\Entity\Facture;
use App\Entity\ModePaiement;
use App\Entity\Paiement;
use App\Form\FactureProformaType;
use App\Repository\FactureProformaRepository;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\ProduitCondComClit;
use App\Repository\ModelSignataireRepository;
use App\Repository\SocieteRepository;
use App\Services\LibrairieService;
use DateTime;
use NumberFormatter;
use Symfony\Component\HttpFoundation\JsonResponse;

#[Route('/admin/factureproforma')]
class FactureProformaController extends AbstractController
{
    #[Route('/', name: 'app_facture_proforma_index', methods: ['GET','POST'])]
    public function index(Request $request, EntityManagerInterface $em, FactureProformaRepository $factureProformaRepository): Response
    {
        $factureProforma = new FactureProforma();
        $client = $em->getRepository(Client::class)->findOneBy(['nom' => "Ordinaire"]);
        $factureProforma->setAcheteur($client);
        $form = $this->createForm(FactureProformaType::class, $factureProforma);
        $form->handleRequest($request);

        if($form->isSubmitted() && $form->isValid()) {
            $facture_proforma = $request->request->get("facture_proforma");
            
            if (!$factureProforma->getAcheteur()) {
                $client = new Client;
                $date = null;
                if ($facture_proforma['dateNais']) {
                    $dd = $facture_proforma['dateNais'] ." 00:00:00";
                    $date = new DateTime($dd);
                }
                $client->setStatut($facture_proforma["statut"]);
                $client->setAdresse($facture_proforma["adresse"]);
                $client->setEmail($facture_proforma["email"]);
                $client->setIfu($facture_proforma["ifu"]);
                $client->setTelephone1($facture_proforma["telephone1"]);
                $client->setTelephone2($facture_proforma["telephone2"]);
                $client->setDateNais($date);
                if($facture_proforma["statut"] == "Physique"){
                    $client->setNom($facture_proforma["nom"]);
                    $client->setPrenom($facture_proforma["prenom"]);
                }elseif($facture_proforma["statut"] == "Moral"){
                    $client->setDenomination($facture_proforma["denomination"]);
                    $client->setRaisonSociale($facture_proforma["raisonSociale"]);
                    $client->setRccm($facture_proforma["rccm"]);
                    $client->setSigle($facture_proforma["sigle"]);
                }
                $em->persist($client);
                $factureProforma->setAcheteur($client);
            }
            //dd("Bonjour je veux m'assurer que c'est ici");
            $factureProformaRepository->add($factureProforma);

            if($factureProforma->getId() != null){
                //Paul /* Ici je récupère l'id de l"enregistrement ainsi que le status du truc pour savoir quel bouton a été cliqué */
                $comp ="§".$factureProforma->getId()."§".$form->get("truc")->getData();
                return new JsonResponse("La facture proforma a été créé avec succès.".$comp);
            }
        }
        return  $this->renderForm('facture_proforma/index.html.twig', [
            'facture_proforma' => $factureProforma,
            'form' => $form,
            'facture_proformas' => $factureProformaRepository->findAll(),
        ]);
        //dd($view);
    }

    #[Route('/impression/docu/facture/pro/format', name: 'imprime_facture_impr', methods: ['GET', 'POST'])]
    public function impression( SocieteRepository $sociRep, ModelSignataireRepository $modelRep, LibrairieService $library,Request $request, FactureProformaRepository $factRe){
        $id = $request->request->get('id');
        $format = "A4-P";
        $ent = null;

        if($sociRep->findAll()){
            $ent = ($sociRep->findAll())[0];
        }
        //dd($format);
        $facture = $factRe->find($id);
        $signataires = $modelRep->findOneBy(["estDefault"=>true]);
        $htmlPage = $this->renderView("facture_proforma/document/facture.html.twig",[
            'facture'=>$facture,
            'format'=>$format,
            'signataires'=>$signataires,
            'societe'=>$ent,
            'valeur'=> $library->getFormattedNumber(value:$facture->getMontantTtc(),  style: NumberFormatter::SPELLOUT)
        ]);
        //return $htmlPage;
        return $library->mpdf([$htmlPage],"Facture",$format);
    }

    #[Route('/new', name: 'app_facture_proforma_new', methods: ['GET', 'POST'])]
    public function new(Request $request, FactureProformaRepository $factureProformaRepository): Response
    {
        $factureProforma = new FactureProforma();
        $form = $this->createForm(FactureProformaType::class, $factureProforma);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $factureProformaRepository->add($factureProforma);
            return $this->redirectToRoute('app_facture_proforma_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('facture_proforma/new.html.twig', [
            'facture_proforma' => $factureProforma,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/loader/select-request", name="app_select_loader", methods={"GET", "POST"})
     */
    public function loadProduitByCommande(Request $request)
    {
        set_time_limit(0);
        $em = $this->getDoctrine()->getManager();
        $id = $request->query->get('id');
        
        /** @var ProduitCondComClit[] $produictcommanders */
        $produictcommanders = $em->getRepository(FactureProforma::class)->find($id)->getProduitCondComClits();
       
        $options = '<option value="">Sélectionnez un produit...</option>';
        foreach ($produictcommanders as $produit)
        {
            $options .= '<option  value="'.$produit->getId().'" data-restaliv="'.$produit->getRestAliv().'" data-prix="'.$produit->getPrix().'" data-qtite="'.$produit->getQtite().'" data-montant="'.$produit->getMontant().'">'.$produit->getProduit().'</option>';
        }
        return new JsonResponse([$options]);
    }



    #[Route('/{id}', name: 'app_facture_proforma_show', methods: ['GET'])]
    public function show(FactureProforma $factureProforma): Response
    {
        return $this->render('facture_proforma/show.html.twig', [
            'facture_proforma' => $factureProforma,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_facture_proforma_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, FactureProforma $factureProforma, FactureProformaRepository $factureProformaRepository): Response
    {
        $form = $this->createForm(FactureProformaType::class, $factureProforma);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $factureProformaRepository->add($factureProforma);
            return $this->redirectToRoute('app_facture_proforma_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('facture_proforma/edit.html.twig', [
            'facture_proforma' => $factureProforma,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_facture_proforma_delete', methods: ['POST'])]
    public function delete(Request $request, FactureProforma $factureProforma, FactureProformaRepository $factureProformaRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$factureProforma->getId(), $request->request->get('_token'))) {
            $factureProformaRepository->remove($factureProforma);
        }

        return $this->redirectToRoute('app_facture_proforma_index', [], Response::HTTP_SEE_OTHER);
    }


}
