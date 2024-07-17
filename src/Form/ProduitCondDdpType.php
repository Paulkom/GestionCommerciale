<?php

namespace App\Form;

use App\Entity\ProduitCondDdp;
use App\Entity\ProduitConditionnement;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use App\Repository\ProduitConditionnementRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;

class ProduitCondDdpType extends AbstractType
{
    private $em;
    public function __construct(EntityManagerInterface $em){
        $this->em = $em;
    }
    
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('qteDdp', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Quantité',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 quantite decimal', 
                'placeholder' => 'Quantité'],
            ])
            // ->add('montant', TextType::class, [
            //     'label_attr' => ['class' => 'form-label'],
            //     'label' => 'Montant',
            //     'required' => true,
            //     'attr' => ['required'=>true,
            //     'class'=>'form-control mb-2 total', 
            //     'placeholder' => 'Montant'],
            // ])
            ->add('produitCond', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'required' => true,
                'label' => 'Produit',
                'class' => ProduitConditionnement::class,
                'placeholder'=> 'Sélectionnez un produit',
                'query_builder' => function(ProduitConditionnementRepository $pcr){
                    $qb = $this->em->createQueryBuilder()
                        ->select('m')
                        ->from('App\\Entity\\ProduitConditionnement', 'm')
                        ->join('m.produit','p')
                        ->where('p.estService = 0')
                        ->andWhere('m.deletedAt IS NULL')
                    ;
                    return $qb;
                },
                'choice_attr'  => function(ProduitConditionnement $pc){
                    return ['optionValue' => 'pcddp-'.$pc->getId() ];
                },
                'attr' => [
                    'required'=>true,
                    'class' => 'form-control form-select',
                    'data-control' => "select2",
                    'data-placeholder' => "Sélectionnez un produit"
                ]
            ])
            // ->add('demandeDePrix')
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProduitCondDdp::class,
        ]);
    }
}
