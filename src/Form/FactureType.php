<?php

namespace App\Form;

use App\Entity\CommandeClient;
use App\Entity\Facture;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class FactureType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('truc',HiddenType::class,[
                'mapped'=>false,
                ])
            ->add('dateFac',BirthdayType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date de facturation',
                'required' => true,
                'attr' => ['required'=>true,
                'readonly'=>true,
                'class'=>'form-control mb-2 form-control-solid', 
                'placeholder' => 'Date de facture'],
            ])
            ->add('montantTotal',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant total',
                'required' => true,
                'attr' => ['required'=>true, 
                'readonly'=>true,
                'class'=>'form-control mb-2 form-control-solid', 
                'placeholder' => 'montant'],
            ])
            ->add('montantTotalCmd',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant de la commande',
                'required' => true,
                'attr' => ['required'=>true, 
                'readonly'=>true,
                'class'=>'form-control mb-2 form-control-solid', 
                'placeholder' => 'Montant de la commande'],
            ])
            ->add('commandeCli',EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Commande',
                'class' => CommandeClient::class,
                'choice_attr' => function(CommandeClient $commandeClient){
                    return [
                        'data-montantIni'  => $commandeClient->getMontantTtc(),
                        'data-MontantRest' => $commandeClient->getMontantRest(),
                    ];
                },
                'placeholder' => 'Sélectionnez ue commande...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ],
            ])
            ->add('prodCondFacts', CollectionType::class, [
                'required' => true,
                'entry_type' => ProdCondFactType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__prodCondFacts__'
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Facture::class,
        ]);
    }
}
