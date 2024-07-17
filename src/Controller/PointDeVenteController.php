<?php

namespace App\Controller;

use App\Entity\PointDeVente;
use App\Form\PointDeVenteType;
use App\Repository\PointDeVenteRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/admin/point/de/vente')]
class PointDeVenteController extends AbstractController
{
    #[Route('/', name: 'app_point_de_vente_index', methods: ['GET','POST'])]
    public function index(Request $request,PointDeVenteRepository $pointDeVenteRepository): Response
    {

        $pointDeVente = new PointDeVente();
        $form = $this->createForm(PointDeVenteType::class, $pointDeVente);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $pointDeVenteRepository->add($pointDeVente);
            if($pointDeVente->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }
        return $this->renderForm('point_de_vente/index.html.twig', [
            'point_de_ventes' => $pointDeVenteRepository->findAll(),
            'point_de_vente' => $pointDeVente,
            'form' => $form,
        ]);
    }

    #[Route('/new', name: 'app_point_de_vente_new', methods: ['GET', 'POST'])]
    public function new(Request $request, PointDeVenteRepository $pointDeVenteRepository): Response
    {
        $pointDeVente = new PointDeVente();
        $form = $this->createForm(PointDeVenteType::class, $pointDeVente);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $pointDeVenteRepository->add($pointDeVente);
            return $this->redirectToRoute('app_point_de_vente_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('point_de_vente/new.html.twig', [
            'point_de_vente' => $pointDeVente,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_point_de_vente_show', methods: ['GET'])]
    public function show(PointDeVente $pointDeVente): Response
    {
        return $this->render('point_de_vente/show.html.twig', [
            'point_de_vente' => $pointDeVente,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_point_de_vente_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, PointDeVente $pointDeVente, PointDeVenteRepository $pointDeVenteRepository): Response
    {
        $form = $this->createForm(PointDeVenteType::class, $pointDeVente);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $pointDeVenteRepository->add($pointDeVente);
            return $this->redirectToRoute('app_point_de_vente_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('point_de_vente/edit.html.twig', [
            'point_de_vente' => $pointDeVente,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_point_de_vente_delete', methods: ['POST'])]
    public function delete(Request $request, PointDeVente $pointDeVente, PointDeVenteRepository $pointDeVenteRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$pointDeVente->getId(), $request->request->get('_token'))) {
            $pointDeVenteRepository->remove($pointDeVente);
        }

        return $this->redirectToRoute('app_point_de_vente_index', [], Response::HTTP_SEE_OTHER);
    }
}
