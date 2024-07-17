<?php

namespace App\Controller;

use App\Entity\Facture;
use App\Form\FactureType;
use App\Repository\CommandeClientRepository;
use App\Repository\CommandeFrsRepository;
use App\Repository\FactureRepository;
use App\Repository\ModelSignataireRepository;
use App\Repository\SocieteRepository;
use App\Services\LibrairieService;
use NumberFormatter;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/admin/facture')]
class FactureController extends AbstractController
{
    #[Route('/', name: 'app_facture_index', methods: ['GET', 'POST'])]
    public function index(Request $request,FactureRepository $factureRepository): Response
    {
        
        $facture = new Facture();
        $form = $this->createForm(FactureType::class, $facture);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $factureRepository->add($facture);
            return $this->redirectToRoute('app_facture_index', [], Response::HTTP_SEE_OTHER);
        }
        return $this->renderForm('facture/index.html.twig', [
            'facture' => $facture,
            'form' => $form,
        ]);
    }

    #[Route('/impression/docu/facture/facture', name: 'imprime_facture_impr_simple', methods: ['GET', 'POST'])]
    public function impression(LibrairieService $library,SocieteRepository $sociRep, ModelSignataireRepository $modelRep, Request $request, 
    FactureRepository $factRe, CommandeClientRepository $commandeRepo){

        $id = $request->request->get('id');
        $format = "A4-P";
        $ent = null;
        if($sociRep->findAll()){
            $ent = ($sociRep->findAll())[0];
        }
        //dd($format);
        $signataires = $modelRep->findOneBy(["estDefault"=>true]);
        $facture = $factRe->find($id);
        // $commande = $facture->getCommandeCli();
        $commande = $commandeRepo->find($facture->getCommandeCli()->getId());
        // dd($commande);
        // dd($facture->getCommandeCli()->getId());

        $htmlPage = $this->renderView("commande_client/document/factureA4_.html.twig",[
            'facture'=>$facture,
            'commande'=>$commande,
            'format'=>$format,
            'signataires'=>$signataires,
            'societe'=>$ent,
            // "qr"=>  $library->codeQr("Value"),
            'qr'=> ($commande->getEstNormalisee()) ? $library->codeQr($facture->getMecefQrCode()) : null,
            'valeur'=> $library->getFormattedNumber(value:$facture->getMontantTotal(),  style: NumberFormatter::SPELLOUT)
        ]);
        //return $htmlPage;
        return $library->mpdf([$htmlPage],"Facture",$format);
    }

    #[Route('/new', name: 'app_facture_new', methods: ['GET', 'POST'])]
    public function new(Request $request, FactureRepository $factureRepository): Response
    {
        $facture = new Facture();
        $form = $this->createForm(FactureType::class, $facture);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $factureRepository->add($facture);
            return $this->redirectToRoute('app_facture_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('facture/new.html.twig', [
            'facture' => $facture,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_facture_show', methods: ['GET'])]
    public function show(Facture $facture): Response
    {
        return $this->render('facture/show.html.twig', [
            'facture' => $facture,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_facture_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Facture $facture, FactureRepository $factureRepository): Response
    {
        $form = $this->createForm(FactureType::class, $facture);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $factureRepository->add($facture);
            return $this->redirectToRoute('app_facture_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('facture/edit.html.twig', [
            'facture' => $facture,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_facture_delete', methods: ['POST'])]
    public function delete(Request $request, Facture $facture, FactureRepository $factureRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$facture->getId(), $request->request->get('_token'))) {
            $factureRepository->remove($facture);
        }

        return $this->redirectToRoute('app_facture_index', [], Response::HTTP_SEE_OTHER);
    }
}
