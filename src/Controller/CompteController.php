<?php

namespace App\Controller;

use App\Entity\Caisse;
use App\Entity\Compte;
use App\Entity\ModePaiement;
use App\Entity\Transaction;
use App\Entity\TypeOperation;
use App\Form\CompteType;
use App\Repository\CompteRepository;
use DateTime;
use Doctrine\ORM\EntityManager;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/admin/compte')]
class CompteController extends AbstractController
{
    #[Route('/', name: 'app_compte_index', methods: ['GET', 'POST'])]
    public function index(Request $request, CompteRepository $compteRepository): Response
    {
        $compte = new Compte();
        $form = $this->createForm(CompteType::class, $compte);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $compte->setSolde($compte->getSoldeInitial());

            if($compte->getSoldeInitial() > 0){
                $session =$request->getSession();
                $em = $this->getDoctrine()->getManager();
                if(!$session->get('caisse')) 
                    return new JsonResponse("Veuillez ouvrir une caisse avant d'effectuer l'opération.§§§§msg_error");

                $transaction = new Transaction();
                $typeOp = $em->getRepository(TypeOperation::class)->findOneBy(['libelle'=>'Dépôt']);
                $transaction->setMotif('Dépôt initial');
                $transaction->setModePaiement($em->getRepository(ModePaiement::class)->findOneBy(['libelle'=>'En espèces']));
                $transaction->setDateTransac(new DateTime());
                $transaction->setMontantTransac($compte->getSoldeInitial());
                $transaction->setTypeOperation($typeOp);
                $transaction->setClient($compte->getClient()); 
                $transaction->setCaisse($em->getRepository(Caisse::class)->find($session->get('caisse')));
                $transaction->setCompte($compte);
                $em->persist($transaction);
                $compte->addTransaction($transaction);
            }

            $compteRepository->add($compte);
            if ($compte->getId() != null){
                $compte = new Compte();
                $form = $this->createForm(CompteType::class, $compte);
                $html = $this->renderView('compte/partials/_card_form.html.twig', ['compte' => $compte,'form' => $form->createView() ]);
                $comp ="§".$compte->getId()."§".''."§".$html;
                return new JsonResponse("Le compte a été créé avec succès.".$comp);
            }       
        }

        return $this->renderForm('compte/index.html.twig', [
            'compte' => $compte,
            'form' => $form,
        ]);
    }

    #[Route('/new', name: 'app_compte_new', methods: ['GET', 'POST'])]
    public function new(Request $request, CompteRepository $compteRepository): Response
    {
        $compte = new Compte();
        $form = $this->createForm(CompteType::class, $compte);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $compteRepository->add($compte);
            return $this->redirectToRoute('app_compte_index', [], Response::HTTP_SEE_OTHER);
        }
        return $this->renderForm('compte/new.html.twig', [
            'compte' => $compte,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_compte_show', methods: ['GET'])]
    public function show(Compte $compte): Response
    {
        return $this->render('compte/show.html.twig', [
            'compte' => $compte,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_compte_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Compte $compte, CompteRepository $compteRepository): Response
    {
        $form = $this->createForm(CompteType::class, $compte);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $compteRepository->add($compte);
            return $this->redirectToRoute('app_compte_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('compte/edit.html.twig', [
            'compte' => $compte,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_compte_delete', methods: ['POST'])]
    public function delete(Request $request, Compte $compte, CompteRepository $compteRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$compte->getId(), $request->request->get('_token'))) {
            $compteRepository->remove($compte);
        }

        return $this->redirectToRoute('app_compte_index', [], Response::HTTP_SEE_OTHER);
    }
}
