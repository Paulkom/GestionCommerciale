<?php

namespace App\Controller;

use App\Entity\Produit;
use App\Entity\ProduitConditionnement;
use App\Form\ProduitType;
use App\Repository\ProduitConditionnementRepository;
use App\Repository\ProduitRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/admin/produit")
 */
class ProduitController extends AbstractController
{
    /**
     * @Route("/", name="app_produit_index", methods={"GET", "POST"})
     */
    public function index(Request $request, ProduitRepository $produitRepository): Response
    {
        $produit = new Produit();
        $form = $this->createForm(ProduitType::class, $produit);
        $form->handleRequest($request);


        if ($form->isSubmitted() && $form->isValid()) {
            $produit->setStock(0);
            $produitRepository->add($produit);
            if($produit->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }

        return $this->renderForm('produit/index.html.twig', [
            'produits'      => $produitRepository->findAll(),
            'form'          => $form,
        ]);
    }

    /**
     * @Route("/stock/", name="app_stock_en_unite", methods={"GET", "POST"})
     */
    public function stockUnitaire(Request $request, ProduitRepository $produitRepository): Response
    {
        return $this->renderForm('produit/stock.html.twig', [
            'produits' => $produitRepository->findAll()
        ]);
    }

    /**
     * @Route("/modal-show/{id}", name="app_produit_show", methods={"GET", "POST"})
     */
    public function show(Produit $produit): Response
    {
        $view = $this->renderView('produit/partials/_card_show.html.twig', compact('produit'));
        return new JsonResponse($view);
    }

    /**
     * @Route("/{id}", name="app_produit_delete", methods={"POST"})
     */
    public function delete(Request $request, Produit $produit, ProduitRepository $produitRepository): Response
    {
        $id = $produit->getId();
        if ($this->isCsrfTokenValid('delete'.$produit->getId(), $request->request->get('token'))) {
            $produitRepository->remove($produit);
            $id = null;
        }

        return new JsonResponse([$id, $request->request->get('token')]);
    }

    /**
     * @Route("/recuperer/produit/conditionnement/json", name="app_get_prodCond_json", methods={"GET", "POST"})
     */
    public function getProdCond(Request $request, ProduitConditionnementRepository $produitCond)
    {
        $parameters = $request->query->all();
        $entity = $produitCond->find($parameters['id']);
        return new JsonResponse([
            'prix' => $entity->getPrixDeVente(),
            'qte'  => $entity->getQteStockCond(),
        ]);
    }
}
