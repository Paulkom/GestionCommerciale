<?php

namespace App\Controller;

use App\Entity\TypeDepense;
use App\Form\TypeDepenseType;
use App\Repository\TypeDepenseRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/admin/type_depense')]
class TypeDepenseController extends AbstractController
{
    #[Route('/', name: 'app_type_depense_index', methods: ['GET','POST'])]
    public function index(Request $request, TypeDepenseRepository $typeDepenseRepository): Response
    {
        $typeDepense = new TypeDepense();
        $form = $this->createForm(TypeDepenseType::class, $typeDepense);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $typeDepenseRepository->add($typeDepense);
            if($typeDepense->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }

        return $this->renderForm('type_depense/index.html.twig', [
            'type_depense' => $typeDepense,
            'form' => $form,
        ]);
    }

    #[Route('/new', name: 'app_type_depense_new', methods: ['GET', 'POST'])]
    public function new(Request $request, TypeDepenseRepository $typeDepenseRepository): Response
    {
        $typeDepense = new TypeDepense();
        $form = $this->createForm(TypeDepenseType::class, $typeDepense);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $typeDepenseRepository->add($typeDepense);
            return $this->redirectToRoute('app_type_depense_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('type_depense/new.html.twig', [
            'type_depense' => $typeDepense,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_type_depense_show', methods: ['GET'])]
    public function show(TypeDepense $typeDepense): Response
    {
        return $this->render('type_depense/show.html.twig', [
            'type_depense' => $typeDepense,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_type_depense_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, TypeDepense $typeDepense, TypeDepenseRepository $typeDepenseRepository): Response
    {
        $form = $this->createForm(TypeDepenseType::class, $typeDepense);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $typeDepenseRepository->add($typeDepense);
            return $this->redirectToRoute('app_type_depense_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('type_depense/edit.html.twig', [
            'type_depense' => $typeDepense,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_type_depense_delete', methods: ['POST'])]
    public function delete(Request $request, TypeDepense $typeDepense, TypeDepenseRepository $typeDepenseRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$typeDepense->getId(), $request->request->get('_token'))) {
            $typeDepenseRepository->remove($typeDepense);
        }

        return $this->redirectToRoute('app_type_depense_index', [], Response::HTTP_SEE_OTHER);
    }
}
