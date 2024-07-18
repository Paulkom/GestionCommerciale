<?php

namespace App\Form;

use App\Entity\Famille;
use App\Entity\Magasin;
use App\Entity\Produit;
use App\Entity\GroupeTaxe;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use phpDocumentor\Reflection\Types\False_;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class ProduitType extends AbstractType
{
    private $em;
    private SessionInterface $session;

    public function __construct(EntityManagerInterface $entityManager, SessionInterface $session)
    {
        $this->em = $entityManager;
        $this->session = $session;
    }
    
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('modeDefPrix', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Mode Prix',
                'choices' => [
                    'HT'    => 0,
                    'TTC'   => 1,
                ],
                'placeholder' => 'Mode Prix...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-control form-select',
                   // 'data-placeholder' => 'Mode Prix...'
                ],
            ])
            ->add('groupeTaxe', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Groupe de taxe',
                'class' => GroupeTaxe::class,
                'choice_label' => 'libelleGr',
                'choice_attr' => function (GroupeTaxe $groupeTaxe) {
                    $taxe = $groupeTaxe->getTauxGr();
                    $valTaux = 0;
                    if($taxe->getTypeTaux() === 0)
                        $valTaux = $taxe->getTaux() / 100;
                    if($taxe->getTypeTaux() === 1 || $taxe->getTypeTaux() === 2)
                        $valTaux = $taxe->getTaux();

                    return [
                        'data-taux' => $valTaux,
                    ];
                },
                'placeholder' => 'Groupe de taxe...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select',
                    //'data-placeholder' => 'Groupe de taxe...'
                ],
            ])
            ->add('suiviStock', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Méthode de gestion de stock',
                'choices' => [
                    'Aucune' => 0,
                    'CUMP'   => 1,
                    'PEPS'   => 2,
                    'DEPS'   => 3,
                    'LOT'    => 4,
                    'NIFO'   => 5,
                ],
                'choice_attr' => [
                    'Aucune' => ['selected' => true]
                ],
                'placeholder' => 'Sens...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-control form-select ignoreInEstService ignoreInEstServiceActif',
                    //'data-placeholder' => 'Suivi stock...'
                ],
            ])
            ->add('refProd', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Référence',
                'required' => false,
                'attr' => [
                    'data-column' =>'Produit|refProd',
                    'required'=>false,
                    'class'=>'form-control unicite',
                    'placeholder' => 'Entrer la référence du produit'
                ],
            ])
            ->add('nomProd', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Nom Produit',
                'required' => true,
                'attr' => [
                    'data-column' =>'Produit|nomProd',
                    'required'=>true,
                    'class'=>'form-control unicite',
                    'placeholder' => 'Nom du produit'
                ],
            ])
            ->add('descProd', TextareaType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Description',
                'required' => false,
                'attr' => [
                    'class'=>'form-control ',
                    'placeholder' => 'Description du produit'
                ],
            ])
            ->add('prixVenteProd', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Prix de vente',
                'required' => false,
                'attr' => [
                    'class'=>'form-control  decimal ignoreInEstService',
                    'placeholder' => '0'
                ],
            ])
            ->add('metreCarreParCarton', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'M² par carton',
                'required' => false,
                'attr' => [
                    'class'=>'form-control  decimal carreau',
                    'placeholder' => '0'
                ],
            ])
            ->add('pieceParCarton', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Pièce par carton',
                'required' => false,
                'attr' => [
                    'class'=>'form-control  decimal carreau',
                    'placeholder' => '0'
                ],
            ])
            ->add('pieceParMetreCarre', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Pièce par M²',
                'required' => false,
                'attr' => [
                    'class'=>'form-control  decimal carreau',
                    'placeholder' => '0'
                ],
            ])
            ->add('surfaceParPiece', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Surface par pièce',
                'required' => false,
                'attr' => [
                    'class'=>'form-control  decimal carreau',
                    'placeholder' => '0'
                ],
            ])
            ->add('couleurCarreau', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Couleur',
                'required' => false,
                'attr' => [
                    'class'=>'form-control',
                    'placeholder' => 'Ex : grise'
                ],
            ])
            ->add('seuilAppro', IntegerType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Seuil Appro.',
                'required' => False,
                'attr' => [
                    'class'=>'form-control ignoreInEstService',
                    'placeholder' => '0'
                ],
            ])
            ->add('estTaxable', CheckboxType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Est Taxable ?',
                'required' => false,
                'attr' => [
                    'class' => 'form-check-input',
                ],
            ])
            // ->add('estModeCarreau', CheckboxType::class, [
            //     'label_attr' => ['class' => 'form-label'],
            //     'label' => 'Est Mode Carreau ?',
            //     'required' => false,
            //     'attr' => [
            //         'class' => 'form-check-input',
            //     ],
            // ])
            ->add('estService', CheckboxType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Est Service ?',
                'required' => false,
                'attr' => [
                    'class' => 'form-check-input',
                ],
            ])
            // ->add('codeQR')
            ->add('famille', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Famille',
                'class' => Famille::class,
                'placeholder'=> 'Sélectionnez une famille...',
                'query_builder' => function(){
                    $pv = $this->session->get('pointVente', []);
                    $qb = $this->em->createQueryBuilder()
                        ->select('f')
                        ->from('App\\Entity\\Famille', 'f')
                        ->andWhere('f.pointVente = :val')
                        ->andWhere('f.deletedAt IS NULL')
                        ->setParameter('val', ($pv != [])? $pv->getId() : 0 )
                    ;
                    return $qb;
                },
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select',
                    //'data-placeholder' => 'Sélectionnez une famille...'
                ],
            ])
            ->add('magasinDefaut', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Magasin par défaut',
                'class' => Magasin::class,
                'placeholder'=> 'Sélectionnez un magasin...',
                'query_builder' => function(){
                    $pv = $this->session->get('pointVente', []);
                    $qb = $this->em->createQueryBuilder()
                        ->select('m')
                        ->from('App\\Entity\\Magasin', 'm')
                        ->andWhere('m.pointVente = :val')
                        ->andWhere('m.deletedAt IS NULL')
                        ->setParameter('val', ($pv != [])? $pv->getId() : 0 )
                    ;
                    return $qb;
                },
                'choice_attr' => function(Magasin $magasin){
                    return ['selected' => ($magasin->getEstPrincipal())? true : false];
                },
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select ignoreInEstService ignoreInEstServiceActif',
                    //'data-placeholder' => 'Sélectionnez une famille...'
                ],
            ])
            ->add('medias', CollectionType::class, [
                'required' => false,
                'entry_type' => MediaType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__medias__'
            ])
            ->add('produitConditionnements', CollectionType::class, [
                'required' => true,
                'entry_type' => ProduitConditionnementType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__produitConditionnements__'
            ])
            ->add('keys', HiddenType::class,[
                'mapped' => false,
                'attr' => [
                    'class'=>'keys',
                    'data-id'=>'',
                    'data-column' =>'Produit|refProd|nomProd']
            ]);
        $builder->addEventListener(FormEvents::PRE_SET_DATA, function (FormEvent $event){
            $data = $event->getData();
            $form = $event->getForm();
            if(!(null === $data))
            {
                $form->remove('keys')
                ->add('keys', HiddenType::class, [
                    'mapped'=>false,
                    'attr' => [
                        'class'=>'keys',
                        'data-id'=>$data->getId(),
                        'data-column' =>'Produit|refProd|nomProd'
                    ]
                ]);
            }
        });
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Produit::class,
        ]);
    }
}
