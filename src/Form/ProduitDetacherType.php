<?php

namespace App\Form;

use App\Entity\ProduitCondMag;
use App\Entity\ProduitDetacher;
use App\Entity\ProduitConditionnement;
use Symfony\Component\Form\AbstractType;
use App\Repository\ProduitCondMagRepository;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use App\Repository\ProduitConditionnementRepository;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\NumberType;

class ProduitDetacherType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('quantite',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Quantité',
                'required' => true,
                'attr' => [
                    'required'=>true, 
                    'class'=>'form-control mb-2 decimal', 
                    'placeholder' => 'Entrer la quantité'
                ],
            ])
            ->add('cible', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Cible',
                'class' => ProduitConditionnement::class,
                'query_builder' => function (ProduitConditionnementRepository $er) {
                    return $er->createQueryBuilder('p')
                        ->where('p.deletedAt IS NULL')
                        ->orderBy('p.produit', 'ASC');
                },
                'placeholder'=> 'Sélectionnez le produit',
                'attr' => ['required' => true, 
                    'data-control' => "select2", 
                    'class' => 'form-control form-select',
                    'data-placeholder' => 'Sélectionnez le produit',
                ],
            ])
            ->add('quantiteCible',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Quantité cible',
                'required' => true,
                'attr' => [
                    'required'=>true, 
                    'readonly'=>true, 
                    'class'=>'form-control form-control-solid mb-2 decimal', 
                    'placeholder' => 'Entrer la quantité cible'
                ],
            ])
            ->add('produitCondMag', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Produit',
                'class' => ProduitCondMag::class,
                'query_builder' => function (ProduitCondMagRepository $er) {
                    return $er->createQueryBuilder('p')
                        ->where('p.deletedAt IS NULL')
                        ->orderBy('p.produitConditionnement', 'ASC');
                },
                'placeholder'=> 'Sélectionnez le produit',
                'attr' => [
                    'required' => true, 
                    'data-control' => "select2", 
                    'class' => 'produit form-control form-select',
                    'data-placeholder' => 'Sélectionnez le produit',
                ],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProduitDetacher::class,
        ]);
    }
}
