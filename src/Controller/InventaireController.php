<?php

namespace App\Controller;

use App\Entity\Inventaire;
use App\Form\InventaireType;
use App\Form\SortieType;
use App\Repository\InventaireRepository;
use App\Repository\MagasinRepository;
use App\Repository\ModelSignataireRepository;
use App\Repository\ProduitCondMagRepository;
use App\Repository\SocieteRepository;
use App\Services\LibrairieService;
use SessionIdInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/admin/inventaire')]
class InventaireController extends AbstractController
{
    #[Route('/', name: 'app_inventaire_index', methods: ['GET', 'POST'])]
    public function index(Request $request, InventaireRepository $inventaireRepository): Response
    {
        $inventaire = new Inventaire();
        $form = $this->createForm(InventaireType::class, $inventaire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $inventaireRepository->add($inventaire);
            if($inventaire->getId() != null)
                return new JsonResponse("Inventaire effectué avec succès.");
        }

        return $this->renderForm('inventaire/index.html.twig', [
            'inventaires' => $inventaireRepository->findAll(),
            'nbInv' => sizeof($inventaireRepository->findAll()),
            'inventaire' => $inventaire,
            'form' => $form,
        ]);
    }

    #[Route('/fiche/inventaire/', name: 'fiche_inventaire', methods: ['GET', 'POST'])]
    public function ficheInv( MagasinRepository $magRe, Request $request,SocieteRepository $sociRep,ProduitCondMagRepository $prodMag, LibrairieService $library,ModelSignataireRepository $modelRep ,
     InventaireRepository $inventaireRepository, SessionInterface $session): Response
    {
        $pv = $session->get('pointVente', []);
        //dd($inventaire);
        $ent = null;
        if($sociRep->findAll()){
            $ent = ($sociRep->findAll())[0];
        }
        $result = [];

        foreach($magRe->findBy(['pointVente' => $pv->getId()]) as $mag){
            if($prodMag->produitMagasin($mag->getId())){
                $result[] = array(
                    'magasin'=> $mag->getNomMag(),
                    'produit'=> $prodMag->produitMagasin($mag->getId())
                );
            }
        }
        // dd($result);
        $signataires = $modelRep->findOneBy(["estDefault"=>true]);
        $htmlPage = $this->renderView("inventaire/fiche/fiche.html.twig",[
            'format'=>"A4-P",
            'signataires'=>$signataires,
            'societe'=>$ent,
            'produits'=>$result
        ]);
        return $library->mpdf([$htmlPage],"Fiche_inventaire","A4-P");
    }

    
    #[Route('/cloture/inventaire/{id}', name: 'app_cloture_inventaire', methods: ['GET', 'POST'])]
    public function cloturer(Request $request,Inventaire $inventaire, InventaireRepository $inventaireRepository): Response
    {
        dd($inventaire);

        return $this->renderForm('inventaire/new.html.twig', [
            // 'inventaire' => $inventaire,
            // 'form' => $form,
        ]);
    }

    #[Route('/new', name: 'app_inventaire_new', methods: ['GET', 'POST'])]
    public function new(Request $request, InventaireRepository $inventaireRepository): Response
    {
        $inventaire = new Inventaire();
        $form = $this->createForm(InventaireType::class, $inventaire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $inventaireRepository->add($inventaire);
            return $this->redirectToRoute('app_inventaire_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('inventaire/new.html.twig', [
            'inventaire' => $inventaire,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_inventaire_show', methods: ['GET'])]
    public function show(Inventaire $inventaire): Response
    {
        $form = $this->createForm(InventaireType::class, $inventaire)->createView();
        $view = $this->render('inventaire/partials/_card_show.html.twig', compact('inventaire', 'form'));
        return $view;
    }

    #[Route('/{id}/edit', name: 'app_inventaire_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Inventaire $inventaire, InventaireRepository $inventaireRepository): Response
    {
        $form = $this->createForm(InventaireType::class, $inventaire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $inventaireRepository->add($inventaire);
            return $this->redirectToRoute('app_inventaire_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('inventaire/edit.html.twig', [
            'inventaire' => $inventaire,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_inventaire_delete', methods: ['POST'])]
    public function delete(Request $request, Inventaire $inventaire, InventaireRepository $inventaireRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$inventaire->getId(), $request->request->get('_token'))) {
            $inventaireRepository->remove($inventaire);
        }

        return $this->redirectToRoute('app_inventaire_index', [], Response::HTTP_SEE_OTHER);
    }
}
