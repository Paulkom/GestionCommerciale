<?php

namespace App\Controller;

use App\Entity\Fonction;
use App\Form\FonctionType;
use App\Repository\FonctionRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Security;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

/**
 * @Route("/admin/fonction")
 */
class FonctionController extends AbstractController
{
    /**
     * @Route("/", name="app_fonction_index", methods={"GET","POST"})
     */
    public function index(Request $request, FonctionRepository $fonctionRepository): Response
    {
        $fonction = new Fonction();
        $form = $this->createForm(FonctionType::class, $fonction);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $fonctionRepository->add($fonction);
            if($fonction->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }

        return $this->renderForm('fonction/index.html.twig', [
            'fonctions' => $fonctionRepository->findAll(),
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_fonction_show", methods={"GET"})
     */
    public function show(Fonction $fonction): Response
    {
        return $this->render('fonction/show.html.twig', [
            'fonction' => $fonction,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_fonction_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Fonction $fonction, FonctionRepository $fonctionRepository): Response
    {
        $form = $this->createForm(FonctionType::class, $fonction);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $fonctionRepository->add($fonction);
            return $this->redirectToRoute('app_fonction_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('fonction/edit.html.twig', [
            'fonction' => $fonction,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_fonction_delete", methods={"POST"})
     */
    public function delete(Request $request, Fonction $fonction, FonctionRepository $fonctionRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$fonction->getId(), $request->request->get('_token'))) {
            $fonctionRepository->remove($fonction);
        }

        return $this->redirectToRoute('app_fonction_index', [], Response::HTTP_SEE_OTHER);
    }
}
