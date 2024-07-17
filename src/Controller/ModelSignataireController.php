<?php

namespace App\Controller;

use App\Entity\ModelSignataire;
use App\Form\ModelSignataireType;
use App\Repository\ModelSignataireRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/admin/modele/signataire')]
class ModelSignataireController extends AbstractController
{
    /**
     * @Route("/", name="app_model_signataire_index", methods={"GET", "POST"})
     */
    public function index(Request $request, ModelSignataireRepository $modelSignataireRepository): Response
    {
        $modelSignataires = new ModelSignataire();
        $form = $this->createForm(ModelSignataireType::class, $modelSignataires);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $modelSignataireRepository->add($modelSignataires);
            if($modelSignataires->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }

        return $this->renderForm('model_signataire/index.html.twig', [
            'model_signataires' => $modelSignataireRepository->findAll(),
            'form' => $form,
        ]);
    }


    #[Route('/new', name: 'app_model_signataire_new', methods: ['GET', 'POST'])]
    public function new(Request $request, ModelSignataireRepository $modelSignataireRepository): Response
    {
        $modelSignataire = new ModelSignataire();
        $form = $this->createForm(ModelSignataireType::class, $modelSignataire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $modelSignataireRepository->add($modelSignataire);
            return $this->redirectToRoute('app_model_signataire_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('model_signataire/new.html.twig', [
            'model_signataire' => $modelSignataire,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/modal-show/{id}", name="app_model_show", methods={"GET", "POST"})
     */
    public function show(ModelSignataire $modelSignataire): Response
    {
        $view = $this->renderView('model_signataire/partials/_card_show.html.twig', compact('modelSignataire'));
        return new JsonResponse($view);
    }


    // #[Route('/{id}', name: 'app_model_signataire_show', methods: ['GET'])]
    // public function show(ModelSignataire $modelSignataire): Response
    // {
    //     return $this->render('model_signataire/show.html.twig', [
    //         'model_signataire' => $modelSignataire,
    //     ]);
    // }

    #[Route('/{id}/edit', name: 'app_model_signataire_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, ModelSignataire $modelSignataire, ModelSignataireRepository $modelSignataireRepository): Response
    {
        $form = $this->createForm(ModelSignataireType::class, $modelSignataire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $modelSignataireRepository->add($modelSignataire);
            return $this->redirectToRoute('app_model_signataire_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('model_signataire/edit.html.twig', [
            'model_signataire' => $modelSignataire,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_model_signataire_delete', methods: ['POST'])]
    public function delete(Request $request, ModelSignataire $modelSignataire, ModelSignataireRepository $modelSignataireRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$modelSignataire->getId(), $request->request->get('_token'))) {
            $modelSignataireRepository->remove($modelSignataire);
        }

        return $this->redirectToRoute('app_model_signataire_index', [], Response::HTTP_SEE_OTHER);
    }
}
