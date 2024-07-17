<?php

namespace App\Form;

use App\Entity\Banque;
use App\Entity\CompteBanque;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class CompteBanqueType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('numeroCompteBQ', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'N° Compte',
                'required' => true,
                'attr' => ['required'=>true,
                    'class'=>'form-control mb-2',
                    'placeholder' => 'N° Compte'],
            ])
            /*->add('soldeCompteBQ', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Solde',
                'required' => true,
                'attr' => [
                    'required'=>true,
                    'class'=>'form-control mb-2',
                    'placeholder' => '0'
                ],
            ])*/
            ->add('banque', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Banque',
                'class' => Banque::class,
                'choice_label' => 'sigle',
                'choice_attr'  => function(Banque $banque){
                    return ['optionValue' => 'banque-'.$banque->getId() ];
                },
                'placeholder'=> 'Sélectionnez une banque...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select banque',
                ],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => CompteBanque::class,
        ]);
    }
}
