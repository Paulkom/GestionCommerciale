<?php

namespace App\Form;

use App\Entity\ModelSignataire;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use App\Form\ModelSignatairePersonnelFonctionType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;

class ModelSignataireType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('estDefault', CheckboxType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Est Défaut ?',
                'required' => false,
                'attr' => [
                    'class' => 'form-check-input',
                ],
            ])
            // ->add('code', TextType::class, [
            //     'label_attr' => ['class' => 'form-label'],
            //     'label' => 'Code',
            //     'required' => true,
            //     'attr' => [
            //         'required'=>true, 
            //         'class'=>'form-control mb-2 unicite', 
            //         'data-column' =>'ModelSignataire|code',
            //         'placeholder' => 'Entrer le code du model de signataire'
            //     ],
            // ])
            ->add('libelle', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Désignation',
                'required' => true,
                'attr' => [
                    'required'=>true, 
                    'class'=>'form-control mb-2 unicite', 
                    'data-column' =>'ModelSignataire|libelle',
                    'placeholder' => 'Entrer le nom du modèle'
                ],
            ])
            ->add('modelSignatairePersonnelFonctions', CollectionType::class, [
                'required' => true,
                'entry_type' => ModelSignatairePersonnelFonctionType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__modelSignatairePersonnelFonctions__'
            ])
        ;

        $builder->addEventListener(FormEvents::PRE_SET_DATA, function (FormEvent $event){
            $data = $event->getData();
            $form = $event->getForm();
           
            foreach ($data->getModelSignatairePersonnelFonctions() as $key => $element) {
                /**
                 * @var ModelSignatairepersonnelFonction $element
                 */
                if($element->getEstSup() == 1){
                    $data->getModelSignatairePersonnelFonctions()->remove($key);
                }
            }
        });
        
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ModelSignataire::class,
        ]);
    }
}
