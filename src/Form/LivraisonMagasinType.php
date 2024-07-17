<?php

namespace App\Form;

use App\Entity\LivraisonMagasin;
use App\Entity\Magasin;
use App\Entity\ProduitCondMagLiv;
use App\Repository\MagasinRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class LivraisonMagasinType extends AbstractType
{

    private $em;
    private $session;
    function __construct(EntityManagerInterface $em, SessionInterface $session){
        $this->em = $em;
        $this->session = $session;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('magasin', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Magasin',
                'class' => Magasin::class,
                'placeholder' => 'Sélectionnez un magasin...',
                'query_builder' => function(MagasinRepository $mr){
                    $pv = $this->session->get('pointVente', []);
                    $qb = $this->em->createQueryBuilder()
                        ->select('m')
                        ->from('App\\Entity\\Magasin','m')
                        ->where('m.estSup IS NULL')
                        ->andWhere('m.pointVente = :val')
                        ->setParameter('val', ($pv != [])? $pv->getId() : 0 );
                    return null;
                },
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select livraison'
                ],
            ])
            ->add('produitCondMagLivs', CollectionType::class, [
                'required' => false,
                'entry_type' => ProduitCondMagLivType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__produitCondMagLivs__'
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => LivraisonMagasin::class,
        ]);
    }
}
