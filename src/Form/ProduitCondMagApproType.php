<?php

namespace App\Form;

use App\Entity\Magasin;
use App\Entity\ProduitCondMagAppro;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;

class ProduitCondMagApproType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        ->add('qteCondMag', IntegerType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Quantité',
            'required' => true,
            'attr' => ['required'=>true, 
            'class'=>'form-control mb-2 qte num', 
            'placeholder' => '0'],
        ])
        ->add('montantCond', NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Montant',
            'required' => true,
            'attr' => ['required'=>true, 
            'class'=>'form-control mb-2 mtn num', 
            'placeholder' => '0'],
        ])
        ->add('magasin',EntityType::class, [
            'label_attr' => ['class' => 'form-label'],
            'required' => true,
            'label' => 'Produit',
            'class' => Magasin::class,
            'placeholder'=> 'Sélectionnez un magasin',
            'attr' => [
                'required'=>true,
                'class' => 'form-control form-select',
                'data-control' => "select2",
                'data-placeholder' => "Sélectionnez un magasin"
            ]
        ])
            // ->add('magasin')
            // ->add('produitCondAppro')
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProduitCondMagAppro::class,
        ]);
    }
}
