<?php

namespace App\Form;

use App\Entity\CommandeFrs;
use App\Entity\Fournisseur;
use App\Entity\DemandeDePrix;
use App\Form\ProduitCondComFrsType;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class CommandeFrsType extends AbstractType
{
    private $em;
    private SessionInterface $session;
    public function __construct(EntityManagerInterface $em,  SessionInterface $session)
    {
        $this->em  = $em;
        $this->session = $session;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        ->add('dateComFrs', DateType::class, [
            'widget' => 'single_text',
            'format' => 'yyyy-MM-dd',
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Date',
            'required' => true,
            'attr' => ['required'=>true,
            'class'=>'form-control mb-2', 
            'placeholder' => 'Date de la commande'],
        ])
        ->add('montantTotal', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Montant Total',
            'required' => true,
            'attr' => ['required'=>true,
            'class'=>'form-control mb-2 decimal', 
            'readonly' => true,
            'placeholder' => 'Montant total'],
        ])
        ->add('fournisseur',EntityType::class, [
            'label_attr' => ['class' => 'form-label'],
            'required' => true,
            'label' => 'Fournisseur',
            'class' => Fournisseur::class,
            'choice_label' => function(Fournisseur $four){
                return ($four->getNom())? $four->getNom().' '.$four->getPrenoms() :$four->getDenomination();
            },
            'placeholder'=> 'Sélectionnez un fournisseur',
            'attr' => [
                'required'=>true,
                'class' => 'form-control form-select',
                'data-control' => "select2",
                'data-placeholder' => "Sélectionnez un fournisseur"
            ]
        ])
        // ->add('demandeDePrix',EntityType::class, [
        //     'label_attr' => ['class' => 'form-label'],
        //     'required' => false,
        //     'label' => 'Demande de Prix',
        //     'class' => DemandeDePrix::class,
        //     'choice_label' => function(DemandeDePrix $dem){
        //         return ($dem->getFournisseur()->getNom()) ?
        //         $dem->getId().' - '.$dem->getDateDdp()->format('d/m/Y').' [ '.$dem->getFournisseur()->getNom().' '.$dem->getFournisseur()->getPrenoms().' ]':
        //         $dem->getId().' - '.$dem->getDateDdp()->format('d/m/Y').' [ '.$dem->getFournisseur()->getDenomination().' ]';
        //     },
        //     'placeholder'=> 'Sélectionnez une demande',
        //     'attr' => [
        //         'required'=>false,
        //         'class' => 'form-control form-select',
        //         'data-control' => "select2",
        //         'data-placeholder' => "Sélectionnez une demande"
        //     ]
        // ])
        ->add('produitCondComFrs', CollectionType::class, [
            'required' => true,
            'entry_type' => ProduitCondComFrsType::class,
            'entry_options' => ['label' => false],
            'label' => false,
            'required' => true,
            'allow_add' => true,
            'allow_delete' => true,
            'by_reference' => false,
            'prototype_name' => '__produitCondComFrs__'
        ])
        ->add('demandeDePrixToCommande', HiddenType::class, [
            'mapped' => false,
            'label' => 'Demande de prix',
            'required' => false,
        ])
        ;

        $builder->addEventListener(FormEvents::PRE_SET_DATA, function (FormEvent $event){
            $data = $event->getData();
            $form = $event->getForm();
            
            if(!(null === $data->getDemandeDePrix()))
            {
               
                $form->add('demandeDePrix',EntityType::class, [
                    'label_attr' => ['class' => 'form-label'],
                    'required' => false,
                    'label' => 'Demande de Prix',
                    'class' => DemandeDePrix::class,
                    'query_builder' => function(){
                        $pv = $this->session->get('pointVente', []);
                        $qb = $this->em->createQueryBuilder()
                            ->select('d')
                            ->from("App\\Entity\\DemandeDePrix",'d')
                            ->where('d.estSup IS NULL')
                            ->andWhere('d.pointVente = :val')
                            ->setParameter('val', ($pv != [])? $pv->getId() : 0 )
                            ;
                        return $qb; 
                    },
                    'choice_label' => function(DemandeDePrix $dem){
                        return ($dem->getFournisseur()->getNom()) ?
                        $dem->getId().' - '.$dem->getDateDdp()->format('d/m/Y').' [ '.$dem->getFournisseur()->getNom().' '.$dem->getFournisseur()->getPrenoms().' ]':
                        $dem->getId().' - '.$dem->getDateDdp()->format('d/m/Y').' [ '.$dem->getFournisseur()->getDenomination().' ]';
                    },
                    'placeholder'=> 'Sélectionnez une demande',
                    'attr' => [
                        'required'=>false,
                        'class' => 'form-control form-select',
                        'data-control' => "select2",
                        'data-placeholder' => "Sélectionnez une demande"
                    ]
                ]);
            }
            
        });
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => CommandeFrs::class,
        ]);
    }
}
