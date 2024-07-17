<?php

namespace App\Form;

use App\Entity\Magasin;
use App\Entity\ProduitCondMag;
use Doctrine\ORM\Mapping\Entity;
use App\Entity\ProduitCondComClit;
use Doctrine\DBAL\Types\IntegerType;
use App\Entity\ProduitConditionnement;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use SebastianBergmann\Environment\Console;
use App\Repository\ProduitCondMagRepository;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use App\Repository\ProduitConditionnementRepository;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Form\Extension\Core\Type\IntegerType as TypeIntegerType;

class ProdCondComClitType extends AbstractType
{

    private $produitCondMagRepository;
    private $em;
    private SessionInterface $session;

    public function __construct(EntityManagerInterface $entityManager,ProduitCondMagRepository $produitCondMagRepository, SessionInterface $session)
    {
        $this->em = $entityManager;
        $this->produitCondMagRepository = $produitCondMagRepository;
        $this->session = $session;
        
    }


    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('produit', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Produit',
                'class' => ProduitConditionnement::class,
                'choice_attr' => function(ProduitConditionnement $produitCond){
                    if((int)$produitCond->getQteStockCond() <= 0 && $produitCond->getProduit()->getEstService() != 1 ){
                        $classe='option-color';
                        $diseable=true;
                    }else{
                        $classe='';
                        $diseable=false;
                    }
                  $qtet= ($this->produitCondMagRepository->findOneBy(['magasin'=>$produitCond->getProduit()->getMagasinDefaut(),'produitConditionnement'=>$produitCond]))?  
                          $this->produitCondMagRepository->findOneBy(['magasin'=>$produitCond->getProduit()->getMagasinDefaut(),'produitConditionnement'=>$produitCond])->getQteStockMag():0;
                        //dd($produitCond->getProduit()->getEstTaxable(),'qqqqqqqqqqqqqq');
                    return [
                        'data-prixvent'  => $produitCond->getPrixDeVenteTTC(),
                        'data-prixmax'  => $produitCond->getPrixMax(),
                        'data-prixmin'  => $produitCond->getPrixMin(),
                        'data-prixht'  => $produitCond->getPrixDeVenteHT(),
                        'data-prixttc'  => $produitCond->getPrixDeVenteTTC(),
                        'data-qteStockCondLogique' => $produitCond->getQteStockCondLogique(),
                        'data-qteStockCond'  => $produitCond->getQteStockCond(),
                        'data-magdefault'  => ($produitCond->getProduit()->getMagasinDefaut())? $produitCond->getProduit()->getMagasinDefaut()->getId(): 0,
                        'data-magqte' => $qtet,
                        'data-esttasable' => ($produitCond->getProduit()->getEstTaxable())? 1:0,
                        'class' => $classe,
                        'disabled'=>$diseable,
                        'piece-par-carton'      => $produitCond->getProduit()->getPieceParCarton(),
                        'piece-par-metrecarre'  => $produitCond->getProduit()->getPieceParMetreCarre(),
                        'surface-par-piece'     => $produitCond->getProduit()->getSurfaceParPiece(),
                        'm2-par-carton'         => $produitCond->getProduit()->getMetreCarreParCarton(),
                        'est-mode-carreau'      => ($produitCond->getProduit()->getEstModeCarreau()) ? 1 : 0,
                        'est-service'      => ($produitCond->getProduit()->getEstService()) ? 1 : 0
                    ];
                },
                'query_builder' => function(ProduitConditionnementRepository $er){
                    $pv = $this->session->get('pointVente', []);
                    $qb = $this->em->createQueryBuilder()
                        ->select('p')
                        ->from('App\\Entity\\ProduitConditionnement', 'p')
                        ->leftJoin('p.produit','pr')
                        ->andWhere('pr.deletedAt IS NULL')
                        ->andWhere('pr.pointVente = :val')
                        ->setParameter('val', ($pv != [])? $pv->getId() : 0 )
                    ;
                    return $qb;
                },
                'placeholder'=> 'Sélectionnez le produit',
                'attr' => ['required' => true, 
                    'data-control' => "select2", 
                    'class' => 'produit form-control form-select form-select-sm',
                    ///'data-placeholder' => 'Sélectionnez le produit',
                ],
            ])
            ->add('prix',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Prix',
                'required' => true,
                'attr' => [
                'required'=>true , 
                'style'=>"text-align: left!important;",
                'class'=>'form-control prixttcligne form-control-sm decimal', 
                'placeholder' => 'Prix unitaire'],
            ])
            ->add('prixHt',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Prix ht',
                'required' => true,
                'attr' => [
                'required'=>true , 
                'readonly'=>true,
                'class'=>'form-control form-control-solid prixhtligne  form-control-sm decimal', 
                'placeholder' => 'Prix HT'],
            ])
            ->add('qtite',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Quantité',
                'required' => true,
                'attr' => ['required'=>true,
                'readonly'=>false,
                'style'=>"text-align: left!important;",
                'class'=>'form-control qteligne form-control-sm decimal', 
                'placeholder' => 'Quantité'],
            ])
            ->add('taxeSpecifique',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Taxe Spécifique',
                'required' => true,
                'attr' => ['required'=>true,
                'readonly'=>false,
                'class'=>'form-control form-control-sm decimal montantts', 
                'placeholder' => 'Taxe'],
            ])
            ->add('montant',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant',
                'required' => true,
                'attr' => ['required'=>true, 
                'readonly'=>true,
                'class'=>'form-control montant form-control-solid form-control-sm decimal',  
                'placeholder' => 'Montant HT'],
            ])
            ->add('montantTtcp',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant TTC',
                'required' => true,
                'attr' => ['required'=>true, 
                'readonly'=>true,
                'class'=>'form-control montantttcp form-control-solid form-control-sm decimal',  
                'placeholder' => 'Montant TTC'],
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
            ->add('montantHtAprRse',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'MT. HT Après Rse',
                'required' => true,
                'attr' => [
                'required'=>true, 
                'readonly'=>true,
                'class'=>'form-control montanthtaprrsep form-control-solid form-control-sm decimal',  
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
                'required'=>false,
                'class'=>'form-control form-select form-select-sm', 
                'data-control' => "select2",
                //'data-placeholder' => '...'
                ],
            ])
            ->add('magasin', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'required' => true,
                'placeholder' => 'magasin',
                'class'=>Magasin::class,
                'attr' => [
                'required'=>true,
                'class'=>'form-control form-select magasin form-select-sm', 
                'data-control' => "select2",
                //'data-placeholder' => '...'
                ],
            ])
            ->add('valeurRemise', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Valeur Rse.',
                'required' => false,
                'attr' => ['required'=>false, 
                'readonly'=>false,
                'class'=>'form-control form-control-solid form-control-sm decimal', 
                'placeholder' => 'valeur remise'],
            ])
            ->add('remise', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'MT. Rse.',
                'required' => false,
                'attr' => [
                'required'=>false, 
                'readonly'=>true,
                'class'=>'form-control form-control-sm form-control-solid decimal',  
                'placeholder' => 'Mt. remise'],
            ])
            ->add('carton', HiddenType::class, [
                'required' => false,
                'attr' => [
                'required'=>false],
            ])
            ->add('piece', HiddenType::class, [
                'required' => false,
                'attr' => [
                'required'=>false],
            ])
        ;
    }
    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProduitCondComClit::class,
        ]);
    }
}
