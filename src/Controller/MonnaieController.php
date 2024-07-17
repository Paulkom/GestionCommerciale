<?php

namespace App\Controller;

use App\Entity\Monnaie;
use App\Form\MonnaieType;
use App\Repository\MonnaieRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/admin/monnaie')]
class MonnaieController extends AbstractController
{
    #[Route('/', name: 'app_monnaie_index', methods: ['GET','POST'])]
    public function index(Request $request, MonnaieRepository $monnaieRepository): Response
    {
        $monnaie = new Monnaie();
        $form = $this->createForm(MonnaieType::class, $monnaie);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $monnaieRepository->add($monnaie);
            if($monnaie->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }
        return $this->renderForm('monnaie/index.html.twig', [
            'monnaies' => $monnaieRepository->findAll(),
            'form' => $form,
        ]);
    }

    #[Route('/new', name: 'app_monnaie_new', methods: ['GET', 'POST'])]
    public function new(Request $request, MonnaieRepository $monnaieRepository): Response
    {
        $monnaie = new Monnaie();
        $form = $this->createForm(MonnaieType::class, $monnaie);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $monnaieRepository->add($monnaie);
            return $this->redirectToRoute('app_monnaie_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('monnaie/new.html.twig', [
            'monnaie' => $monnaie,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_monnaie_show', methods: ['GET'])]
    public function show(Monnaie $monnaie): Response
    {
        return $this->render('monnaie/show.html.twig', [
            'monnaie' => $monnaie,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_monnaie_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Monnaie $monnaie, MonnaieRepository $monnaieRepository): Response
    {
        $form = $this->createForm(MonnaieType::class, $monnaie);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $monnaieRepository->add($monnaie);
            return $this->redirectToRoute('app_monnaie_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('monnaie/edit.html.twig', [
            'monnaie' => $monnaie,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_monnaie_delete', methods: ['POST'])]
    public function delete(Request $request, Monnaie $monnaie, MonnaieRepository $monnaieRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$monnaie->getId(), $request->request->get('_token'))) {
            $monnaieRepository->remove($monnaie);
        }

        return $this->redirectToRoute('app_monnaie_index', [], Response::HTTP_SEE_OTHER);
    }
}
