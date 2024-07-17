<?php

namespace App\Form;

use App\Entity\Magasin;
use App\Entity\ApproMagasin;
use App\Entity\Approvisionnement;
use App\Form\ProduitCondApproMagType;
use App\Repository\MagasinRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class ApproMagasinType extends AbstractType
{
    private $em;
    private $session;
    public function __construct(SessionInterface $session, EntityManagerInterface $em)
    {
        $this->em  = $em;
        $this->session  = $session;
    }
    
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            // ->add('approvisionnement', EntityType::class, [
            //     'label' => '',
            //     'attr' => ['class' => 'form-control'],
            //     'class' => Approvisionnement::class,
            //     'choice_label' => function(Approvisionnement $appro){
            //         return 
            //     }
            // ])
            ->add('magasin', EntityType::class, [
                'label' => '',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control form-select selectpicker magasin' ],
                'class' => Magasin::class,
                'query_builder' => function(MagasinRepository $ma){
                    $pv = $this->session->get('pointVente', []);
                    $qb = $this->em->createQueryBuilder()
                    ->select('m')
                    ->from("App\\Entity\\Magasin",'m')
                    ->where('m.estSup IS NULL')
                    ->andWhere('m.pointVente = :val')
                    ->setParameter('val', ($pv != [])? $pv->getId() : 0 );
                    return $qb;
                },
                'choice_label' => 'nomMag',
                'choice_attr'  => function(Magasin $magasin){
                    return ['optionValue' => 'magasin-'.$magasin->getId() ];
                },
                'placeholder' => 'Veuillez selectionner un magasin'
            ])
            ->add('produitCondApproMags', CollectionType::class, [
                'required' => true,
                'entry_type' => ProduitCondApproMagType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__produitCondApproMags__'
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ApproMagasin::class,
        ]);
    }
}
