<?php

namespace App\Form;

use App\Entity\Magasin;
use App\Entity\Detachement;
use App\Repository\MagasinRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class DetachementType extends AbstractType
{
   /* private $em;
    private $session;
    public function __construct(EntityManagerInterface $em, SessionInterface $session)
    {
        $this->em  = $em;
        $this->session  = $session;
    }*/
    
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('dateDet', DateType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 physique', 
                'placeholder' => 'Date'],
            ])
            ->add('magasin', EntityType::class, [
                'label' => 'Magasin',
                'label_attr' => ['class' => 'form-label'],
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control form-select magasin' ],
                'class' => Magasin::class,
                /*'query_builder' => function(MagasinRepository $ma){
                    $pv = $this->session->get('pointVente', []);
                    $qb = $this->em->createQueryBuilder()
                    ->select('m')
                    ->from("App\\Entity\\Magasin",'m')
                    ->where('m.estSup IS NULL')
                    ->andWhere('m.pointVente = :val')
                    ->setParameter('val', ($pv != [])? $pv->getId() : 0 );
                    return $qb;
                },*/
                'choice_label' => 'nomMag',
                'placeholder' => 'Veuillez selectionner un magasin'
            ])
            ->add('produitDetachers', CollectionType::class, [
                'required' => true,
                'entry_type' => ProduitDetacherType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__produitDetachers__'
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Detachement::class,
        ]);
    }
}
