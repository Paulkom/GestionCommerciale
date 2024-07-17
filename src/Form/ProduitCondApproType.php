<?php

namespace App\Form;

use App\Entity\ProduitCondAppro;
use App\Form\ProduitCondMagApproType;
use App\Entity\ProduitConditionnement;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;

class ProduitCondApproType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        ->add('qteCondAppro', IntegerType::class, [
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
        ->add('produitConditionnement',EntityType::class, [
            'label_attr' => ['class' => 'form-label'],
            'required' => true,
            'label' => 'Produit',
            'class' => ProduitConditionnement::class,
            'placeholder'=> 'Sélectionnez un produit',
            'attr' => [
                'required'=>true,
                'class' => 'form-control form-select',
                'data-control' => "select2",
                'data-placeholder' => "Sélectionnez un produit"
            ]
        ])
        ->add('produitCondMagAppros', CollectionType::class, [
            'required' => false,
            'entry_type' => ProduitCondMagApproType::class,
            'entry_options' => ['label' => false],
            'label' => false,
            'allow_add' => true,
            'allow_delete' => true,
            'by_reference' => false,
        ])
            //->add('approvisionnement')
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProduitCondAppro::class,
        ]);
    }
}
