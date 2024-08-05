<?php

namespace App\Form;

use App\Entity\Fonction;
use App\Entity\FonctionPersonnel;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class FonctionPersonnelType extends AbstractType
{
    private $em;
    private $session;
    public function __construct(EntityManagerInterface $em, SessionInterface $session)
    {
        $this->em = $em;
        $this->session = $session;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('dateDebutFonc', DateType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date Début Fonction',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2', 
                'placeholder' => 'Date Debut Fonction'],
            ])
            ->add('dateFinFonc', DateType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date Fin Fonction',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2', 
                'placeholder' => 'Date Fin Fonction'],
            ])
            ->add('estActif', CheckboxType::class, [
                'label_attr' => ['class' => 'form-check-label', 'for' => 'est'],
                'required' => false,
                'attr' => ['class' => "form-check-input", 'id' => 'est'],
                'label' => 'Est Actif',
            ])
            ->add('salaireDeBase', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Salaire de base',
                'required' => false,
                'attr' => [
                    'class'=>'form-control  decimal',
                    'placeholder' => '52 500'
                ],
            ])
            
            ->add('fonction', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Fonction',
                'class' => Fonction::class,
                'choice_label' => 'intitule',
                'query_builder' => function(){
                    $pv = $this->session->get('pointVente', []);
                    $qb = $this->em->createQueryBuilder()
                        ->select('f')
                        ->from('App\\Entity\\Fonction','f')
                        ->where('f.estSup IS NULL')
                        ->andWhere('f.pointVente = :val')
                        ->setParameter('val', ($pv != [])? $pv->getId() : 0 )
                        ;
                        return $qb;
                },
                'choice_attr'  => function(Fonction $fonc){
                    return ['optionValue' => 'fonc-'.$fonc->getId() ];
                },
                'placeholder'=> 'Sélectionnez une fonction...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select',
                    // 'data-placeholder' => 'Sélectionnez une fonction...'
                ],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => FonctionPersonnel::class,
        ]);
    }
}
