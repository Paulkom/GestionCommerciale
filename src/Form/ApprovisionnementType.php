<?php

namespace App\Form;

use App\Entity\Fournisseur;
use App\Entity\ApproMagasin;
use App\Form\ApproMagasinType;
use App\Entity\Approvisionnement;
use App\Repository\FournisseurRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class ApprovisionnementType extends AbstractType
{
    private $em;
    private $session;
    public function __construct(EntityManagerInterface $em, SessionInterface $session)
    {
        $this->em  = $em;
        $this->session  = $session;
    }
    
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('dateAppro', DateType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 physique', 
                'placeholder' => 'Date'],
            ])
            ->add('montantTotal', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant Total',
                'required' => false,
                'attr' => ['required'=>false,
                    'readonly' => true, 
                    'class'=>'form-control mb-2 total decimal divide', 
                    'placeholder' => 'Montant total'],
            ])
            ->add('reference', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Réference',
                'required' => false,
                'attr' => ['required'=>false,
                    'class'=>'form-control mb-2', 
                    'placeholder' => 'Réference'],
            ])
            ->add('approMagasins', CollectionType::class, [
                'required' => true,
                'entry_type' => ApproMagasinType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__approMagasins__'
            ])
            ->add('fournisseur', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Fournisseur',
                'required' => false,
                'query_builder' => function(FournisseurRepository $fr){
                    $pv = $this->session->get('pointVente', []);
                    $qb = $this->em->createQueryBuilder()
                    ->select('f')
                    ->from("App\\Entity\\Fournisseur",'f')
                    ->where('f.estSup IS NULL')
                    ->andWhere('f.pointVente = :val')
                    ->setParameter('val', ($pv != [])? $pv->getId() : 0 );
                    return $qb;
                },
                'attr' => [
                    'required' => false,
                    'class' => 'form-control form-select selectpicker fournisseur' ],
                'class' => Fournisseur::class,
                'choice_label' => function(Fournisseur $four){
                    return ($four->getDenomination()) ? $four->getDenomination().' [ '.$four->getSigle().' ] ' : $four->getNom().' '.$four->getPrenoms() ;
                },
                'placeholder' => 'Veuillez selectionner un fournisseur'
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Approvisionnement::class,
        ]);
    }
    
}
