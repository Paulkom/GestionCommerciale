<?php

namespace App\Form;

use App\Entity\AdresseLivraison;
use App\Entity\Client;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\RadioType;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;

class ClientType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('nom', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Nom',
                'required' => false,
                'attr' => ['required'=>false, 
                'class'=>'form-control mb-2 physique', 
                'placeholder' => 'Entrer le nom'],
            ])
            ->add('prenom', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Prénoms',
                'required' => false,
                'attr' => ['required'=>false, 
                'class'=>'form-control mb-2 physique', 
                'placeholder' => 'Entrer le(s) prenom(s)'],
            ])
            ->add('adresse', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Adresse',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer l\'adresse'],
            ])
            ->add('email', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Email',
                'required' => false,
                'attr' => [
                'required'=>false,
                'data-fv-email-address'=>"true",
                'data-fv-email-address___message' => "Cet email n'est pas valide.",
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer l\'email'],
            ])
            ->add('telephone1', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Téléphone 1',
                'required' => true,
                'attr' => [
                'required'=>true,
                'class'=>'form-control mb-2 unicite  telephone', 
                'data-column' =>'Client|telephone1',
                'placeholder' => 'Entrer le numero de téléphone'],
            ])
            ->add('telephone2', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Téléphone 2',
                'required' => false,
                'attr' => ['required'=>false,
                'data-column' =>'Client|telephone2',
                'class'=>'form-control unicite mb-2 telephone', 
                'placeholder' => 'Entrer le numero de téléphone'],
            ])
            ->add('raisonSociale', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Raison sociale',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 unicite moral', 
                'data-column' =>'Client|raisonSociale',
                'placeholder' => 'Entrer la raison sociale'],
            ])
            ->add('ifu', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'N° IFU',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 ifu unicite moral', 
                'data-column' =>'Client|ifu',
                // 'data-fv-numeric'=>"true",
                // 'data-fv-numeric___message'=>"La valeur n'est pas un nombre",
                'data-fv-string-length'=>"true",
                'data-fv-string-length___min'=>"13",
                'data-fv-string-length___max'=>"13",
                'data-fv-string-length___message'=>"L'IFU doit comporter 13 chiffres",
                'placeholder' => 'Entrer le numero IFU'],
            ])
            ->add('rccm', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'N° RCCM',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 moral unicite', 
                'data-column' =>'Client|rccm',
                'placeholder' => 'Entrer le numero du Registre de commerce'],
            ])
            ->add('sigle', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Sigle',
                'required' => false,
                'attr' => ['required'=>false,
                'data-column' =>'Client|sigle',
                'class'=>'form-control mb-2 moral unicite', 
                'placeholder' => 'Entrer le sigle'],
            ])
            ->add('denomination', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Dénomination',
                'required' => false,
                'attr' => ['required'=>false,
                'data-column' =>'Client|denomination',
                'class'=>'form-control mb-2 moral unicite', 
                'placeholder' => 'Entrer la denomination'],
            ])
            ->add('statut', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label ok'],
                'choices'  => [
                    'Physique' => 'Physique',
                    'Moral' => 'Moral',
                ],
                'choice_attr' => [
                    'Physique' => ['checked' => true],
                ],
                'expanded' => true,
                'multiple' => false,
                'attr' => ['required'=>true],
            ])
            ->add('dateNais', BirthdayType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date de naissance',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 physique', 
                'placeholder' => 'Date de naissance'],
            ])
            ->add('adresseLivraisons',CollectionType::class, [
                'required' => true,
                'entry_type' => AdresseLivraisonType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__adresseLivraisons__'
            ])
            ->add('keys', HiddenType::class,[
                'mapped' => false,
                'attr' => ['class'=>'keys','data-id'=>'','data-column' =>'Client|raisonSociale|ifu|rccm|telephone|denomination',]
            ]);
             
            $builder->addEventListener(FormEvents::PRE_SET_DATA, function (FormEvent $event){
                $data = $event->getData();
                $form = $event->getForm();
                if(!(null === $data))
                {
                    $form->remove('keys')
                    ->add('keys', HiddenType::class, [
                        'mapped'=>false,
                        'attr' => [
                            'class'=>'keys',
                            'data-id'=>$data->getId(),
                            'data-column' =>'Client|raisonSociale|ifu|rccm|telephone|denomination'
                        ]
                    ]);
                }
            });
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Client::class,
            'allow_extra_fields' => true
        ]);
    }
}
