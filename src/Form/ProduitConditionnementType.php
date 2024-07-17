<?php

namespace App\Form;

use App\Entity\Conditionnement;
use App\Entity\ProduitConditionnement;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;

class ProduitConditionnementType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('qteCond', TextType::class, [
                'label_attr'        => ['class' => 'form-label'],
                'label'             => 'Qté',
                'required'          => true,
                'attr' => [
                    'required'      =>  true,
                    'class'         =>  'form-control  float',
                    'placeholder'   => '0'
                ],
            ])
            ->add('prixMin', TextType::class, [
                'label_attr'        => ['class' => 'form-label'],
                'label'             => 'Prix Min.',
                'required' => false,
                'attr' => [
                    'required'      =>  false,
                    'class'         =>  'form-control float',
                    'placeholder'   => '0'
                ],
            ])
            ->add('prixDeVente', TextType::class, [
                'label_attr'        => ['class' => 'form-label'],
                'label'             => 'Prix de vente',
                'required' => true,
                'attr' => [
                    'required'      =>  true,
                    'class'         =>  'form-control float',
                    'placeholder'   => '0'
                ],
            ])
            ->add('prixDeVenteHT', HiddenType::class, [
                'label_attr'        => ['class' => 'form-label'],
                'label'             => 'Prix de vente',
                'required' => false,
                'attr' => [
                    'required'      =>  false,
                    'class'         =>  'form-control float',
                    'placeholder'   => '0'
                ],
            ])
            ->add('prixDeVenteTTC', HiddenType::class, [
                'label_attr'        => ['class' => 'form-label'],
                'label'             => 'Prix de vente',
                'required' => false,
                'attr' => [
                    'required'      =>  false,
                    'class'         =>  'form-control float',
                    'placeholder'   => '0'
                ],
            ])
            ->add('prixMax', TextType::class, [
                'label_attr'        => ['class' => 'form-label'],
                'label'             => 'Prix Max.',
                'required' => false,
                'attr' => [
                    'required'      =>  false,
                    'class'         =>  'form-control  float',
                    'placeholder'   => '0'
                ],
            ])
            ->add('conditionnement', EntityType::class, [
                'label_attr'        => ['class' => 'form-label'],
                'label'             => 'Conditionnement',
                'required'          => true,
                'class'             => Conditionnement::class,
                'choice_label'      => 'libelleCond',
                'choice_attr'  => function(Conditionnement $cond){
                    return [
                        'optionValue' => 'condit-'.$cond->getId(),
                        'data-valeur' => $cond->getValeur(),
                    ];
                },
                'placeholder'       => 'Sélectionnez un conditionnement...',
                'attr' => [
                    'required'      => true,
                    'data-control'  => "select2",
                    'class'         => 'form-select'
                ],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProduitConditionnement::class,
        ]);
    }
}