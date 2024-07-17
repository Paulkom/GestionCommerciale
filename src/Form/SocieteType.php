<?php

namespace App\Form;

use App\Entity\Media;
use App\Entity\Societe;
use App\Form\MediaType;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;


class SocieteType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('ifu', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'N° IFU',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 ifu unicite', 
                'data-column' =>'Societe|ifu',
                // 'data-fv-numeric'=>"true",
                // 'data-fv-numeric___message'=>"La valeur n'est pas un nombre",
                'data-fv-string-length'=>"true",
                'data-fv-string-length___min'=>"13",
                'data-fv-string-length___max'=>"13",
                'data-fv-string-length___message'=>"L'IFU doit comporter 13 chiffres",
                'placeholder' => 'Entrer le numero IFU (13 chiffres)'],
            ])
            ->add('estRegimeTPS', CheckboxType::class, [
                // 'label_attr' => ['class' => 'form-label'],
                'label_attr' => ['class' => 'fs-6 fw-bold form-label mt-3'],
                'label' => 'Est Régime TPS ?',
                'label_html' => true,
                'required' => false,
                'attr' => [
                    'class' => 'form-check-input',
                ],
            ])
            ->add('estModeMecef', CheckboxType::class, [
                'label_attr' => ['class' => 'fs-6 fw-bold form-label mt-3'],
                'label' => 'Est Mode MECEF ?',
                'label_html' => true,
                'required' => false,
                'attr' => [
                    'class' => 'form-check-input',
                ],
            ])
            ->add('rccm', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'N° RCCM',
                'required' => true,
                'attr' => ['required'=>true,
                'data-column' =>'Societe|rccm',
                'class'=>'form-control mb-2 unicite', 
                'placeholder' => 'Entrer le numero du Registre de commerce'],
            ])
            ->add('sigle', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Sigle',
                'required' => true,
                'attr' => ['required'=>true,
                'data-column' =>'Societe|sigle', 
                'class'=>'form-control mb-2 unicite', 
                'placeholder' => 'Entrer le sigle'],
            ])
            ->add('denomination', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Dénomination',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 unicite',
                'data-column' =>'Societe|denomination',  
                'placeholder' => 'Entrer la denomination'],
            ])
            ->add('raisonSociale', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Raison sociale',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 unicite', 
                'data-column' =>'Societe|raisonSociale', 
                'placeholder' => 'Entrer la raison sociale'],
            ])
            ->add('adresse', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Adresse',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer l\'adresse'],
            ])
            ->add('telephone', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Téléphone',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 telephone unicite',
                'data-column' =>'Societe|telephone', 
                'placeholder' => 'Entrer le numéro de téléphone'],
            ])
            ->add('lieuImpression', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Lieu d\'impression des factures',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2', 
                'placeholder' => 'Lieu d\'impression'],
            ])
            ->add('apiLink', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Lien API',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2', 
                'placeholder' => 'Lien API'],
            ])
            ->add('apiNim', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'API Nim',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2', 
                'placeholder' => 'API Nim'],
            ])
            ->add('apiToken', TextareaType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'API Token',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2', 
                'placeholder' => 'API Token'],
            ])
            ->add('messageCommercial', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Message Commercial',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2', 
                'placeholder' => 'Message'],
            ])
            ->add('comptesBQ', CollectionType::class, [
                'required' => false,
                'entry_type' => CompteBanqueType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__comptesBQ__'
            ])
            ->add('logo',MediaType::class, ['required' => false])
            ->add('entete',MediaType::class, ['required' => true])
            ->add('piedDePage',MediaType::class, ['required' => false])
            ->add('keys', HiddenType::class,[
                'mapped' => false,
                'attr' => ['class'=>'keys','data-id'=>'','data-column' =>'Societe|raisonSociale|ifu|rccm|telephone|denomination',]
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
                            'data-column' =>'Societe|raisonSociale|ifu|rccm|telephone|denomination'
                        ]
                    ]);
                }
            });
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Societe::class,
        ]);
    }
}
