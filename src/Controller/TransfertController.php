<?php

namespace App\Controller;

use App\Entity\Magasin;
use App\Entity\Transfert;
use App\Form\TransfertType;
use App\Repository\MagasinRepository;
use App\Repository\TransfertRepository;
use App\Services\LibrairieService;
use Doctrine\DBAL\Types\IntegerType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\FormInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Encoder\JsonEncoder;
use Symfony\Component\Serializer\Encoder\XmlEncoder;
use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Serializer;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

/**
 * @Route("/admin/transfert")
 */
class TransfertController extends AbstractController
{
    protected $em;
    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
    }

    /**
     * @Route("/", name="app_transfert_index", methods={"GET", "POST"})
     */
    public function index(Request $request, ValidatorInterface $validator, TransfertRepository $transfertRepository): Response
    {
        $transfert = new Transfert();
        $form = $this->createForm(TransfertType::class, $transfert);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $transfertRepository->add($transfert);
            return new JsonResponse($transfert->getId()
                ? 'Modification effectuée avec succès.'
                : 'Enregistrement effectué avec succès.'
            );
        }

        return $this->renderForm('transfert/index.html.twig', [
            'transferts' => $transfertRepository->findAll(),
            'transfert' => $transfert,
            'form' => $form,
            'errors' => $this->getErrorsFromForm($form)
        ]);
    }

    private function getErrorsFromForm(FormInterface $form)
    {
        $errors = array();
        foreach ($form->getErrors() as $error) {
            $errors[] = $error->getMessage();
        }
        foreach ($form->all() as $childForm) {
            if ($childForm instanceof FormInterface) {
                if ($childErrors = $this->getErrorsFromForm($childForm)) {
                    $errors[$childForm->getName()] = $childErrors;
                }
            }
        }
        return $errors;
    }

    /**
     * @Route("/new/xxxxxxxxxxx", name="app_transfert_new", methods={"GET", "POST"})
     */
    public function new(Request $request, TransfertRepository $transfertRepository, MagasinRepository $magasinRepository): Response
    {
        $parameters = $request->query->all();
        $transfert = new Transfert();
        $choices = isset($parameters['id']) ? $magasinRepository->findAllExceptThis($parameters['id']) : [];
        $form = $this->createForm(TransfertType::class, $transfert, [
            'id_mag' => isset($parameters['id']) ? $parameters['id'] : 0,
            'list' => $choices,
            'action' => $this->generateUrl('app_transfert_new'),
        ]);
        $form->handleRequest($request);
        //dd($form->getData());
        if($form->isSubmitted() && $form->isValid())
        {
            /*$mag = $magasinRepository->find($parameters['transfert']['magasinTrans2']);
            $transfert->setMagasinTrans2($mag);*/
            $transfertRepository->add($transfert);
            dd($form->getData());
        }

        $html = $this->renderView('transfert/partials/_form.html.twig', [
            'transfert' => $transfert,
            'form' => $form->createView()
        ]);

        return new JsonResponse($html);
    }

    /**
     * @Route("/{id}", name="app_transfert_show", methods={"GET"})
     */
    public function show(Transfert $transfert): Response
    {
        return $this->render('transfert/show.html.twig', [
            'transfert' => $transfert,
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_transfert_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Transfert $transfert, TransfertRepository $transfertRepository): Response
    {
        $form = $this->createForm(TransfertType::class, $transfert);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $transfertRepository->add($transfert);
            return $this->redirectToRoute('app_transfert_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('transfert/edit.html.twig', [
            'transfert' => $transfert,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_transfert_delete", methods={"POST"})
     */
    public function delete(Request $request, Transfert $transfert, TransfertRepository $transfertRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$transfert->getId(), $request->request->get('_token'))) {
            $transfertRepository->remove($transfert);
        }

        return $this->redirectToRoute('app_transfert_index', [], Response::HTTP_SEE_OTHER);
    }

    /**
     * @Route("/transfert/options-json", name="app_load_select_json", methods={"GET", "POST"})
     */
    public function loadSelectAjax(Request $request)
    {
        $parameters = $request->getMethod() === 'POST' ? $request->request->all() : $request->query->all();
        $results = [];
        if(isset($parameters['id']) && !empty($parameters['id']))
        {
            $search = '';
            if(isset($parameters['search']) && !empty($parameters['search']))
                $search = $parameters['search'];
            $results = $this->em->createQuery("
            SELECT pc.id, CONCAT(pt.nomProd, ' [', c.libelleCond, ']') AS text, pc.prixDeVenteTTC, pc.qteStockCond, pm.qteStockMag
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

    /**
     * @Route("/magasinTrans2/load/options-json", name="app_magasinTrans2_select", methods={"GET", "POST"})
     */
    public function loadMagasinTrans2(Request $request)
    {
        $parameters = $request->getMethod() === 'POST' ? $request->request->all() : $request->query->all();
        $results = [];
        if(isset($parameters['id']) && !empty($parameters['id']))
        {
            $search = '';
            if(isset($parameters['search']) && !empty($parameters['search']))
                $search = $parameters['search'];
            $results = $this->em->createQuery("
            SELECT m.id, m.nomMag AS text
            FROM App\Entity\Magasin m
            WHERE m.nomMag LIKE '%$search%' AND m.id != " . $parameters['id']
            )->getArrayResult();
        }

        return new JsonResponse($results);
    }
}
