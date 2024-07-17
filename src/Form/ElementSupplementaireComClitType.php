<?php

namespace App\Form;

use App\Entity\ElementSupplementaire;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;

class ElementSupplementaireComClitType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        ->add('titre', TextType::class, [
            'label' => "Titre",
            'attr' => ['class' => 'form-control form-control-sm'],
            'required' => true,
        ])
        ->add('description', TextType::class, [
            'label' => "Détails",
            'attr' => ['class' => 'form-control form-control-sm'],
            'required' => true,
        ])
        ->add('taillePolice', IntegerType::class, [
            'label' => "Taile de police",
            'data' => 12,
            'attr' => ['class' => 'form-control form-control-sm'],
            'required' => true,
        ])
        ->add('position', ChoiceType::class, [
            'label' => '',
            'attr'  => [ 
                'data-control' => "select2", 
                'class' => 'form-control form-control-sm' ,
                'placeholder' =>"Veuillez sélectionner un element"
            ],
            'placeholder'=> 'Sélectionnez une position',
            'choices'=> [
                'GAUCHE' => 'GAUCHE',
                'CENTER' => 'CENTER',
                'DROIT' => 'DROIT',
            ],
            'choice_attr' => [
                'GAUCHE' => ['selected' => true],
            ],
        ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ElementSupplementaire::class,
        ]);
    }
}
