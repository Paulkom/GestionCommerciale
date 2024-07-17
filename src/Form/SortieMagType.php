<?php

namespace App\Form;

use App\Entity\Magasin;
use App\Entity\SortieMag;
use App\EventListener\UpdateSortieMagFieldsListener;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\EntityRepository;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\OptionsResolver\OptionsResolver;

class SortieMagType extends AbstractType
{
    protected $em;
    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            /*->add('magasin', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Magasin',
                'class' => Magasin::class,
                'placeholder' => 'Sélectionnez un magasin...',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ]
            ])*/
            ->add('produitCondSortieMags', CollectionType::class, [
                'required' => true,
                'entry_type' => ProduitCondSortieMagType::class,
                'entry_options' => ['label' => true],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__produitCondSortieMags__'
            ]);

        $builder->addEventSubscriber(new UpdateSortieMagFieldsListener($this->em));
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => SortieMag::class,
        ]);
    }
}
