<?php

namespace App\Form;

use App\Entity\Personnel;
use App\Form\FonctionPersonnelType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;

class PersonnelType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('nom', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Nom',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer le nom de la personne'],
            ])
            ->add('prenoms', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Prénoms',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer le(s) prénom(s) de la personne'],
            ])
            ->add('tel', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Téléphone',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2 telephone unicite', 
                'data-column' =>'Personnel|tel',
                'placeholder' => 'Entrer le téléphone'],
            ])
            ->add('email', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Email',
                'required' => false,
                'attr' => ['required'=>false, 
                'class'=>'form-control mb-2 unicite',
                'data-column' =>'Personnel|email',
                'data-fv-email-address'=>"true",
                'data-fv-email-address___message' => "Cet email n'est pas valide.",
                'placeholder' => 'Entrer l\'email de la personne'],
            ])
            ->add('adresse', TextareaType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Adresse',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer l\'adresse de la personne'],
            ])
            ->add('dateNais', BirthdayType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date de naissance',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2', 
                'placeholder' => 'Date de naissance'],
            ])
            ->add('sexe', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label'],
                'choices'  => [
                    'Masculin' => 'Masculin',
                    'Feminin' => 'Feminin',
                ],
                'label' => 'Sexe',
                'required' => true,
                'placeholder' => 'Sélectionnez le sexe...',
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2', 
                'data-control' => "select2",
                'placeholder' => 'Sexe'],
            ])
            ->add('civilite', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label'],
                'choices'  => [
                    'Monsieur' => 'Monsieur',
                    'Madame' => 'Madame',
                    'Mademoiselle' => 'Mademoiselle',
                    'Docteur' => 'Docteur',
                ],
                'label' => 'Civilité',
                'required' => true,
                'placeholder' => 'Sélectionnez la civilité...',
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2', 
                'data-control' => "select2",
                'placeholder' => 'Civilite'],
            ])
            ->add('fonctionPersonnels', CollectionType::class, [
                'required' => false,
                'entry_type' => FonctionPersonnelType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__fonctionPersonnels__'
            ])
            
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Personnel::class,
        ]);
    }
}
