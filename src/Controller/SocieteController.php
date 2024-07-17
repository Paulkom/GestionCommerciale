<?php

namespace App\Controller;

use App\Entity\Societe;
use App\Form\SocieteType;
use App\Repository\SocieteRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

/**
 * @Route("/admin/societe")
 */
class SocieteController extends AbstractController
{
    /**
     * @Route("/", name="app_societe_index", methods={"GET", "POST"})
     */
    public function index(Request $request, SocieteRepository $societeRepository): Response
    {
        $societe = new Societe();
        $form = $this->createForm(SocieteType::class, $societe);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
           //$societe = $societeRepository->findAll()
            $societeRepository->add($societe);
            if($societe->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }

        return $this->renderForm('societe/index.html.twig', [
            'societes' => $societeRepository->findAll(),
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_societe_show", methods={"GET"})
     */
    public function show(Societe $societe): Response
    {
        return $this->render('societe/show.html.twig', [
            'societe' => $societe,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_societe_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Societe $societe, SocieteRepository $societeRepository): Response
    {
        $form = $this->createForm(SocieteType::class, $societe);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $societeRepository->add($societe);
            return $this->redirectToRoute('app_societe_index', [], Response::HTTP_SEE_OTHER);
        }
        return $this->renderForm('societe/edit.html.twig', [
            'societe' => $societe,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_societe_delete", methods={"POST"})
     */
    public function delete(Request $request, Societe $societe, SocieteRepository $societeRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$societe->getId(), $request->request->get('_token'))) {
            $societeRepository->remove($societe);
        }

        return $this->redirectToRoute('app_societe_index', [], Response::HTTP_SEE_OTHER);
    }
}
