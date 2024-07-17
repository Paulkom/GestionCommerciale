<?php

namespace App\Controller;

use App\Entity\Conditionnement;
use App\Entity\Magasin;
use App\Form\ConditionnementType;
use App\Form\MagasinType;
use App\Repository\ConditionnementRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/admin/conditionnement')]
class ConditionnementController extends AbstractController
{
    public $columnsDefault = [
        'id'                => true,
        'codeCond'          => true,
        'libelleCond'       => true,
        'action'            => true,
    ];
    private $em;
    function __construct(EntityManagerInterface $entityManager){
        $this->em = $entityManager;
    }

    #[Route('/', name: 'app_conditionnement_index', methods: ['GET', 'POST'])]
    public function index(Request $request, ConditionnementRepository $conditionnementRepository): Response
    {
        $conditionnement = new Conditionnement();
        $form = $this->createForm(ConditionnementType::class, $conditionnement);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $conditionnementRepository->add($conditionnement);
            if($conditionnement->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }

        return $this->renderForm('conditionnement/index.html.twig', [
            'conditionnements' => $conditionnementRepository->findAll(),
            'conditionnement' => $conditionnement,
            'form' => $form,
        ]);
    }

    /**
     * @param Request $request
     * @param ConditionnementRepository $conditionnementRepository
     * @return void
     * @Route("/data-load/ajax", name="app_load_data_ajaxx")
     */
    public function ajaxLoad(Request $request) : Response
    {
        $parameters = $request->request->all();
        //Gestion du chargement par ajax
        if (isset($parameters['columnsDef']) && is_array($parameters['columnsDef'])) {
            foreach ($parameters['columnsDef'] as $field) {
                $this->columnsDefault[$field] = true;
            }
        }

        // get all raw data
        $alldata = $this->em->createQuery("
            SELECT c.id, c.codeCond, c.libelleCond
            FROM App\Entity\Conditionnement c
        ")->getArrayResult();

        $data = [];
        // internal use; filter selected columns only from raw data
        foreach ($alldata as $d) {
            $data[] = $this->filterArray($d, $this->columnsDefault);
        }

        // filter by general search keyword
        if (isset($parameters['search']['value']) && $parameters['search']['value']) {
            $data = $this->arraySearch($data, $parameters['search']['value']);
        }
        // count data
        $totalRecords = $totalDisplay = count($data);

        // sort
        if (isset($parameters['order'][0]['column']) && $parameters['order'][0]['dir']) {
            $column = $parameters['order'][0]['column'];
            $dir    = $parameters['order'][0]['dir'];
            usort($data, function ($a, $b) use ($column, $dir) {
                $a = array_slice($a, $column, 1);
                $b = array_slice($b, $column, 1);
                $a = array_pop($a);
                $b = array_pop($b);

                if ($dir === 'asc') {
                    return $a > $b ? 1 : -1;
                }

                return $a < $b ? 1 : -1;
            });
        }

        // pagination length
        if (isset($parameters['length'])) {
            $data = array_splice($data, $parameters['start'], $parameters['length']);
        }

        $data = $this->reformat($data);

        $result = [
            'recordsTotal'    => $totalRecords,
            'recordsFiltered' => $totalDisplay,
            'data'            => $data,
        ];

        return new JsonResponse($result);
    }

    /**
     * @param  array  $data
     *
     * @return array
     */
    public function reformat($data): array
    {
        return array_map(function ($item) {
            // hide credit card number
            /*$item['CreditCardNumber'] = '**** '.substr($item['CreditCardNumber'], -4);

            $item['CreditCardType'] = $item['CreditCardType'] === 'americanexpress' ? 'american-express' : $item['CreditCardType'];

            // reformat datetime
            $item['Datetime'] = date('d M Y, g:i a', strtotime($item['Datetime']));*/

            return $item;
        }, $data);
    }

    public function arraySearch($array, $keyword)
    {
        return array_filter($array, function ($a) use ($keyword) {
            return (boolean) preg_grep("/$keyword/i", (array) $a);
        });
    }

    public function filterArray($array, $allowed = [])
    {
        $arr = array_filter(
            $array,
            function ($val, $key) use ($allowed) { // N.b. $val, $key not $key, $val
                return isset($allowed[$key]) && ($allowed[$key] === true || $allowed[$key] === $val);
            },
            ARRAY_FILTER_USE_BOTH
        );
        //dd(array_keys($arr));
        if(!in_array('action', array_keys($arr)))
        {
            $arr['action'] = $this->renderView('conditionnement/partials/_actions.html.twig', ['id'=>$arr['id']]);
        }
        return $arr;
    }

    #[Route('/{id}', name: 'app_conditionnement_show', methods: ['GET'])]
    public function show(Conditionnement $conditionnement): Response
    {
        return $this->render('conditionnement/show.html.twig', [
            'conditionnement' => $conditionnement,
        ]);
    }

    #[Route('/{id}', name: 'app_conditionnement_delete', methods: ['POST'])]
    public function delete(Request $request, Conditionnement $conditionnement, ConditionnementRepository $conditionnementRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$conditionnement->getId(), $request->request->get('_token'))) {
            $conditionnementRepository->remove($conditionnement);
        }

        return $this->redirectToRoute('app_conditionnement_index', [], Response::HTTP_SEE_OTHER);
    }
}
