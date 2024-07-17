<?php

namespace App\Form;

use App\Entity\Magasin;
use App\Entity\Transfert;
use App\EventListener\UpdateTransfertFieldsListener;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class TransfertType extends AbstractType
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
            ->add('magasinTrans1', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Magasin A',
                'class' => Magasin::class,
                'choice_label' => 'nomMag',
                // 'choice_attr'  => function(Magasin $mag){
                //     return ['optionValue' => 'mag-'.$mag->getId() ];
                // },
                'placeholder' => 'Sélectionnez un magasin...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ],
            ])
            // ->add('magasinTrans2', EntityType::class, array(
            //     'label_attr' => ['class' => 'form-label'],
            //     'label' => 'Magasin B',
            //     'required' => true,
            //     'placeholder' => 'Sélectionnez le magasin B...',
            //     'choice_attr'  => function(Magasin $mag){
            //         return ['optionValue' => 'mag-'.$mag->getId() ];
            //     },
            //     'class' => Magasin::class,
            //     'attr' => [
            //         'required' => true,
            //         'data-control' => "select2",
            //         'class' => 'form-select'
            //     ],
            // ))
            ->add('produitCondTrans', CollectionType::class, [
                'required' => true,
                'entry_type' => ProduitCondTransType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__produitCondTrans__'
            ]);

            $builder->addEventSubscriber(new UpdateTransfertFieldsListener($this->em));
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Transfert::class,
            'allow_extra_fields' => true,
            // 'magasinTrans1' => null,
        ]);
    }
}
