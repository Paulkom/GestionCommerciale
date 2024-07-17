<?php

namespace App\Form;

use App\Entity\Taxe;
use App\Entity\TypeTaxe;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\OptionsResolver\OptionsResolver;

class TaxeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('codeTaxe', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Code taxe',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control mb-2 unicite',
                    'data-column' =>'Taxe|codeTaxe',
                    'placeholder' => 'Ex : TVA'
                ],
            ])
            ->add('libelle', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Intitulé',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control mb-2 unicite',
                    'data-column' =>'Taxe|libelle',
                    'placeholder' => 'Ex : Taxe sur Valeur Ajoutée'
                ],
            ])
            ->add('taux', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Valeur',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control mb-2 float',
                    'placeholder' => 'Ex : 18'
                ],
            ])
            ->add('appellation', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Appellation',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control mb-2 unicite',
                    'data-column' =>'Taxe|appellation',
                    'placeholder' => 'Ex : TVA'
                ],
            ])
            ->add('sens', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Sens',
                'choices' => [
                    'Déductible'  => 0,
                    'Collectée'   => 1,
                ],
                'placeholder' => 'Sens...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-control form-select',
                ],
            ])
            ->add('typeTaux', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Type de taux',
                'choices' => [
                    '%'         => 0,
                    'Montant'   => 1,
                    'Quantité'  => 2,
                ],
                'placeholder' => 'Sélectionnez un type de taux...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-control form-select',
                ],
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
            'data_class' => Taxe::class,
        ]);
    }
}
