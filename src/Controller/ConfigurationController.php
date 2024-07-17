<?php

namespace App\Controller;

use App\Entity\Configuration;
use App\Form\ConfigurationType;
use App\Repository\ConfigurationRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/admin/configuration')]
class ConfigurationController extends AbstractController
{
    #[Route('/', name: 'app_configuration_index', methods: ['GET','POST'])]
    public function index(Request $request,ConfigurationRepository $configurationRepository): Response
    {
        $configuration = $configurationRepository->find(1);
        if($configuration == null || empty($configuration)){
            $configuration = new Configuration();
        }
        
        $form = $this->createForm(ConfigurationType::class, $configuration);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $configurationRepository->add($configuration);
            // if($configuration->getId() != null)
            //     return new JsonResponse("Enregistrement effectué avec succès.");
        }

        return $this->renderForm('configuration/index.html.twig', [
            // 'configurations' => $configurationRepository->findAll(),
            'configuration' => $configuration,
            'form' => $form,
        ]);
    }

    // #[Route('/new', name: 'app_configuration_new', methods: ['GET', 'POST'])]
    // public function new(Request $request, ConfigurationRepository $configurationRepository): Response
    // {
    //     $configuration = new Configuration();
    //     $form = $this->createForm(ConfigurationType::class, $configuration);
    //     $form->handleRequest($request);

    //     if ($form->isSubmitted() && $form->isValid()) {
    //         $configurationRepository->add($configuration);
    //         return $this->redirectToRoute('app_configuration_index', [], Response::HTTP_SEE_OTHER);
    //     }

    //     return $this->renderForm('configuration/new.html.twig', [
    //         'configuration' => $configuration,
    //         'form' => $form,
    //     ]);
    // }

    #[Route('/{id}', name: 'app_configuration_show', methods: ['GET'])]
    public function show(Configuration $configuration): Response
    {
        return $this->render('configuration/show.html.twig', [
            'configuration' => $configuration,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_configuration_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Configuration $configuration, ConfigurationRepository $configurationRepository): Response
    {
        $form = $this->createForm(ConfigurationType::class, $configuration);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $configurationRepository->add($configuration);
            return $this->redirectToRoute('app_configuration_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('configuration/edit.html.twig', [
            'configuration' => $configuration,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_configuration_delete', methods: ['POST'])]
    public function delete(Request $request, Configuration $configuration, ConfigurationRepository $configurationRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$configuration->getId(), $request->request->get('_token'))) {
            $configurationRepository->remove($configuration);
        }

        return $this->redirectToRoute('app_configuration_index', [], Response::HTTP_SEE_OTHER);
    }
}
