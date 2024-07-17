<?php

namespace App\Controller;

use App\Entity\Taxe;
use App\Form\TaxeType;
use App\Repository\TaxeRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/admin/taxe')]
class TaxeController extends AbstractController
{
    /**
     * @Route("/", name="app_taxe_index", methods={"GET", "POST"})
     */
    public function index(Request $request, TaxeRepository $taxeRepository): Response
    {

        $taxe = new Taxe();
        $form = $this->createForm(TaxeType::class, $taxe);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $taxeRepository->add($taxe);
            if($taxe->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }
        return $this->renderForm('taxe/index.html.twig', [
            'taxes' => $taxeRepository->findAll(),
            'taxe' => $taxe,
            'form' => $form,
        ]);
    }

    
   

    #[Route('/{id}', name: 'app_taxe_show', methods: ['GET'])]
    public function show(Taxe $taxe): Response
    {
        return $this->render('taxe/show.html.twig', [
            'taxe' => $taxe,
        ]);
    }

   

}
