<?php

namespace App\Form;

use App\Entity\PointDeVente;
use App\Entity\UtilisateurPointDeVente;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;

class UtilisateurPointDeVenteType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('estActif', CheckboxType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Est Actif ?',
                'required' => false,
                'attr' => [
                    'class' => 'form-check-input',
                ],
            ])
            ->add('pointDeVente', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Point de vente',
                'class' => PointDeVente::class,
                'choice_label' => 'libelle',
                'choice_attr'  => function(PointDeVente $p){
                    return ['optionValue' => 'pointvent-'.$p->getId() ];
                },
                'placeholder'=> 'Sélectionnez un point de vente...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select',
                    //'data-placeholder' => 'Sélectionnez une famille...'
                ],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => UtilisateurPointDeVente::class,
        ]);
    }
}
