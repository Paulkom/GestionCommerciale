<?php

namespace App\Form;

use App\Entity\Fournisseur;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;


class FournisseurType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('nom', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Nom',
                'required' => false,
                'attr' => [
                'required'=>false, 
                'class'=>'form-control mb-2 physique', 
                'placeholder' => 'Entrer le nom'
                ],
            ])
            ->add('prenoms', TextType::class, [
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
            ->add('email', EmailType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Email',
                'required' => false,
                'attr' => [
                    'data-fv-email-address'=>"true",
                    'data-fv-email-address___message' => "Cet email n'est pas valide.",
                    'required'=>false,
                    'class'=>'form-control mb-2 unicite', 
                    'data-column' =>'Fournisseur|email',
                    'placeholder' => 'Entrer l\'email'
                ],
            ])
            ->add('tel1', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Téléphone 1',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 unicite telephone',
                'data-column' =>'Fournisseur|tel1',
                'placeholder' => 'Entrer le numero de téléphone'],
            ])
            ->add('tel2', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Téléphone 2',
                'required' => false,
                'attr' => ['required'=>false,
                'data-column' =>'Fournisseur|tel2',
                'class'=>'form-control mb-2 unicite telephone', 
                'placeholder' => 'Entrer le numero de téléphone'],
            ])
            ->add('raisonSociale', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Raison sociale',
                'required' => false,
                'attr' => ['required'=>false,
                'data-column' =>'Fournisseur|raisonSociale',
                'class'=>'form-control mb-2 unicite moral', 
                'placeholder' => 'Entrer la raison sociale'],
            ])
            ->add('ifu', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'N° IFU',
                'required' => false,
                'attr' => [
                    'required'=>false,	
                    'class'=>'form-control ifu unicite mb-2', 
                    'data-column' =>'Fournisseur|ifu',
                    'data-fv-string-length'=>"true",
                    'data-fv-string-length___min'=>"13",
                    'data-fv-string-length___max'=>"13",
                    'data-fv-string-length___message'=>"L'IFU doit comporter 13 chiffres",
                    'placeholder' => 'Entrer le numero IFU'
                ],
            ])
            ->add('rccm', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'N° RCCM',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 unicite moral',
                'data-column' =>'Fournisseur|rccm', 
                'placeholder' => 'Entrer le numero du Registre de commerce'],
            ])
            ->add('sigle', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Sigle',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 unicite moral', 
                'data-column' =>'Fournisseur|sigle',
                'placeholder' => 'Entrer le sigle'],
            ])
            ->add('denomination', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Dénomination',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 unicite moral', 
                'data-column' =>'Fournisseur|denomination',
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
            ->add('keys', HiddenType::class,[
                'mapped' => false,
                    'attr' => ['class'=>'keys',
                    'data-id'=>''
                ]
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
                        ]
                    ]);
                }
            });
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Fournisseur::class,
        ]);
    }
}
