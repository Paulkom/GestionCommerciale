<?php

namespace App\Controller;

use App\Entity\Objectif;
use App\Form\ObjectifType;
use App\Repository\ObjectifRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/admin/objectif")
 */
class ObjectifController extends AbstractController
{
     /**
     * @Route("/", name="app_objectif_index", methods={"GET", "POST"})
     */
    public function index(Request $request, ObjectifRepository $objectifRepository): Response
    {
        $objectif = new Objectif();
        $form = $this->createForm(ObjectifType::class, $objectif);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $lesObjectifs = $objectifRepository->findBy(["estActif" => true]);
            foreach($lesObjectifs as $obj){
                $obj->setEstActif(false);
                $objectifRepository->add($obj);
            }
            $objectifRepository->add($objectif);
            if($objectif->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }

        return $this->renderForm('objectif/index.html.twig', [
            'objectifs' => $objectifRepository->findAll(),
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_objectif_show", methods={"GET"})
     */
    public function show(Objectif $objectif): Response
    {
        return $this->render('objectif/show.html.twig', [
            'objectif' => $objectif,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_objectif_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Objectif $objectif, ObjectifRepository $objectifRepository): Response
    {
        $form = $this->createForm(ObjectifType::class, $objectif);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $objectifRepository->add($objectif);
            return $this->redirectToRoute('app_objectif_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('objectif/edit.html.twig', [
            'objectif' => $objectif,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_objectif_delete", methods={"POST"})
     */
    public function delete(Request $request, Objectif $objectif, ObjectifRepository $objectifRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$objectif->getId(), $request->request->get('_token'))) {
            $objectifRepository->remove($objectif);
        }

        return $this->redirectToRoute('app_objectif_index', [], Response::HTTP_SEE_OTHER);
    }
}
