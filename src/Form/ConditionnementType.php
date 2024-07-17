<?php

namespace App\Form;

use App\Entity\Conditionnement;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;

class ConditionnementType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('codeCond', TextType::class, [
                'label_attr' => ['class' => 'fs-6 fw-bold form-label mt-3'],
                'label' => 'Code',
                'label_html' => true,
                'attr' => ['required'=>true,
                    'maxlength' => 8,
                    'data-column' =>'Conditionnement|codeCond',
                    'class'=>'form-control unicite ch_code',
                    'placeholder' => 'Code...'],
            ])
            ->add('libelleCond', TextType::class, [
                'label_attr' => ['class' => 'fs-6 fw-bold form-label mt-3'],
                'label' => 'Libellé',
                'label_html' => true,
                'attr' => ['required'=>true,
                    'data-column' =>'Conditionnement|libelleCond|valeur',
                    'class'=>'form-control unicite',
                    'placeholder' => 'Libellé...'],
            ])
            ->add('valeur', NumberType::class, [
                'label_attr' => ['class' => 'fs-6 fw-bold form-label mt-3'],
                'label' => 'Valeur',
                'label_html' => true,
                'required'=>false,
                'attr' => ['required'=>false,
                    'class'=>'form-control decimal',
                    'placeholder' => 'Valeur...'],
            ])
            ->add('keys', HiddenType::class,[
                'mapped' => false,
                'attr' => ['class'=>'keys','data-id'=>'']
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
            'data_class' => Conditionnement::class,
            'attr' => [
                'id'                => 'condi-form',
                'class'             => 'form fv-plugins-bootstrap5 fv-plugins-framework',
                'data-entity'       => Conditionnement::class,
            ]
        ]);
    }
}
