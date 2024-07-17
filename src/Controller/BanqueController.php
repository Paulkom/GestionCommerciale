<?php

namespace App\Controller;

use App\Entity\Banque;
use App\Form\BanqueType;
use App\Repository\BanqueRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

/**
 * @Route("/admin/banque")
 */
class BanqueController extends AbstractController
{
    /**
     * @Route("/", name="app_banque_index", methods={"GET", "POST"})
     */
    public function index(Request $request, BanqueRepository $banqueRepository): Response
    {

        $banque = new Banque();
        $form = $this->createForm(BanqueType::class, $banque);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $banqueRepository->add($banque);
            if($banque->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }
        return $this->renderForm('banque/index.html.twig', [
            'banques' => $banqueRepository->findAll(),
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_banque_show", methods={"GET"})
     */
    public function show(Banque $banque): Response
    {
        return $this->render('banque/show.html.twig', [
            'banque' => $banque,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_banque_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Banque $banque, BanqueRepository $banqueRepository): Response
    {
        $form = $this->createForm(BanqueType::class, $banque);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $banqueRepository->add($banque);
            return $this->redirectToRoute('app_banque_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('banque/edit.html.twig', [
            'banque' => $banque,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_banque_delete", methods={"POST"})
     */
    public function delete(Request $request, Banque $banque, BanqueRepository $banqueRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$banque->getId(), $request->request->get('_token'))) {
            $banqueRepository->remove($banque);
        }

        return $this->redirectToRoute('app_banque_index', [], Response::HTTP_SEE_OTHER);
    }
}
