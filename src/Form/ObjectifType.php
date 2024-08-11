<?php

namespace App\Form;

use App\Entity\Objectif;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ObjectifType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('montantObjectif',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Valeur',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2 form-control-solid', 
                'placeholder' => '1 000 000'],
            ])
            ->add('dateMois', DateTimeType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date Début',
                'html5' => true,
                'widget' => 'single_text',
                'required' => false,
                'attr' => [
                    'class' => 'form-control form-control-solid',
                    'placeholder' => 'Date'
                ],
            ])
            ->add('keys', HiddenType::class,[
                'mapped' => false,
                'attr' => ['class'=>'keys','data-id'=>'']
            ]);
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Objectif::class,
        ]);
    }
}
