<?php

namespace App\Controller;

use NumberFormatter;
use App\Entity\Facture;
use App\Entity\Paiement;
use App\Form\PaiementType;
use App\Entity\Transaction;
use App\Entity\TypeOperation;
use App\Services\LibrairieService;
use App\Repository\CaisseRepository;
use App\Repository\FactureRepository;
use App\Repository\SocieteRepository;
use App\Repository\PaiementRepository;
use App\Repository\CommandeClientRepository;
use App\Repository\ModelSignataireRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Serializer\Encoder\JsonEncode;

#[Route('/admin/paiement')]
class PaiementController extends AbstractController
{
    #[Route('/', name: 'app_paiement_index', methods: ['GET','POST'])]
    public function index(Request $request,PaiementRepository $paiementRepository,CaisseRepository $caisseRepository, CommandeClientRepository $commandeClientRepository, FactureRepository $factureRepository): Response
    {
        $paiement = new Paiement();
        $form = $this->createForm(PaiementType::class, $paiement);
        $form->handleRequest($request);

        $error = false;
        if ($form->isSubmitted() && $form->isValid()) {
            //dump($paiement->getModePaiement()->getLibelle());
            $session =$request->getSession();
        
            if ($session->get('caisse')) {
                if (str_contains($paiement->getModePaiement()->getLibelle(),'Compte')) {
                    $em = $this->getDoctrine()->getManager();
                    $transaction = new Transaction();
                    $typeOp = $em->getRepository(TypeOperation::class)->findOneBy(['libelle'=>'Retrait']);
                    //dump($typeOp );
                    if ($typeOp) {
                        $transaction->setTypeOperation($typeOp);
                        $transaction->setMontantTransac($paiement->getMontantPaye());
                        $solde = $paiement->getFacture()->getCommandeCli()->getAcheteur()->getComptes()[0]->getSolde();
                        if($solde < $paiement->getMontantPaye()) {
                            $error = true;
                            $this->addFlash(
                                'msg',
                                'Impossible d\'enregistrer ce retrait, votre solde est insuffisant.'
                            );
                            return new JsonResponse('Impossible d\'enregistrer ce retrait, votre solde est insuffisant.');
                        }else {
                            $compte = $paiement->getFacture()->getCommandeCli()->getAcheteur()->getComptes()[0];
                            if ($compte) {
                                $transaction->setClient($paiement->getFacture()->getCommandeCli()->getAcheteur());
                                $compte->setSolde($compte->getSolde() - $paiement->getMontantPaye());
                                $transaction->setCompte($compte);
                                $transaction->setModePaiement($paiement->getModePaiement());

                                if($paiement->getMontantRAPayer() == 0 ){
                                    $paiement->getFacture()->setStatut('payer');
                                    $paiement->getFacture()->getCommandeCli()->setStatut('payer');
                                }
                                
                            }else{
                                $error = true;
                                $this->addFlash(
                                    'msg',
                                    'Impossible d\'enregistrer ce retrait, votre solde est insuffisant.'
                                );
                                return new JsonResponse('Impossible d\'enregistrer ce retrait, votre solde est insuffisant.');
                            }
                        }
                        //dump($transaction);
                        $em->persist($transaction);
                        $paiement->setTransaction($transaction);
    
                    }else{
                        $error = true;
                        $this->addFlash(
                            'msg',
                            'le type d\'opération retrait n\'exite pas..'
                        );
                        return new JsonResponse("le type d\'opération retrait n'exite pas.");
                    } 
                }
            }else {
                return new JsonResponse("Veuillez ouvrir une caisse.");
            }
            if(!$error)
            {
                $paiement->getFacture()->setMontantRest($paiement->getMontantRAPayer());
                if((float)$paiement->getMontantRAPayer() != 0.00){
                    $paiement->getFacture()->getCommandeCli()->setStatut("Partielle");
                    $paiement->getFacture()->setStatut("Partielle");
                }else{
                    $paiement->getFacture()->getCommandeCli()->setStatut("Payée");
                    $paiement->getFacture()->setStatut("Payée");

                }
                // $factureRepository->add($facture,true);
                // $commandeClientRepository->add($commande,true);

                $paiement->setCaisse($caisseRepository->find($session->get('caisse')));
                $paiementRepository->add($paiement);
                if($paiement->getId() != null){
                    $paiement2 = new Paiement();
                    $form2 = $this->createForm(PaiementType::class, $paiement2);
                    //$form->handleRequest($request);
                    $html = $this->renderView('paiement/partials/_card_form.html.twig', ['paiement' => $paiement2,'form' => $form2->createView() ]);
                    $comp ="§".$paiement->getId()."§".$form->get("truc")->getData()."§".$html;
                    return new JsonResponse("Enregistrement éffectué avec succès.".$comp);
                }   
            } 
        }
        return $this->renderForm('paiement/index.html.twig', [
           // 'paiements' => $paiementRepository->findAll(),
            'paiement' => $paiement,
            'form' => $form,
            'error' => $error,
        ]);
    }

