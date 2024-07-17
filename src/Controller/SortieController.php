<?php

namespace App\Controller;

use App\Entity\Sortie;
use App\Form\SortieType;
use App\Repository\SortieRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

#[Route('/admin/sortie')]
class SortieController extends AbstractController
{
    protected $em;
    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
    }

    #[Route('/', name: 'app_sortie_index', methods: ['GET', 'POST'])]
    public function index(Request $request, SortieRepository $sortieRepository): Response
    {
        $sortie = new Sortie();
        $form = $this->createForm(SortieType::class, $sortie);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $sortieRepository->add($sortie);
            if($sortie->getId() != null)
                return new JsonResponse("Sortie effectuée avec succès.");
        }

        return $this->renderForm('sortie/index.html.twig', [
            'sorties' => $sortieRepository->findAll(),
            'nbSortie' => sizeof($sortieRepository->findAll()),
            'sortie' => $sortie,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_sortie_show', methods: ['GET'])]
    public function show(Sortie $sortie): Response
    {
        $form = $this->createForm(SortieType::class, $sortie)->createView();
        $view = $this->render('sortie/partials/_card_show.html.twig', compact('sortie', 'form'));
        return $view;
    }

    /**
     * @Route("/auteurSortie/load/options-json", name="app_auteurSortie_select", methods={"GET", "POST"})
     */
    public function loadAuteurSortie(Request $request)
    {
        $parameters = $request->getMethod() === 'POST' ? $request->request->all() : $request->query->all();
        $search = '';

        if(isset($parameters['search']) && !empty($parameters['search']))
            $search = $parameters['search'];

        $results = $this->em->createQuery("
            SELECT p.id, CONCAT(p.nom, ' ', p.prenoms) AS text
            FROM App\Entity\Personnel p
            WHERE CONCAT(p.nom, ' ', p.prenoms) LIKE '%$search%'"
        )->getArrayResult();

        return new JsonResponse($results);
    }

    /**
     * @Route("/magasinSortie/load/options-json", name="app_magasinSortie_select", methods={"GET", "POST"})
     */
    public function loadMagasinSortie(Request $request)
    {
        $parameters = $request->getMethod() === 'POST' ? $request->request->all() : $request->query->all();
        $search = '';

        if(isset($parameters['search']) && !empty($parameters['search']))
            $search = $parameters['search'];

        $results = $this->em->createQuery("
            SELECT m.id, m.nomMag AS text
            FROM App\Entity\Magasin m
            WHERE m.nomMag LIKE '%$search%'"
        )->getArrayResult();

        return new JsonResponse($results);
    }

    /**
     * @Route("/produitSortie/options-json", name="app_produitSortie_select", methods={"GET", "POST"})
     */
    public function loadProduitSortie(Request $request)
    {
        $parameters = $request->getMethod() === 'POST' ? $request->request->all() : $request->query->all();
        $results = [];
        if(isset($parameters['id']) && !empty($parameters['id']))
        {
            $search = '';
            if(isset($parameters['search']) && !empty($parameters['search']))
                $search = $parameters['search'];
            $results = $this->em->createQuery("
            SELECT pc.id, CONCAT(pt.nomProd, ' [', c.libelleCond, ']') AS text, pc.prixDeVenteTTC, pc.qteStockCond, pm.qteStockMag,
            CONCAT(m.id, '-', pc.id) AS magasinProduitConId
            FROM App\Entity\ProduitConditionnement pc
            INNER JOIN pc.conditionnement c
            INNER JOIN pc.produit pt
            INNER JOIN pc.produitCondMags pm
            INNER JOIN pm.magasin m
            WHERE pm.qteStockMag > 0 
            AND pt.estSup IS NULL
            AND CONCAT(pt.nomProd, ' [', c.libelleCond, ']') LIKE '%$search%' AND m.id = " . $parameters['id']
            )->getArrayResult();
        }

        return new JsonResponse($results);
    }
}
