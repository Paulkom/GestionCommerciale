<?php

namespace App\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\OptionsResolver\OptionsResolver;

class FiltrePeriodeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        ->add('dateDebut', DateType::class, [
            "widget" => 'single_text',
            "format" => 'dd/MM/yyyy',
            'html5' => false,
            'required' => true,
            'label_html' => true,
            'label'=>'Date début',
            'attr' => [
                'data-kt-etat-table-filter'=>"date2",
                'class' => 'form-control form-control-inline',
                'placeholder' => 'Date début',
            ],
        ])
        ->add('dateFin', DateType::class, [
            "widget" => 'single_text',
            "format" => 'dd/MM/yyyy',
            'html5' => false,
            'required' => true,
            'label_html' => true,
            'label'=>'Date Fin',
            'attr' => [
                'class' => 'form-control form-control-inline',
                'placeholder' => 'Date fin',
                'data-kt-etat-table-filter'=>"date2",
            ],
        ])
        ->add('search', TextType::class, [
            'required' => false,
            'label'=>'Mot cle',
            'attr' => [
                'class' => 'form-control form-control-inline',
                'placeholder' => 'Rechercher...',
                'data-kt-etat-table-filter'=>"search"
            ],
        ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            // Configure your form options here
        ]);
    }
}
