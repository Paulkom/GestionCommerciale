<?php

namespace App\Controller;

use Mpdf\Mpdf;
use App\Entity\CommandeFrs;
use App\Form\CommandeFrsType;
use App\Entity\ProduitCondComFrs;
use App\Repository\SocieteRepository;
use App\Repository\CommandeFrsRepository;
use App\Repository\FournisseurRepository;
use App\Repository\DemandeDePrixRepository;
use App\Services\LibrairieService;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('admin/commande/frs')]
class CommandeFrsController extends AbstractController
{
    #[Route('/{demande}', name: 'app_commande_frs_index', methods: ['GET','POST'])]
    public function index(Request $request, CommandeFrsRepository $commandeFrsRepository,DemandeDePrixRepository $demandeRepo,
     $demande = null): Response
    {
        $commandeFr = new CommandeFrs();

        if($demande != ''){
            //transformation de demande de prix en commande fournisseur
            $demandeDePrix = $demandeRepo->find($demande);
            $commandeFr->setDateComFrs(new \DateTime());
            $commandeFr->setFournisseur($demandeDePrix->getFournisseur());
            $commandeFr->setDemandeDePrix($demandeDePrix);

            foreach ($demandeDePrix->getProduitCondDdps() as $ligneProduit) {
                $produitCondComFrs = new ProduitCondComFrs;
                $produitCondComFrs->setQteComfrs($ligneProduit->getQteDdp());
                $produitCondComFrs->setProduitCond($ligneProduit->getProduitCond());
                // dd($produitCondComFrs);
                $commandeFr->addProduitCondComFr($produitCondComFrs);
            }
        }

        $form = $this->createForm(CommandeFrsType::class, $commandeFr);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $commandeFrsRepository->add($commandeFr);
            if($commandeFr->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }

        return $this->renderForm('commande_frs/index.html.twig', [
            'commande_frs' => $commandeFrsRepository->findAll(),
            'commande_fr' => $commandeFr,
            'form' => $form,
            'demande' => $demande,
        ]);
    }


    #[Route('/{id}', name: 'app_commande_frs_show', methods: ['GET'])]
    public function show(CommandeFrs $commandeFr): Response
    {
        return $this->render('commande_frs/show.html.twig', [
            'commande_fr' => $commandeFr,
        ]);
    }

    #[Route('/{id}/imprimer', name: 'app_commande_frs_invoice', methods: ['GET','POST'])]
    public function imprimer(CommandeFrs $commandeFrs, FournisseurRepository $fournisseurRepository, SocieteRepository $societeRepository, LibrairieService $library){

        $fournisseur = $fournisseurRepository->findAll()[0];
        $societe = $societeRepository->findAll()[0];
        $path = $this->getParameter('medias_directory');
        $media = $societe->getEntete()->getId().'.'.$societe->getEntete()->getExtension();

        $htmlPage = $this->renderView("commande_frs/documents/bon_de_commande.html.twig",[
            'commande' => $commandeFrs,
            'fournisseur' => $fournisseur,
            'logo' => $path.'\\societe\\'.$media,
        ]);

        return $library->mpdf([$htmlPage],"Commande fournisseur"); 
    }

    #[Route('/{id}/edit', name: 'app_commande_frs_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, CommandeFrs $commandeFr, CommandeFrsRepository $commandeFrsRepository): Response
    {
        $form = $this->createForm(CommandeFrsType::class, $commandeFr);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $commandeFrsRepository->add($commandeFr);
            return $this->redirectToRoute('app_commande_frs_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('commande_frs/edit.html.twig', [
            'commande_fr' => $commandeFr,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_commande_frs_delete', methods: ['POST'])]
    public function delete(Request $request, CommandeFrs $commandeFr, CommandeFrsRepository $commandeFrsRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$commandeFr->getId(), $request->request->get('_token'))) {
            $commandeFrsRepository->remove($commandeFr);
        }

        return $this->redirectToRoute('app_commande_frs_index', [], Response::HTTP_SEE_OTHER);
    }
}
