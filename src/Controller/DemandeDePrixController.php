<?php

namespace App\Controller;

use Mpdf\Mpdf;
use App\Entity\DemandeDePrix;
use App\Form\DemandeDePrixType;
use App\Repository\DemandeDePrixRepository;
use App\Repository\FournisseurRepository;
use App\Repository\SocieteRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/admin/demande/de/prix')]
class DemandeDePrixController extends AbstractController
{

    
    #[Route('/', name: 'app_demande_de_prix_index', methods: ['GET','POST'])]
    public function index(Request $request, DemandeDePrixRepository $demandeDePrixRepository): Response
    {

        $demandeDePrix = new DemandeDePrix();
        $form = $this->createForm(DemandeDePrixType::class, $demandeDePrix);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $demandeDePrixRepository->add($demandeDePrix);
            if($demandeDePrix->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }
        
        return $this->renderForm('demande_de_prix/index.html.twig', [
            'demande_de_prixes' => $demandeDePrixRepository->findAll(),
            'demande_de_prix' =>$demandeDePrix,
            'form' => $form,
        ]);
    }

    #[Route('/{id}/imprimer', name: 'app_demande_de_prix_invoice', methods: ['GET','POST'])]
    public function imprimer(DemandeDePrix $demandeDePrix, FournisseurRepository $fournisseurRepository, SocieteRepository $societeRepository){

        $fournisseur = $fournisseurRepository->findAll()[0];
        $societe = $societeRepository->findAll()[0];
        $path = $this->getParameter('medias_directory');
        $media = $societe->getEntete()->getId().'.'.$societe->getEntete()->getExtension();

        $mpdf = new Mpdf(['mode' => 'utf-8', 
                          'format' => 'A4-P',
                          'margin_left' => 0,
                          'margin_right' => 0,
                          'margin_top' => 0,
                          'margin_bottom' => 0,
                          'margin_footer' => 0,]);
                          
        $mpdf->SetHTMLFooter('
                <table width="100%" style="padding: 25px;">
                    <tr>
                        <td width="50%" align="left" style="padding: 15px;">{DATE j-m-Y}</td>
                        <td width="50%" align="right" style="padding: 15px;">{PAGENO}/{nbpg}</td>
                    </tr>
                </table>');
        $mpdf->WriteHTML($this->renderView('demande_de_prix/documents/demande.prix.html.twig', [
            'demande' => $demandeDePrix,
            'fournisseur' => $fournisseur,
            'logo' => $path.'\\societe\\'.$media,
        ]));
        $mpdf->Output();
    }


    /**
     * @Route("/modal-show/{id}", name="app_demande_de_prix_show", methods={"GET", "POST"})
     */
    public function show(DemandeDePrix $demandeDePrix): Response
    {
        $view = $this->renderView('demande_de_prix/partials/_card_show.html.twig', compact('demandeDePrix'));
        return new JsonResponse($view);
    }


    #[Route('/{id}/edit', name: 'app_demande_de_prix_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, DemandeDePrix $demandeDePrix, DemandeDePrixRepository $demandeDePrixRepository): Response
    {
        $form = $this->createForm(DemandeDePrixType::class, $demandeDePrix);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $demandeDePrixRepository->add($demandeDePrix);
            return $this->redirectToRoute('app_demande_de_prix_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('demande_de_prix/edit.html.twig', [
            'demande_de_prix' => $demandeDePrix,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_demande_de_prix_delete', methods: ['POST'])]
    public function delete(Request $request, DemandeDePrix $demandeDePrix, DemandeDePrixRepository $demandeDePrixRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$demandeDePrix->getId(), $request->request->get('_token'))) {
            $demandeDePrixRepository->remove($demandeDePrix);
        }

        return $this->redirectToRoute('app_demande_de_prix_index', [], Response::HTTP_SEE_OTHER);
    }
}
