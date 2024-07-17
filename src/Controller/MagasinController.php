<?php

namespace App\Controller;

use App\Entity\Magasin;
use App\Entity\Transfert;
use App\Form\MagasinType;
use App\Form\TransfertType;
use App\Repository\MagasinRepository;
use App\Services\Datatables;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\FormInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\Normalizer\AbstractNormalizer;
use Symfony\Component\Serializer\Normalizer\DenormalizerInterface;
use Symfony\Component\Serializer\SerializerInterface;

/**
 * @Route("/admin/magasin")
 */
class MagasinController extends AbstractController
{
    protected $em;
    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
    }

    /**
     * @Route("/", name="app_magasin_index", methods={"GET", "POST"})
     */
    public function index(Request $request, MagasinRepository $magasinRepository): Response
    {
        $magasin = new Magasin();
        $form = $this->createForm(MagasinType::class, $magasin);
        $form->handleRequest($request);
        //dd($magasin);
        if ($magasin->getNomMag() != '') {
            $magasinRepository->add($magasin);
            if($magasin->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }
        //return '$magasin->getNomMag()';
        return $this->renderForm('magasin/index.html.twig', [
            'magasins' => $magasinRepository->findAll(),
            'magasin' => $magasin,
            'form' => $form,
        ]);
    }

    function list_filter($list, $args = array(), $operator = 'AND')
    {
            if (!is_array($list)) {
                return array();
            }
            $util = new Datatables($list);
            return $util->filter($args, $operator);
    }
    /**
     * @Route("/{id}", name="app_magasin_show", methods={"GET"})
     */
    public function show(Magasin $magasin): Response
    {
        return $this->render('magasin/show.html.twig', [
            'magasin' => $magasin,
        ]);
    }

     /**
     * @Route("/new", name="app_magasin_new", methods={"GET", "POST"})
     */
    public function new(Request $request, Magasin $magasin, MagasinRepository $magasinRepository): Response
    {
        $magasin = new Magasin();
        $form = $this->createForm(MagasinType::class, $magasin);
        $form->handleRequest($request);

        if ($form->isSubmitted()) {
            $magasinRepository->add($magasin);
            return $this->redirectToRoute('app_magasin_new', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('magasin/new.html.twig', [
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_magasin_delete", methods={"GET", "POST"})
     */
    public function delete(Request $request, Magasin $magasin, MagasinRepository $magasinRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$magasin->getId(), $request->request->get('_token'))) {
            $magasinRepository->remove($magasin);
        }

        return $this->redirectToRoute('app_magasin_index', [], Response::HTTP_SEE_OTHER);
    }

    /**
     * @Route("/recuperer/magasin/json", name="app_get_mag_json", methods={"GET", "POST"})
     */
    public function getMagWithExceptMag(Request $request, MagasinRepository $magasinRepository)
    {
        $parameters = $request->query->all();
        /*$id = $parameters['id'];
        $transfert = new Transfert();
        $transfert->setMagasinTrans2($magasinRepository->find($parameters['id']));
        $form = $this->createForm(TransfertType::class, $transfert);
        $form->remove('magasinTrans2')
            ->add('magasinTrans2', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Magasin B',
                'class' => Magasin::class,
                'query_builder' => function (MagasinRepository $er) use($id) {
                    return $er->createQueryBuilder('m')
                        ->where('m.id != :id')
                        ->setParameters(['id' => $id]);
                },
                'choice_label' => 'nomMag',
                'placeholder'=> 'Sélectionnez un magasin...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select',
                    'data-placeholder' => 'Sélectionnez un magasin...'
                ],
            ]);
        $html = $this->renderView('form.html.twig', ['form'=>$form->createView()]);*/
        $lists = $magasinRepository->findAllExceptThis($parameters['id']);
        $options = '<option value="" selected="selected">Sélectionnez un magasin...</option>';
        foreach ($lists as $list)
        {
            $options .= '<option value="' . $list->getId() . '">' . $list->getNomMag() .'</option>';
        }
        return new JsonResponse($options);
    }
}
