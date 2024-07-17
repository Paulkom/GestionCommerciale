<?php

namespace App\Form;

use App\Entity\Personnel;
use App\Entity\Inventaire;
use App\Entity\PersonneInv;
use App\Entity\TypeInventaire;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\DateTimeType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;

class InventaireType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('dateDebutInv', DateTimeType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date Début',
                'html5' => true,
                'widget' => 'single_text',
                'required' => false,
                'attr' => [
                    'class' => 'form-control form-control-solid',
                    'placeholder' => 'Début'
                ],
            ])
            ->add('dateFinInv', DateTimeType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date Fin',
                'html5' => true,
                'widget' => 'single_text',
                'required' => false,
                'attr' => [
                    'class' => 'form-control form-control-solid',
                    'placeholder' => 'Fin'
                ],
            ])
            ->add('motif', TextareaType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Motif',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control form-control-solid',
                    'placeholder' => 'Motif'
                ],
            ])
            ->add('estCloturer', HiddenType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Motif',
            ])
            /*->add('typeInv', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Type d\'inventaire',
                'class' => TypeInventaire::class,
                'choice_label' => 'libelle',
                'placeholder'=> 'Sélectionnez un type d\'inventaire...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select',
                ],
            ])*/
            ->add('personnesConcernees', EntityType::class, [
                'required' => true,
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Personnes concernées',
                'class' => Personnel::class,
                'placeholder'=> 'Sélectionnez les personnes concernées...',
                'multiple' =>true,
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'data-close-on-select' => "false",
                    'data-allow-clear' => "true",
                    'data-placeholder' => "Sélectionnez les personnes concernées...",
                    'multiple' => "multiple",
                    'class' => 'form-select',
                ],
            ])
            ->add('inventaireMags', CollectionType::class, [
                'required' => true,
                'entry_type' => InventaireMagType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__inventaireMags__'
            ]);
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Inventaire::class,
        ]);
    }
}
