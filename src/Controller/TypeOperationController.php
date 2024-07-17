<?php

namespace App\Controller;

use App\Entity\TypeOperation;
use App\Form\TypeOperationType;
use App\Repository\TypeOperationRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/admin/type/operation')]
class TypeOperationController extends AbstractController
{
    #[Route('/', name: 'app_type_operation_index', methods: ['GET','POST'])]
    public function index(Request $request,TypeOperationRepository $typeOperationRepository): Response
    {
        $typeOperation = new TypeOperation();
        $form = $this->createForm(TypeOperationType::class, $typeOperation);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $typeOperationRepository->add($typeOperation);
            if($typeOperation->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }
        return $this->renderForm('type_operation/index.html.twig', [
            'type_operations' => $typeOperationRepository->findAll(),
            'type_operation' => $typeOperation,
            'form' => $form,
        ]);
    }



    #[Route('/{id}', name: 'app_type_operation_show', methods: ['GET'])]
    public function show(TypeOperation $typeOperation): Response
    {
        return $this->render('type_operation/show.html.twig', [
            'type_operation' => $typeOperation,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_type_operation_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, TypeOperation $typeOperation, TypeOperationRepository $typeOperationRepository): Response
    {
        $form = $this->createForm(TypeOperationType::class, $typeOperation);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $typeOperationRepository->add($typeOperation);
            return $this->redirectToRoute('app_type_operation_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('type_operation/edit.html.twig', [
            'type_operation' => $typeOperation,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_type_operation_delete', methods: ['POST'])]
    public function delete(Request $request, TypeOperation $typeOperation, TypeOperationRepository $typeOperationRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$typeOperation->getId(), $request->request->get('_token'))) {
            $typeOperationRepository->remove($typeOperation);
        }

        return $this->redirectToRoute('app_type_operation_index', [], Response::HTTP_SEE_OTHER);
    }
}
