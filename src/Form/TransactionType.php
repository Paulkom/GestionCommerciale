<?php

namespace App\Form;

use App\Entity\Client;
use App\Entity\ModePaiement;
use App\Entity\Transaction;
use App\Entity\TypeOperation;
use App\EventListener\UpdateTransacFieldsListener;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class TransactionType extends AbstractType
{
    protected $em;
    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('refTransac', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Référence de la transaction',
                'required' => false,
                'attr' => [
                    'class' => 'form-control ',
                    'placeholder' => 'Référence'
                ],
            ])
            ->add('montantTransac', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control decimal',
                    'placeholder' => '0'
                ],
            ])
            ->add('modePaiement', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Mode de paiement',
                'class' => ModePaiement::class,
                'choice_label' => 'libelle',
                'placeholder' => 'Sélectionnez un mode...',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ],
            ])
            ->add('typeOperation', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Type d\'opération',
                'class' => TypeOperation::class,
                'choice_label' => 'libelle',
                'placeholder' => 'Sélectionnez un type d\'opération...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ],
            ])
            ->add('client', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Client',
                'class' => Client::class,
                'placeholder' => 'Sélectionnez un client...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ],
            ])
        ;

        //$builder->addEventSubscriber(new UpdateTransacFieldsListener($this->em));
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Transaction::class,
        ]);
    }
}
