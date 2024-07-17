<?php

namespace App\Controller;

use App\Entity\ListCaisse;
use App\Form\ListCaisseType;
use App\Repository\ListCaisseRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/admin/list/caisse')]
class ListCaisseController extends AbstractController
{
    #[Route('/', name: 'app_list_caisse_index', methods: ['GET','POST'])]
    public function index(Request $request, ListCaisseRepository $listCaisseRepository): Response
    {

        $listCaisse = new ListCaisse();
        $form = $this->createForm(ListCaisseType::class, $listCaisse);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $listCaisseRepository->add($listCaisse);
            if($listCaisse->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }
        return $this->renderForm('list_caisse/index.html.twig', [
            'list_caisses' => $listCaisseRepository->findAll(),
            'form' => $form,
        ]);

        
    }

    #[Route('/new', name: 'app_list_caisse_new', methods: ['GET', 'POST'])]
    public function new(Request $request, ListCaisseRepository $listCaisseRepository): Response
    {
        $listCaisse = new ListCaisse();
        $form = $this->createForm(ListCaisseType::class, $listCaisse);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $listCaisseRepository->add($listCaisse);
            return $this->redirectToRoute('app_list_caisse_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('list_caisse/new.html.twig', [
            'list_caisse' => '',
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_list_caisse_show', methods: ['GET'])]
    public function show(ListCaisse $listCaisse): Response
    {
        return $this->render('list_caisse/show.html.twig', [
            'list_caisse' => $listCaisse,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_list_caisse_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, ListCaisse $listCaisse, ListCaisseRepository $listCaisseRepository): Response
    {
        $form = $this->createForm(ListCaisseType::class, $listCaisse);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $listCaisseRepository->add($listCaisse);
            return $this->redirectToRoute('app_list_caisse_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('list_caisse/edit.html.twig', [
            'list_caisse' => $listCaisse,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_list_caisse_delete', methods: ['POST'])]
    public function delete(Request $request, ListCaisse $listCaisse, ListCaisseRepository $listCaisseRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$listCaisse->getId(), $request->request->get('_token'))) {
            $listCaisseRepository->remove($listCaisse);
        }

        return $this->redirectToRoute('app_list_caisse_index', [], Response::HTTP_SEE_OTHER);
    }
}
