<?php

namespace App\Form;

use App\Entity\Depense;
use App\Entity\TypeDepense;
use App\Repository\TypeDepenseRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class DepenseType extends AbstractType
{
    private $em;
    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->em = $entityManager;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('dateDep',BirthdayType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date Dépense',
                'required' => true,
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2 form-control-solid', 
                'placeholder' => 'Date de la Dépense'],
            ])
            ->add('motif',TextareaType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Motif',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control',
                    'placeholder' => 'Motif de la dépense'
                ],
            ])
            ->add('montant', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control decimal',
                    'placeholder' => '0'
                ],
            ])
            ->add('beneficiere',TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Bénéficiaire',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control',
                    'placeholder' => 'Bénéficiaire...'
                ],
            ])
            ->add('typeDepense', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Type de dépense',
                'class' => TypeDepense::class,
                'choice_label' => 'libelle',
                'placeholder' => 'Sélectionnez un type de dépense...',
                'required' => true,
                'query_builder' => function(TypeDepenseRepository $er){
                    $qb = $this->em->createQueryBuilder()
                        ->select('t')
                        ->from('App\\Entity\\TypeDepense', 't')
                        ->andWhere('t.deletedAt IS NULL')
                    ;
                    return $qb;
                },
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Depense::class,
        ]);
    }
}
