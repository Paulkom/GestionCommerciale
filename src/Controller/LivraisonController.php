<?php

namespace App\Controller;

use App\Entity\Livraison;
use App\Form\LivraisonType;
use App\Repository\LivraisonRepository;
use App\Repository\ModelSignataireRepository;
use App\Repository\SocieteRepository;
use App\Services\LibrairieService;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/admin/liv/livraison')]
class LivraisonController extends AbstractController
{
    #[Route('/', name: 'app_livraison_index', methods: ['GET','POST'])]
    public function index(Request $request,LivraisonRepository $livraisonRepository): Response
    {
        $livraison = new Livraison();
        $form = $this->createForm(LivraisonType::class, $livraison);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            //dump($form->get("truc")->getData());
            $nbproduits = $livraison->getCommandeCli()->getProduitCondComClits()->filter(function($element) {
                return $element->getRestAliv() > 0;
            })->count();
            $nbproduitlivre = 0;
             foreach ($livraison->getLivraisonMagasins() as $lmag) {
                $nbproduitlivre += $lmag->getProduitCondMagLivs()->count();
             }

            if ($livraison->getTotalResteAliv() > 0 || $nbproduits > $nbproduitlivre)
                $livraison->getCommandeCli()->setStatutLiv("Partielle");
            elseif($livraison->getTotalResteAliv() ==0)
                $livraison->getCommandeCli()->setStatutLiv("Terminée");
            
            $livraisonRepository->add($livraison);
            if($livraison->getId() != null){
                /* Créez une nouvelle instance qui portent un nom différent de l'ancienne instance */
                $livraison2 = new Livraison();
                /* Créez une nouvelle instance de form qui portent un nom différent de l'ancienne instance */
                $form2 = $this->createForm(LivraisonType::class, $livraison2);
                $html = $this->renderView('livraison/partials/_card_form.html.twig', ['livraison' => $livraison2,'form' => $form2->createView() ]);
                $comp ="§".$livraison->getId()."§".$form->get("truc")->getData()."§".$html;
                return new JsonResponse("Enregistrement effectué avec succès".$comp);
            }
        }
        return $this->renderForm('livraison/index.html.twig', [
            'livraison' => $livraison,
            'form' => $form,
        ]);
    }

    #[Route('/imprime/livraison/doc', name: 'imprime_livraison_new', methods: ['GET', 'POST'])]
    public function imprime(Request $request, ModelSignataireRepository $modelRep, SocieteRepository $sociRep, LivraisonRepository $livrRep, LibrairieService $library){
        $id = $request->request->get('id');
        $format = "A4-P";
        $signataires = $modelRep->findOneBy(["estDefault"=>true]);
        $ent = null;

        if($sociRep->findAll()){
            $ent = ($sociRep->findAll())[0];
        }
        //dd($format);
        $livraison = $livrRep->find($id);
        $htmlPage = $this->renderView("livraison/document/bon.html.twig",[
            'livraison'=>$livraison,
            'format'=>$format,
            'signataires'=>$signataires,
            'societe'=>$ent,
        ]);
        return $library->mpdf([$htmlPage],"Bordereau de livraison",$format);
    }

    #[Route('/new', name: 'app_livraison_new', methods: ['GET', 'POST'])]
    public function new(Request $request, LivraisonRepository $livraisonRepository): Response
    {
        $livraison = new Livraison();
        $form = $this->createForm(LivraisonType::class, $livraison);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $livraisonRepository->add($livraison);
            return $this->redirectToRoute('app_livraison_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('livraison/new.html.twig', [
            'livraison' => $livraison,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_livraison_show', methods: ['GET','POST'])]
    public function show(Livraison $livraison): Response
    {
        $results['html'] = $this->renderView('livraison/show.html.twig', [
            'livraison' => $livraison,
        ]);
        return new JsonResponse($results);
    }

    #[Route('/{id}/edit', name: 'app_livraison_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Livraison $livraison, LivraisonRepository $livraisonRepository): Response
    {
        $form = $this->createForm(LivraisonType::class, $livraison);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $livraisonRepository->add($livraison);
            return $this->redirectToRoute('app_livraison_index', [], Response::HTTP_SEE_OTHER);
        }
        return $this->renderForm('livraison/index.html.twig', [
            'livraison' => $livraison,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_livraison_delete', methods: ['POST'])]
    public function delete(Request $request, Livraison $livraison, LivraisonRepository $livraisonRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$livraison->getId(), $request->request->get('_token'))) {
            $livraisonRepository->remove($livraison);
        }

        return $this->redirectToRoute('app_livraison_index', [], Response::HTTP_SEE_OTHER);
    }
}
