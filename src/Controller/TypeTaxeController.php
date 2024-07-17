<?php

namespace App\Controller;

use App\Entity\TypeTaxe;
use App\Form\TypeTaxeType;
use App\Repository\TypeTaxeRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

/**
 * @Route("/admin/type/taxe")
 */
class TypeTaxeController extends AbstractController
{
    /**
     * @Route("/", name="app_type_taxe_index", methods={"GET","POST"})
     */
    public function index(Request $request, TypeTaxeRepository $typeTaxeRepository): Response
    {
        $typeTaxe = new TypeTaxe();
        $form = $this->createForm(TypeTaxeType::class, $typeTaxe);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $typeTaxeRepository->add($typeTaxe);
            if($typeTaxe->getId() != null)
                return new JsonResponse("Enregistrement éffectué avec succès.");
        }

        return $this->renderForm('type_taxe/index.html.twig', [
            'type_taxes' => $typeTaxeRepository->findAll(),
            'form' => $form,
        ]);
    }


    /**
     * @Route("/{id}", name="app_type_taxe_show", methods={"GET"})
     */
    public function show(TypeTaxe $typeTaxe): Response
    {
        return $this->render('type_taxe/show.html.twig', [
            'type_taxe' => $typeTaxe,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_type_taxe_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, TypeTaxe $typeTaxe, TypeTaxeRepository $typeTaxeRepository): Response
    {
        $form = $this->createForm(TypeTaxeType::class, $typeTaxe);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $typeTaxeRepository->add($typeTaxe);
            return $this->redirectToRoute('app_type_taxe_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('type_taxe/edit.html.twig', [
            'type_taxe' => $typeTaxe,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_type_taxe_delete", methods={"POST"})
     */
    public function delete(Request $request, TypeTaxe $typeTaxe, TypeTaxeRepository $typeTaxeRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$typeTaxe->getId(), $request->request->get('_token'))) {
            $typeTaxeRepository->remove($typeTaxe);
        }

        return $this->redirectToRoute('app_type_taxe_index', [], Response::HTTP_SEE_OTHER);
    }
}
