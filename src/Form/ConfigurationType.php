<?php

namespace App\Form;

use App\Entity\Configuration;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;

class ConfigurationType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('formatImpression', ChoiceType::class, [
                'label' => '',
                'attr'  => [ 
                    'data-control' => "select2", 
                    'class' => 'form-control form-control-sm' ,
                    'placeholder' =>"Veuillez sélectionner un format"
                ],
                'placeholder'=> 'Sélectionnez un format',
                'choices'=> [
                    'A4' => 'A4',
                    'A5' => 'A5',
                    'A6' => 'A6',
                    'T1' => 'T1',
                ],
            ])
            ->add('estModeCarreau', CheckboxType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Est Mode Carreau ?',
                'required' => false,
                'attr' => [
                    'class' => 'form-check-input',
                ],
            ])
            ->add('impressionPersonnaliseElements', CheckboxType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => ' Personnaliser les éléments d\'entête  (Impression) ?',
                'required' => false,
                'attr' => [
                    'class' => 'form-check-input',
                ],
            ])
            ->add('impressionSansEntete', CheckboxType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Impression sans entête ?',
                'required' => false,
                'attr' => [
                    'class' => 'form-check-input',
                ],
            ])
            ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Configuration::class,
        ]);
    }
}
