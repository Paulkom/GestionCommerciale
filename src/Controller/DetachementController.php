<?php

namespace App\Controller;

use App\Entity\Detachement;
use App\Form\DetachementType;
use App\Entity\ProduitCondMag;
use App\Entity\ProduitConditionnement;
use App\Repository\DetachementRepository;
use App\Repository\ProduitCondMagRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use App\Repository\ProduitConditionnementRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/admin/detachement')]
class DetachementController extends AbstractController
{
    #[Route('/', name: 'app_detachement_index', methods: ['GET', 'POST'])]
    public function index(Request $request, DetachementRepository $detachementRepository): Response
    {
        //dd($detachementRepository->find(1));
        $detachement = new Detachement();
        $form = $this->createForm(DetachementType::class, $detachement);
        $form->handleRequest($request);
        if($form->isSubmitted() && $form->isValid()) {
            $detachement->setUserDet($this->getUser());
            
            $detachementRepository->add($detachement);
            if($detachement->getId() != null)
                return new JsonResponse("Approvisionnement éffectué avec succès.");
        }
        return $this->renderForm('detachement/index.html.twig', [
            'detachement' => $detachement,
            'form' => $form,
        ]);
    }

    #[Route('/new', name: 'app_detachement_new', methods: ['GET', 'POST'])]
    public function new(Request $request, DetachementRepository $detachementRepository): Response
    {
        $detachement = new Detachement();
        $form = $this->createForm(DetachementType::class, $detachement);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $detachementRepository->add($detachement);
            return $this->redirectToRoute('app_detachement_index', [], Response::HTTP_SEE_OTHER);
        }
        return $this->renderForm('detachement/new.html.twig', [
            'detachement' => $detachement,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/loader/magasin/produit/condi", name="app_loader_mag_prod_comd", methods={"GET", "POST"})
     */
    public function loadMagsProdCom(Request $request,ProduitCondMagRepository $produitCondMagRepository)
    {
        set_time_limit(0);
        $em = $this->getDoctrine()->getManager();
        $id = $request->query->get('id');

        /** @var ProduitCondMag[] $produitCondMag */
        $produictcommanders = $produitCondMagRepository->findBy(['magasin' => $id]);
        $options = [];
        $i =0;
        $options[$i] = '<option >Sélectionnez le produit</option>';
        foreach ($produictcommanders as $key => $promag) {
            $quantit = $promag->getQteStockMag();
            if((int)$quantit > 0){
                ++$i;
                $options[$i] = '<option value="'. $promag->getId() . '"data-idprod="'. $promag->getProduitConditionnement()->getProduit()->getId() . '" data-idcond="'. $promag->getProduitConditionnement()->getConditionnement()->getId() . '" data-stockmag="'. $promag->getQteStockMag() .'" data-qtecond="' . $promag->getProduitConditionnement()->getQteCond() . '">' .$promag->getProduitConditionnement()->getProduit()->getNomProd() . ' ['. $promag->getProduitConditionnement()->getConditionnement()->getLibelleCond().'] </option>';
            }
        }
        return new JsonResponse($options);
    }


     /**
     * @Route("/loader/magasin/produit/deta", name="app_loader_deta_prod_comd", methods={"GET", "POST"})
     */
    public function app_loader_deta_prod_comd(Request $request,ProduitConditionnementRepository $produitConditionnementRepository)
    {
        set_time_limit(0);
        $em = $this->getDoctrine()->getManager();
        $id = $request->query->get('id');
        $idcond = $request->query->get('idcond');

        /** @var ProduitConditionnement[] $produitConditionnement */
        $produitConditionnements = $produitConditionnementRepository->findBy(['produit' => $id]);

        $options = [];
        $i = 0;
        $options[$i] = '<option>Sélectionnez le produit</option>';
        foreach ($produitConditionnements as $key => $pro) {
            if($pro->getConditionnement()->getId() != $idcond ){
                ++$i;
                $options[$i] = '<option value="'. $pro->getId() .'" " data-stock="'. $pro->getQteStockCond().'" data-qtecond="'.$pro->getQteCond().'">' .$pro->getProduit()->getNomProd() . ' ['. $pro->getConditionnement()->getLibelleCond().'] </option>';
            }
        }
        return new JsonResponse($options);
    }
    
    #[Route('/{id}', name: 'app_detachement_show', methods: ['GET'])]
    public function show(Detachement $detachement): Response
    {
        return $this->render('detachement/show.html.twig', [
            'detachement' => $detachement,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_detachement_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Detachement $detachement, DetachementRepository $detachementRepository): Response
    {
        $form = $this->createForm(DetachementType::class, $detachement);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $detachementRepository->add($detachement);
            return $this->redirectToRoute('app_detachement_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('detachement/edit.html.twig', [
            'detachement' => $detachement,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_detachement_delete', methods: ['POST'])]
    public function delete(Request $request, Detachement $detachement, DetachementRepository $detachementRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$detachement->getId(), $request->request->get('_token'))) {
            $detachementRepository->remove($detachement);
        }

        return $this->redirectToRoute('app_detachement_index', [], Response::HTTP_SEE_OTHER);
    }
}
