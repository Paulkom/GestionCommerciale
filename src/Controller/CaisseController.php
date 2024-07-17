<?php

namespace App\Controller;

use App\Entity\Caisse;
use App\Entity\MonnaieCaisse;
use App\Entity\Paiement;
use App\Entity\Personnel;
use App\Entity\PersonnelCaisse;
use App\Entity\Transaction;
use App\Form\CaisseType;
use App\Repository\CaisseRepository;
use App\Repository\DepenseRepository;
use App\Repository\MonnaieRepository;
use App\Repository\PaiementRepository;
use App\Repository\TransactionRepository;
use DateTime;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\User\UserInterface;

#[Route('/admin/caisse')]
class CaisseController extends AbstractController
{
    #[Route('/', name: 'app_caisse_index', methods: ['GET','POST'])]
    public function index(CaisseRepository $caisseRepository): Response
    {   
        return $this->renderForm('caisse/index.html.twig', [
            'caisses' => $caisseRepository->findBy(['etat'=>0,'user' => $this->getUser()]),
        ]);
    }

    #[Route('/ouverture', name: 'app_caisse_ouverture', methods: ['GET', 'POST'])]
    public function ouverture(Request $request, CaisseRepository $caisseRepository, MonnaieRepository $monnaieRepository): Response
    {
        $monnaires = $monnaieRepository->findBy(['estSup'=>null],['valeur' => 'desc']);
        $caisse = new Caisse();
        foreach ($monnaires as $monnaire) {
           $monnaieCaisse = new MonnaieCaisse;
           $monnaieCaisse->setMonnaie($monnaire);
           $monnaieCaisse->setEtat(0);
           $monnaieCaisse->setNbr(0);
           $monnaieCaisse->setMontant(0);
           $caisse->addMonnaieCaiss($monnaieCaisse);
        }
        for ($i=0; $i < 1; $i++) { 
            $personnel =  new PersonnelCaisse;
            $caisse->addPersonnelCaiss($personnel);
        }
        $caisse->setEtat(0);
        $caisse->setFondRoulement(0);
        $caisse->setUser($this->getUser());
        $caisse->setDateOuverture(new DateTime());
        $form = $this->createForm(CaisseType::class, $caisse);
        $form->remove('chiffreAffaire');
        $form->remove('ecart');
        $form->remove('soldeCloture');
        $form->remove('depense');
        $form->handleRequest($request);
       
        if($form->isSubmitted() && $form->isValid()) {
            $lcaisse = $caisse->getLcaisse();
            $lcaisse->setEtat(true);
            $caisse->setLcaisse($lcaisse);
            $caisseRepository->add($caisse);

            $session = $request->getSession();
            if($caisse->getId() != null){
                $session->remove('caisse');
                $session->set('caisse', $caisse);
            }
                
            return $this->redirectToRoute('app_caisse_index', [], Response::HTTP_SEE_OTHER);
        }
        return $this->renderForm('caisse/ouverture.html.twig', [
            'caisse' => $caisse,
            'form' => $form,
        ]);
    }


    #[Route('/fermerture', name: 'app_caisse_fermerture', methods: ['GET', 'POST'])]
    public function fermerture(Request $request,TransactionRepository $transaction,PaiementRepository $paiementRepository,
     CaisseRepository $caisseRepository,MonnaieRepository $monnaieRepository,DepenseRepository $depenseRepository): Response
    {

        //dd($this->getUser());
        $caisseOuvert = $caisseRepository->findOneBy(['user' => $this->getUser(),'etatCaisse'=>null]);
        //dd($caisseOuvert);
        
        if($caisseOuvert == null)
        {
            $error = true;
            $this->addFlash('msg','Vous n\'avez pas de caisse ouvert.');
            return $this->renderForm('caisse/fermerture.html.twig', [
                'caisse' => $caisseOuvert,
                'error'=> $error
            ]);

        }else{
            $paie = $paiementRepository->getChifreAffaire($caisseOuvert);
            $depot = $transaction->getTrans($caisseOuvert);

            $depense = $depenseRepository->getDepense($caisseOuvert)['totaldepense'];

            $chi = (float)$paie['totalpaiement'] + (float)$depot['totaldepot'];
            $error = false;
            ///dd($chi);
            $session = $request->getSession();
            /*dump($session->get('caisse'));
            dump($paie);
            dump($depot);*/
           
            $caisse = new Caisse();
            $monnaires = $monnaieRepository->findBy(['estSup'=>null],['valeur' => 'desc']);
            foreach ($monnaires as $monnaire) {
                $monnaieCaisse = new MonnaieCaisse;
                $monnaieCaisse->setMonnaie($monnaire);
                $monnaieCaisse->setEtat(0);
                $monnaieCaisse->setNbr(0);
                $monnaieCaisse->setMontant(0);
                $caisse->addMonnaieCaiss($monnaieCaisse);
            }
            for ($i= 0; $i < 1; $i++) { 
               $personnel =  new PersonnelCaisse;
               $caisse->addPersonnelCaiss($personnel);
            }
            
            $caisse->setEtat(1);
            $caisse->setEcart(-($chi+(float)$caisseOuvert->getFondRoulement()) + (float)$depense);
            $caisse->setFondRoulement($caisseOuvert->getFondRoulement());
            $caisse->setEtatCaisse($caisseOuvert);
            $caisse->setLcaisse($caisseOuvert->getLcaisse());
            $caisse->setChiffreAffaire($chi);
            $caisse->setDepense((float)$depense);

            $form = $this->createForm(CaisseType::class, $caisse);
            $form->remove('lcaisse');
            $form->handleRequest($request);
        }

        if($form->isSubmitted() && $form->isValid()){
            $lcaisse = $caisse->getLcaisse();
            $lcaisse->setEtat(false);
            $caisse->setLcaisse($lcaisse);
            $caisse->setDateFermeture(new DateTime());
            $caisseOuvert->setDateFermeture(new DateTime());
            $caisseOuvert->setEtatCaisse($caisse);
            $caisse->setEtatCaisse( $caisseOuvert);
            $caisseRepository->add($caisse);
            if($caisse->getId() != null)
                $session->remove('caisse');
            return $this->redirectToRoute('app_admin_dashboard', [], Response::HTTP_SEE_OTHER);
        }
        return $this->renderForm('caisse/fermerture.html.twig', [
            'caisse' => $caisse,
            'form' => $form,
            'error'=> $error,
            'lcaisse' => $caisseOuvert->getLcaisse()->getLibelle()."(".$caisseOuvert->getLcaisse()->getCode().")"
        ]);
    }


    #[Route('/{id}', name: 'app_caisse_show', methods: ['GET'])]
    public function show(Caisse $caisse): Response
    {
        return $this->render('caisse/show.html.twig', [
            'caisse' => $caisse,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_caisse_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Caisse $caisse, CaisseRepository $caisseRepository): Response
    {
        $form = $this->createForm(CaisseType::class, $caisse);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $caisseRepository->add($caisse);
            return $this->redirectToRoute('app_caisse_index', [], Response::HTTP_SEE_OTHER);
        }
        return $this->renderForm('caisse/edit.html.twig', [
            'caisse' => $caisse,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_caisse_delete', methods: ['POST'])]
    public function delete(Request $request, Caisse $caisse, CaisseRepository $caisseRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$caisse->getId(), $request->request->get('_token'))) {
            $caisseRepository->remove($caisse);
        }
        return $this->redirectToRoute('app_caisse_index', [], Response::HTTP_SEE_OTHER);
    }
}