    #[Route('/doc/paiement/imprime', name: 'imprime_paiement_imprime_new', methods: ['GET', 'POST'])]
    public function imprime(Request $request, ModelSignataireRepository $modelRep, SocieteRepository $sociRep,  PaiementRepository $paieRep, LibrairieService $library){
        $id = $request->request->get('id');
        $format = "A4-P";
        $paiement = $paieRep->find($id);
        $signataires = $modelRep->findOneBy(["estDefault"=>true]);
        $ent = null;

        if($sociRep->findAll()){
            $ent = ($sociRep->findAll())[0];
        }
        $htmlPage = $this->renderView("paiement/document/recu.html.twig",[
            'paiement'=>$paiement,
            'format'=>$format,
            'signataires'=>$signataires,
            'societe'=>$ent,
            'valeur'=> $library->getFormattedNumber(value:$paiement->getMontantPaye(),  style: NumberFormatter::SPELLOUT)
        ]);
        // return $this->render("paiement/document/recu.html.twig",[
        //     'paiement'=>$paiement,
        //     'format'=>$format,
        //     'signataires'=>$signataires,
        //     'societe'=>$ent,
        //     'valeur'=> $library->getFormattedNumber(value:$paiement->getMontantPaye(),  style: NumberFormatter::SPELLOUT)
        // ]);
        // $numberToConvert = 150085;
        // $localeEnglish = "en_US"; // Or en_GB
        
        // $wordsFromValue = App\Controller\Numbers_Words::toWords($numberToConvert, $localeEnglish);
        // dd($wordsFromValue);
        return $library->mpdf([$htmlPage],"Recu",$format);
    }

    #[Route('/new', name: 'app_paiement_new', methods: ['GET', 'POST'])]
    public function new(Request $request, PaiementRepository $paiementRepository): Response
    {
        $paiement = new Paiement();
        $form = $this->createForm(PaiementType::class, $paiement);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $paiementRepository->add($paiement);
            return $this->redirectToRoute('app_paiement_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('paiement/new.html.twig', [
            'paiement' => $paiement,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_paiement_show', methods: ['GET'])]
    public function show(Paiement $paiement): Response
    {
        return $this->render('paiement/show.html.twig', [
            'paiement' => $paiement,
        ]);
    }

    #[Route('/facture/all-paiements', name: 'app_paiement_paiements_par_facture', methods: ['GET'])]
    public function paiementsParFacture(Request $request, FactureRepository $fr): Response
    {
        $id = $request->query->get("idFacture");
        $facture = $fr->find($id);
        $html = "";
        $reference = $facture->getRefFac();
        $name = $facture->getCommandeCli()->getAcheteur()->getNomClient();
        foreach ($facture->getPaiements() as $key => $pa) {
            $pa->getMontantPaye();
            $html .= '<div class="d-flex align-items-center bg-light-success rounded py-2 px-4 mb-2 me-3 col-sm-2">'
                        .'<div class="flex-grow-1 me-2">'
                            .'<a href="#" class="fw-bolder text-gray-800 text-hover-primary fs-6">'.$pa->getMontantPaye().'XOF</a>'
                            .'<span class="text-muted fw-bold d-block">'.date_format($pa->getDatePaie(),"d/m/Y").'</span>'
                        .'</div>'
                        .'<span class="fw-bolder text-success py-1">P'.$key + 1 .'</span>'
                    .'</div>';
        }
        $data['html'] = $html;
        $data['reference'] = $reference;
        $data['name'] = $name;
        return new JsonResponse($data);
    }

    #[Route('/{id}/edit', name: 'app_paiement_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Paiement $paiement, PaiementRepository $paiementRepository): Response
    {
        $form = $this->createForm(PaiementType::class, $paiement);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $paiementRepository->add($paiement);
            return $this->redirectToRoute('app_paiement_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('paiement/edit.html.twig', [
            'paiement' => $paiement,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_paiement_delete', methods: ['POST'])]
    public function delete(Request $request, Paiement $paiement, PaiementRepository $paiementRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$paiement->getId(), $request->request->get('_token'))) {
            $paiementRepository->remove($paiement);
        }

        return $this->redirectToRoute('app_paiement_index', [], Response::HTTP_SEE_OTHER);
    }
}
