<?php

namespace App\Form;

use App\Entity\Personnel;
use App\Entity\Sortie;
use App\EventListener\UpdateSortieFieldsListener;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\EntityRepository;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class SortieType extends AbstractType
{
    protected $em;
    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('montantTotal', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => false,
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control form-control-solid total',
                    'placeholder' => 'Total...',
                    'readonly' => true,
                ],
            ])
            ->add('motif', TextareaType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Motif',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control form-control-solid',
                    'placeholder' => 'Motif'
                ],
            ])
            ->add('auteur', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Personne concernée',
                'class' => Personnel::class,
                'placeholder' => 'Auteur de la sortie',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ],
            ])
            ->add('sortieMags', CollectionType::class, [
                'required' => true,
                'entry_type' => SortieMagType::class,
                'entry_options' => ['label' => true],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__sortieMags__'
            ]);

        $builder->addEventSubscriber(new UpdateSortieFieldsListener($this->em));
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Sortie::class,
        ]);
    }
}
