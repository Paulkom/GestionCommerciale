<?php

namespace App\Controller;

use App\Entity\Client;
use App\Form\ClientType;
use App\Repository\ClientRepository;
use App\Repository\PointDeVenteRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

/**
 * @Route("/admin/client")
 */
class ClientController extends AbstractController
{
    /**
     * @Route("/", name="app_client_index", methods={"GET","POST"})
     */
    public function index(Request $request, EntityManagerInterface $em, ClientRepository $clientRepository,PointDeVenteRepository $pointDeVenteRepository): Response
    {
        $client = new Client();
        $form = $this->createForm(ClientType::class, $client);
        $form->handleRequest($request);

        // $clients = $clientRepository->findAll();
        // foreach ($clients as $cli) {
        //     $lib="";
        //     if($cli->getStatut() =="Physique"){
        //         $cli->setNomClient( $cli->getNom() . " " . $cli->getPrenom());
        //     }else{
        //         $cli->setNomClient( ' [' . $cli->getSigle() .'] '. $cli->getDenomination() );
        //     }
        // }
        // $em->flush();

        if ($form->isSubmitted() && $form->isValid()) {
            //$pointVente = $request->getSession()->get('pointVente');
            //dd($pointVente); 
            $clientRepository->add($client);
            if($client->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }

        return $this->renderForm('client/index.html.twig', [
            'clients' => $clientRepository->findAll(),
            'form' => $form,
        ]);
    }


    /**
     * @Route("/{id}", name="app_client_show", methods={"GET"})
     */
    public function show(Client $client): Response
    {
        return $this->render('client/show.html.twig', [
            'client' => $client,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_client_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Client $client, ClientRepository $clientRepository): Response
    {
        $form = $this->createForm(ClientType::class, $client);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $clientRepository->add($client);
            return $this->redirectToRoute('app_client_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('client/edit.html.twig', [
            'client' => $client,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_client_delete", methods={"POST"})
     */
    public function delete(Request $request, Client $client, ClientRepository $clientRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$client->getId(), $request->request->get('_token'))) {
            $clientRepository->remove($client);
        }

        return $this->redirectToRoute('app_client_index', [], Response::HTTP_SEE_OTHER);
    }
}
