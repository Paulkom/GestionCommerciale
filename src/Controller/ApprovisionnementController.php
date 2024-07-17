<?php

namespace App\Controller;

use App\Entity\ProduitCondAppro;
use App\Entity\Approvisionnement;
use App\Form\ApprovisionnementType;
use App\Form\LivraisonFournisseurType;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use App\Repository\ApprovisionnementRepository;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

/**
 * @Route("/admin/approvisionnement")
 */
class ApprovisionnementController extends AbstractController
{
    
    /**
     * @Route("/", name="app_approvisionnement_index", methods={"GET","POST"})
     */
    public function index(Request $request,ApprovisionnementRepository $approvisionnementRepository): Response
    {
        $approvisionnement = new Approvisionnement();
        $form = $this->createForm(ApprovisionnementType::class, $approvisionnement);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $approvisionnementRepository->add($approvisionnement);
            if($approvisionnement->getId() != null)
                return new JsonResponse("Approvisionnement éffectué avec succès.");
        }

        return $this->renderForm('approvisionnement/index.html.twig', [
            'approvisionnements' => $approvisionnementRepository->findAll(),
            'form' => $form,
        ]);
    }

   
    /**
     * @Route("/{id}", name="app_approvisionnement_show", methods={"GET"})
     */
    public function show(Approvisionnement $approvisionnement): Response
    {
        return $this->render('approvisionnement/show.html.twig', [
            'approvisionnement' => $approvisionnement,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_approvisionnement_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Approvisionnement $approvisionnement, ApprovisionnementRepository $approvisionnementRepository): Response
    {
        $form = $this->createForm(ApprovisionnementType::class, $approvisionnement);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $approvisionnementRepository->add($approvisionnement);
            return $this->redirectToRoute('app_approvisionnement_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('approvisionnement/edit.html.twig', [
            'approvisionnement' => $approvisionnement,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_approvisionnement_delete", methods={"POST"})
     */
    public function delete(Request $request, Approvisionnement $approvisionnement, ApprovisionnementRepository $approvisionnementRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$approvisionnement->getId(), $request->request->get('_token'))) {
            $approvisionnementRepository->remove($approvisionnement);
        }

        return $this->redirectToRoute('app_approvisionnement_index', [], Response::HTTP_SEE_OTHER);
    }
}
