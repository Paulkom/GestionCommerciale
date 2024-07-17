<?php

namespace App\Form;

use App\Entity\Produit;
use App\Entity\ProduitCondComClit;
use App\Entity\ProduitConditionnement;
use App\Entity\ProduitCondMagLiv;
use App\Form\DataTransformer\ProdCondToNumberTransformer;
use App\Repository\ProduitCondComClitRepository;
use App\Repository\ProduitConditionnementRepository;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\Mapping\Entity;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\CallbackTransformer;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\Test\FormInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ProduitCondMagLivType extends AbstractType
{

    private $transformer;

    public function __construct(ProdCondToNumberTransformer $transformer,
    // private ProduitConditionnementRepository $prodRepository,
     private ProduitCondComClitRepository $prodCliRepository,
     private EntityManagerInterface $em)
    {
        
    }


    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        ->add('produitComClit', EntityType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Produit',
            //'mapped'=>false,
            'class' => ProduitCondComClit::class,
            'choice_attr' => function(ProduitCondComClit $produit){
                return [
                    "data-restaliv" => $produit->getRestAliv(),
                    "data-prix"  =>$produit->getPrix(),
                    "data-qtite"  =>$produit->getQtite(),
                    "data-montant" =>$produit->getMontant(),
                    // 'piece-par-carton'      => $produit->getProduit()->getProduit()->getPieceParCarton(),
                    // 'piece-par-metrecarre'  => $produit->getProduit()->getProduit()->getPieceParMetreCarre(),
                    // 'surface-par-piece'     => $produit->getProduit()->getProduit()->getSurfaceParPiece(),
                    // 'm2-par-carton'         => $produit->getProduit()->getProduit()->getMetreCarreParCarton(),
                    // 'est-mode-carreau'      => ($produit->getProduit()->getProduit()->getEstModeCarreau()) ? 1 : 0,
                    // 'est-service'           => ($produit->getProduit()->getProduit()->getEstService()) ? 1 : 0
                ];
            },
            'placeholder'=> 'Sélectionnez le produit',
            'choices' => [],
            'attr' => ['required' => true, 
                'data-control' => "select2",
                'class' => 'form-control form-select',
                'data-placeholder' => 'Sélectionnez le produit',
            ],
        ])
        ->add('prix',HiddenType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Prix',
            'required' => true,
            'attr' => ['required'=>true, 
            'class'=>'form-control mb-2', 
            'placeholder' => 'Prix'],
        ])
        ->add('qteLiv',NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Qté livrée',
            'required' => true,
            'attr' => ['required'=>true, 
            'readonly'=>false,
            'class'=>'form-control mb-2', 
            'placeholder' => 'Entrer la quantité'],
        ])
        ->add('qteRALiv',NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Qté restante',
            'required' => true,
            'attr' => ['required'=>true, 
            'readonly'=>true,
            'class'=>'form-control mb-2 form-control-solid qteraliv', 
            'placeholder' => 'Entrer la quantité'],
        ])
        ->add('qteALiv',NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Qté à livrer',
            'required' => true,
            'attr' => ['required'=>true, 
            'readonly'=>true,
            'class'=>'form-control mb-2 form-control-solid', 
            'placeholder' => 'Entrer la quantité'],
        ])
        ->add('carton',NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Nb Carton',
            'required' => false,
            'attr' => ['required'=>false, 
            'readonly'=>true,
            'class'=>'form-control mb-2 form-control-solid', 
            'placeholder' => ''],
        ])
        ->add('piece',NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Nb Pièce',
            'required' => false,
            'attr' => ['required'=>false, 
            'readonly'=>true,
            'class'=>'form-control mb-2 form-control-solid', 
            'placeholder' => ''],
        ])
        ;
        // ->add('montantCond',NumberType::class, [
        //     'label_attr' => ['class' => 'form-label'],
        //     'label' => 'Montant',
        //     'required' => true,
        //     'attr' => ['required'=>true, 
        //     'readonly'=>true,
        //     'class'=>'form-control mb-2 montant form-control-solid', 
        //     'placeholder' => 'montant'],
        // ]) ;

        $builder->addEventListener(
            FormEvents::PRE_SUBMIT, function (FormEvent $event) {
                $forme = $event->getForm();
                $data = $event->getData();
                //dd('data',$data);
                if(!($data === null))
                {
                    $pro = $this->prodCliRepository->find((int)$data["produitComClit"]); 
                   // dd($data["produitComClit"],$pro);
                    $forme->remove("produitComClit");
                    $forme->add('produitComClit', EntityType::class, [
                    'label' => 'Produit',
                    'class' => ProduitCondComClit::class,
                    'choices'=>[$pro]
                    ]);
                   
                }else{

                    
                }
                
            }
        );    

    $builder->addEventListener(FormEvents::PRE_SET_DATA, function (FormEvent $event){
        $data = $event->getData();
        $form = $event->getForm();
        if(!($data === null) && $data->getId())
        {
            /**
             * @var ProduitCondComClit[] $produits
             *  @var ProduitConditionnement[] $clipro1
             */
           // $produits = $data->getLivraisonMag()->getLivraison()->getCommandeCli() === null ? [] : $this->prodCliRepository->findByCommandeClit($data->getLivraisonMag()->getLivraison()->getCommandeCli());
            $clipro = $data->getLivraisonMag()->getLivraison()->getCommandeCli()->getProduitCondComClits();
            //dump( $clipro1);
            //$produit = $data->getProduit()->getId() === null ? null : $this->prodCliRepository->getOnPro($data->getProduit()->getId(),$data->getLivraisonMag()->getLivraison()->getCommandeCli()->getId());

            //$data->setProduitComClit($produit);
           //$event->setData($data);
            $form->remove('produitComClit')
            ->add('produitComClit',EntityType::class, [                                               
                'required' => true,
                'label_attr' => ['class' => 'form-label'],
                'label_html' => true,
                'class' => ProduitCondComClit::class,
                'choice_attr' => function(ProduitCondComClit $produit){
                    return [
                        "data-restaliv" => $produit->getRestAliv(),
                        "data-prix"  => $produit->getPrix(),
                        "data-qtite"  => $produit->getQtite(),
                        "data-montant" => $produit->getMontant(),
                    ];
                },
                'placeholder'=> 'Sélectionnez le produit',
                'attr' => [
                    'required' => true, 
                    'data-control' => "select2",
                    'class' => 'form-control form-select',
                    'data-placeholder' => 'Sélectionnez le produit',
                ],
                'choices'=> $clipro,
                //$data->getLivraisonMag()->getLivraison()->getCommandeCli()->getProduitCondComClits()
            ])
            ;
        }
    });


}

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProduitCondMagLiv::class,
        ]);
    }


}
