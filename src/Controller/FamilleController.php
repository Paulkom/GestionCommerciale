<?php

namespace App\Controller;

use App\Entity\Famille;
use App\Form\FamilleType;
use App\Repository\FamilleRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/admin/famille")
 */
class FamilleController extends AbstractController
{
    /**
     * @Route("/", name="app_famille_index", methods={"GET"})
     */
    public function index(Request $request): Response
    {
        $famille = new Famille();
        $form = $this->createForm(FamilleType::class, $famille, [
            'action' => $this->generateUrl('app_entity_callandsave', ['class'=>'famille', 'action'=>'save']),
        ]);
        $form->handleRequest($request);

        return $this->renderForm('famille/index.html.twig', [
            'form' => $form,
        ]);
    }


    /**
     * @Route("/{id}", name="app_famille_show", methods={"GET"})
     */
    public function show(Famille $famille): Response
    {
        return $this->render('famille/show.html.twig', [
            'famille' => $famille,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_famille_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Famille $famille, FamilleRepository $familleRepository): Response
    {
        $form = $this->createForm(FamilleType::class, $famille);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $familleRepository->add($famille);
            return $this->redirectToRoute('app_famille_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('famille/edit.html.twig', [
            'famille' => $famille,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_famille_delete", methods={"POST"})
     */
    public function delete(Request $request, Famille $famille, FamilleRepository $familleRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$famille->getId(), $request->request->get('_token'))) {
            $familleRepository->remove($famille);
        }

        return $this->redirectToRoute('app_famille_index', [], Response::HTTP_SEE_OTHER);
    }
}
