<?php

namespace App\Controller;

use App\Entity\Compte;
use App\Entity\Transaction;
use App\Entity\TypeOperation;
use App\Form\DepotType;
use App\Form\TransactionType;
use App\Repository\CaisseRepository;
use App\Repository\ModelSignataireRepository;
use App\Repository\SocieteRepository;
use App\Repository\TransactionRepository;
use App\Services\LibrairieService;
use NumberFormatter;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\FormFactoryInterface;

#[Route('/admin/transaction')]
class TransactionController extends AbstractController
{
    /**
     * @Route("/", name="app_transaction_index", methods={"GET", "POST"})
     */
    public function index(Request $request, TransactionRepository $transactionRepository,CaisseRepository $caisseRepository)
    {
        $transaction = new Transaction();

        $form = $this->createForm(TransactionType::class, $transaction);
        $form->handleRequest($request);
        $error = false;
        $session =$request->getSession();
        
        if ($form->isSubmitted() && $form->isValid()) {
            if (!$session->get('caisse')) 
                return new JsonResponse("Veuillez ouvrir une caisse avant d'effectuer l'opération.§§§§msg_error");

            $em = $this->getDoctrine()->getManager();
            $idCli = $transaction->getClient()->getId();
            //Vérifier s'il s'agit de la première opération de dépôt pour ce client
            /**@var \Doctrine\ORM\EntityManagerInterface $em */
            $depot = $em->createQuery("
                            SELECT COUNT(t) AS nbr, SUM(t.montantTransac) AS totalDep
                            FROM App\Entity\Transaction t
                            INNER JOIN t.typeOperation to
                            INNER JOIN t.client cli
                            WHERE to.libelle LIKE '%Dépôt%' AND cli.id = $idCli
                        ")->getSingleResult();
            $typeOp = $transaction->getTypeOperation()->getLibelle();
            $comptes = $em->getRepository(Compte::class)->findBy(['client'=>$transaction->getClient()]);
            $compte = null;
            if(sizeof($comptes) > 0)
            {
                /** @var Compte $compte */
                $compte = $comptes[0];
            }

            if($depot['nbr'] <= 0 && str_contains($typeOp, "Dépôt"))
            {
                foreach ($comptes as $key => $c)
                {
                    $em->remove($c);
                    unset($comptes[$key]);
                }
                $compte = new Compte();
                $compte->setClient($transaction->getClient());
                $compte->setIntitule($typeOp);
                $compte->setSolde($transaction->getMontantTransac());
                $compte->setSoldeInitial(0);
                $em->persist($compte);
                //$transaction->setCompte($compte);
            }

            
            if(str_contains($typeOp, "Dépôt") && $depot['nbr'] > 0)
            {
                $compte->setSolde($compte->getSolde() + $transaction->getMontantTransac());
            }

            if(str_contains($typeOp, "Retrait"))
            {
                //$total = (double)$depot['totalDep'];
                if($transaction->getMontantTransac() > $compte->getSolde())
                {
                    $error = true;
                    $this->addFlash(
                        'msg',
                        'Impossible d\'enregistrer ce retrait, votre solde est insuffisant.'
                    );
                    return new JsonResponse("Impossible d'enregistrer ce retrait, votre solde est insuffisant.§§§§msg_error");
                }
                $compte->setSolde($compte->getSolde() - $transaction->getMontantTransac());

            }

            if(!$error)
            {
                // $this->addFlash(
                //     'msg',
                //     'Enregistrement effectué avec succès.'
                // );
                
                $transaction->setCaisse($caisseRepository->find($session->get('caisse')));
                $transaction->setCompte($compte);
                $transactionRepository->add($transaction);
                // return $this->redirectToRoute('app_transaction_index', [], Response::HTTP_SEE_OTHER);
                if($transaction->getId() != null)
                    return new JsonResponse("Enregistrement éffectué avec succès.");
            }
        }
        return $this->renderForm('transaction/index.html.twig', [
            'transaction' => $transaction,
            'form' => $form,
            'error' => $error,
        ]);
    }

    #[Route('/depot', name: 'app_transaction_depot', methods: ['GET', 'POST'])]
    public function depot(FormFactoryInterface $formFactory,Request  $request, TransactionRepository $transactionRepository,CaisseRepository $caisseRepository): Response
    {
        $transaction = new Transaction();
        $em = $this->getDoctrine()->getManager();
        $form =  $formFactory->createNamed('depot',DepotType::class, $transaction);
        $form->handleRequest($request);
        $session =$request->getSession();
        
        if ($form->isSubmitted() && $form->isValid()) {
            if (!$session->get('caisse')) 
                return new JsonResponse("Veuillez ouvrir une caisse avant d'effectuer l'opération.§§§§msg_error");

            $typeOp = $em->getRepository(TypeOperation::class)->findOneBy(['libelle'=>'Dépôt']);
            if(!$typeOp){
                $typeOp = new TypeOperation;
                $typeOp->setLibelle('Dépôt');
                $em->persist($typeOp);
            }  
            $transaction->setTypeOperation($typeOp);
            $comptes = $em->getRepository(Compte::class)->findBy(['client'=>$transaction->getClient()]);
            $compte = null;
            if(sizeof($comptes) > 0)
            {
                /** @var Compte $compte */
                $compte = $comptes[0];
            }
            $compte->setSolde($compte->getSolde() + $transaction->getMontantTransac());
            $transaction->setCompte($compte);
            $transaction->setCaisse($caisseRepository->find($session->get('caisse')));
           
            $transactionRepository->add($transaction);
            if($transaction->getId()){
                $comp ="§".$transaction->getId()."§".$form->get("truc")->getData();
                return new JsonResponse("Enregistrement éffectué avec succès.".$comp);
            }
            
        }
        return $this->renderForm('transaction/depot.html.twig', [
            'transactions' => $transactionRepository->findAll(),
            'transaction' => $transaction,
            'form' => $form,
        ]);
    }

    #[Route('/transaction/imprime', name: 'imprime_depot', methods: ['GET', 'POST'])]
    public function impr(Request $request, SocieteRepository $sociRep, ModelSignataireRepository $modelRep, TransactionRepository $transRep, LibrairieService $library){
        $id = $request->request->get('id');
        $format = "A4-P";
        //dd($format);
        $ent = null;

        if($sociRep->findAll()){
            $ent = ($sociRep->findAll())[0];
        }
        
        $signataires = $modelRep->findOneBy(["estDefault"=>true]);
        $transaction = $transRep->find($id);
        $htmlPage = $this->renderView("transaction/document/quittus.html.twig",[
            'transaction'=>$transaction,
            'signataires'=>$signataires,
            'societe'=>$ent,
            'format'=>$format,
            'valeur'=> $library->getFormattedNumber(value: (float)$transaction->getMontantTransac(),  style: NumberFormatter::SPELLOUT)
        ]);
        return $library->mpdf([$htmlPage],"Depot",$format);
    }

    #[Route('/{id}', name: 'app_transaction_show', methods: ['GET'])]
    public function show(Transaction $transaction): Response
    {
        return $this->render('transaction/show.html.twig', [
            'transaction' => $transaction,
        ]);
    }

    #[Route('/{id}', name: 'app_transaction_delete', methods: ['POST'])]
    public function delete(Request $request, Transaction $transaction, TransactionRepository $transactionRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$transaction->getId(), $request->request->get('_token'))) {
            $transactionRepository->remove($transaction);
        }
        $dop="";
        return $this->redirectToRoute('app_transaction_index', [], Response::HTTP_SEE_OTHER);
    }
    
}

