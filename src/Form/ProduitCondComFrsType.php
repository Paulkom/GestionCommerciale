<?php

namespace App\Form;

use App\Entity\ProduitCondComFrs;
use App\Entity\ProduitConditionnement;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use App\Repository\ProduitConditionnementRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;

class ProduitCondComFrsType extends AbstractType
{
    private $em;
    public function __construct(EntityManagerInterface $em){
        $this->em = $em;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder

            ->add('qteComfrs', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Quantité',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 decimal', 
                'placeholder' => 'Quantité'],
            ])
            ->add('prixUnitaire', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Prix unitaire',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 decimal', 
                'placeholder' => 'Prix unitaire'],
            ])
            ->add('montantCond', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 decimal', 
                'readonly'=> true, 
                'placeholder' => 'Montant'],
            ])
            ->add('produitCond', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'required' => true,
                'label' => 'Produit',
                'class' => ProduitConditionnement::class,
                'query_builder' => function(ProduitConditionnementRepository $pcr){
                    $qb = $this->em->createQueryBuilder()
                        ->select('pc')
                        ->from('App\\Entity\\ProduitConditionnement', 'pc')
                        ->join('pc.produit', 'p')
                        ->where('pc.deletedAt IS NULL')
                        ->andWhere('p.estService = 0')
                        
                    ;
                    return $qb;
                },
                'choice_attr'  => function(ProduitConditionnement $pc){
                    return ['optionValue' => 'proconfrs-'.$pc->getId() ];
                },
                'placeholder'=> 'Sélectionnez un produit',
                'attr' => [
                    'required'=>true,
                    'class' => 'form-control form-select',
                    'data-control' => "select2",
                    'data-placeholder' => "Sélectionnez un produit"
                ]
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProduitCondComFrs::class,
        ]);
    }
}
