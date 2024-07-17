<?php

namespace App\Form;

use Doctrine\DBAL\Types\FloatType;
use App\Entity\ProduitCondApproMag;
use App\Entity\ProduitConditionnement;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use App\Repository\ProduitConditionnementRepository;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class ProduitCondApproMagType extends AbstractType
{
    private $em;
    private SessionInterface $session;
    public function  __construct(EntityManagerInterface $em, SessionInterface $session){
        $this->em = $em;
        $this->session = $session;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('qteCondAppro', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Quantité',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 decimal quantite', 
                'placeholder' => '0'],
            ])
            ->add('prixAchat', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Prix de revient',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 decimal prix', 
                'readonly' => false,
                'placeholder' => '0'],
            ])
            ->add('carton', HiddenType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Carton',
            ])
            ->add('piece', HiddenType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Piece',
            ])
            ->add('montantCond', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 decimal subTotal', 
                'readonly' => true,
                'placeholder' => '0 Fcfa'],
            ])
            ->add('produitConditionnement',EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Produit',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control form-select produitCond'],
                'query_builder' => function(ProduitConditionnementRepository $pcr){
                        $pv = $this->session->get('pointVente', []);
                        $qb = $this->em->createQueryBuilder()
                            ->select('m')
                            ->from('App\\Entity\\ProduitConditionnement', 'm')
                            ->join('m.produit','p')
                            ->where('p.estService = 0')
                            ->andWhere('m.deletedAt IS NULL')
                            ->andWhere('m.pointVente = :val')
                            ->setParameter('val', ($pv != [])? $pv->getId() : 0 )
                        ;
                        return $qb;
                    },
                'choice_attr' => function(ProduitConditionnement $pc){
                    return [
                        'data-prix'             => $pc->getPrixDeVente(),
                        'optionValue'           => 'produitcond-'.$pc->getId(),
                        'piece-par-carton'      => $pc->getProduit()->getPieceParCarton(),
                        'piece-par-metrecarre'  => $pc->getProduit()->getPieceParMetreCarre(),
                        'surface-par-piece'     => $pc->getProduit()->getSurfaceParPiece(),
                        'm2-par-carton'         => $pc->getProduit()->getMetreCarreParCarton(),
                        'est-mode-carreau'      => ($pc->getProduit()->getEstModeCarreau()) ? 1 : 0
                    ];
                },
                'class' => ProduitConditionnement::class,
                'placeholder' => 'Veuillez selectionner un produit',
            ])
            // ->add('approMagasin')
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProduitCondApproMag::class,
        ]);
    }
}
