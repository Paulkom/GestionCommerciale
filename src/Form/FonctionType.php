<?php

namespace App\Form;

use App\Entity\Fonction;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;

class FonctionType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        ->add('code', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Code',
            'required' => true,
            'attr' => ['required'=>true, 
            'maxlength' => 8,
            'class'=>'form-control mb-2 unicite ch_code', 
            'data-column' =>'Fonction|code',
            'placeholder' => 'Entrer le code de la fonction',
            ],
        ])
        ->add('intitule', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Intitulé',
            'required' => true,
            'attr' => [
            'required'=>true, 
            'class'=>'form-control mb-2 unicite', 
            'data-column' =>'Fonction|intitule',
            'placeholder' => 'Entrer l\'intitulé de la fonction'],
        ])
        ->add('keys', HiddenType::class,[
            'mapped' => false,
            'attr' => ['class'=>'keys',
            'data-id'=>'',
            'data-column' =>'code|intitule',
            'data-entity'=>'Fonction'
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
            'data_class' => Fonction::class,
        ]);
    }
}
