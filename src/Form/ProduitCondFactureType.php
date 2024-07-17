<?php

namespace App\Form;

use App\Entity\ProduitCondFacture;
use App\Entity\ProduitConditionnement;
use App\Repository\ProduitConditionnementRepository;
use Doctrine\DBAL\Types\IntegerType;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType as TypeIntegerType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ProduitCondFactureType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('produit', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Produit',
                'class' => ProduitConditionnement::class,
                'query_builder' => function (ProduitConditionnementRepository $er) {
                    return $er->createQueryBuilder('p')
                        ->where('p.deletedAt IS NULL')
                        ->orderBy('p.produit', 'ASC');
                },
                'choice_attr' => function(ProduitConditionnement $produitCond){
                    // $disabled="";
                    // if((double)$produitCond->getQteStockCond() == 0) $disabled="disabled";  
                    // return [
                    //     'data-prixvent'  => $produitCond->getPrixDeVenteTTC(),
                    //     'data-prixmax'  => $produitCond->getPrixMax(),
                    //     'data-prixmin'  => $produitCond->getPrixMin(),
                    //     'data-qteStockCond'  => $produitCond->getQteStockCond(),
                    //     'optionValue' => 'procond-'.$produitCond->getId(),
                    //     // 'disabled'=>$disabled
                    // ];
                    return [
                        'data-prixvent'  => $produitCond->getPrixDeVenteTTC(),
                        'data-prixmax'  => $produitCond->getPrixMax(),
                        'data-prixmin'  => $produitCond->getPrixMin(),
                        'data-prixht'  => $produitCond->getPrixDeVenteHT(),
                        'data-prixttc'  => $produitCond->getPrixDeVenteTTC(),
                        'data-qteStockCondLogique' => $produitCond->getQteStockCondLogique(),
                        'data-qteStockCond'  => $produitCond->getQteStockCond(),
                        'data-magdefault'  => ($produitCond->getProduit()->getMagasinDefaut())? $produitCond->getProduit()->getMagasinDefaut()->getId(): 0,
                        'data-esttasable' => ($produitCond->getProduit()->getEstTaxable())? 1:0,
                        'optionValue' => 'procond-'.$produitCond->getId(),
                    ];
                    
                },
                'placeholder'=> 'Sélectionnez le produit',
                'attr' => ['required' => true, 
                    'data-control' => "select2", 
                    'class' => 'produit form-control form-select form-select-sm',
                    'data-placeholder' => 'Sélectionnez le produit',
                ],
            ])
            ->add('prixHt',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Prix ht',
                'required' => true,
                'attr' => [
                'required'=>true , 
                'readonly'=>true,
                'class'=>'form-control form-control-solid  form-control-sm decimal', 
                'placeholder' => 'Prix HT'],
            ])
            ->add('montantTvap',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Mt TVA',
                'required' => true,
                'attr' => ['required'=>true, 
                'readonly'=>true,
                'class'=>'form-control montanttvap form-control-solid form-control-sm decimal',  
                'placeholder' => 'Montant TVA'],
            ])
            ->add('prix',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Prix',
                'required' => true,
                'attr' => ['required'=>true , 
                'class'=>'form-control form-control-sm decimal', 
                'placeholder' => 'Prix unitaire'],
            ])
            ->add('qtite',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Quantité',
                'required' => true,
                'attr' => ['required'=>true, 
                'readonly'=>false,
                'class'=>'form-control form-control-sm decimal', 
                'placeholder' => 'Quantité'],
            ])
            ->add('montant',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant',
                'required' => true,
                'attr' => ['required'=>true, 
                    'readonly'=>true,
                    'class'=>'form-control montant form-control-solid form-control-sm decimal',  
                    'placeholder' => 'Montant HT'
                ],
            ])
            ->add('montantHtAprRse',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'MT. HT Après Rse',
                'required' => true,
                'attr' => ['required'=>true, 
                'readonly'=>true,
                'class'=>'form-control montanthtaprrsep remise form-control-solid form-control-sm decimal',  
                'placeholder' => 'MT. HT Après Rse'],
            ])
            ->add('typeRemise', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label'],
                'choices'  => [
                     '%'=>'%' ,
                    'MT'=>'MT'  ,
                ],
                'label' => 'Type Rse.',
                'required' => false,
                'placeholder' => '...',
                'attr' => [
                //'required'=>true,
                'class'=>'form-control form-select form-select-sm', 
                'data-control' => "select2",
                'data-placeholder' => '...'],
            ])
            ->add('montantTtcp', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'readonly' => true,
                    'class' => 'form-control montantttcp form-control-solid form-control-sm decimal',
                    'placeholder' => 'Montant TTC'
                ],
            ])
            ->add('valeurRemise', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Valeur Rse.',
                'required' => false,
                'attr' => ['required'=>false, 
                //'readonly'=>true,
                'class'=>'form-control form-control-sm', 
                'placeholder' => 'valeur remise'],
            ])
            ->add('remise', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'MT. Rse.',
                'required' => false,
                'attr' => ['required'=>false, 
                'readonly'=>true,
                'class'=>'form-control form-control-sm form-control-solid decimal',  
                'placeholder' => 'Mt. remise'],
            ])
        ;
    }
    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProduitCondFacture::class,
        ]);
    }
}
