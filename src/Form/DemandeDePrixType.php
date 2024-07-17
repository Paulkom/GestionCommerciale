<?php

namespace App\Form;

use App\Entity\Fournisseur;
use App\Entity\DemandeDePrix;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\TextType;

class DemandeDePrixType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('dateDdp', DateType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 physique', 
                'placeholder' => 'Date de la demande'],
            ])
            // ->add('montantTotal', TextType::class, [
            //     'label_attr' => ['class' => 'form-label'],
            //     'label' => 'Montant Total',
            //     'required' => true,
            //     'attr' => ['required'=>true,
            //     'class'=>'form-control mb-2 total', 
            //     'placeholder' => 'Montant total'],
            // ])
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
            ->add('produitCondDdps', CollectionType::class, [
                'required' => true,
                'entry_type' => ProduitCondDdpType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__produitCondDdps__'
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => DemandeDePrix::class,
        ]);
    }
}
