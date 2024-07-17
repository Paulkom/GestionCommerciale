<?php

namespace App\Form;

use App\Entity\Monnaie;
use App\Entity\MonnaieCaisse;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class MonnaieCaisseType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('monnaie', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Monnaie',
                'class' => Monnaie::class,
                'placeholder'=> 'Sélectionnez la monnaie',
                'choice_attr' => function(Monnaie $monnaie){
                    return [
                        'data-valeur' => $monnaie->getValeur(),
                    ];
                },
                'attr' =>[
                    'required' => false, 
                    'data-control' => "select2",
                    'class' => 'form-control form-select',
                    'data-placeholder' => 'Sélectionnez la monnaie',
                    'readonly '=>'readonly'
                    //'data-dropdown-parent'=> '#kt_modal_add_caisse'
                ],
            ])
            ->add('nbr',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Nombres',
                'required' => false,
                'attr' => [
                    //'required'=>true, 
                'class'=>'form-control decimal', 
                'placeholder' => 'Entrer le nombre'],
            ])
            ->add('montant',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant',
                'required' => false,
                'attr' => [
                    //'required'=>true, 
                'readonly'=>true,
                'class'=>'form-control decimal montant form-control-solid', 
                'placeholder' => 'montant'],
            ])
           /* ->add('etat', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label'],
                'choices'  => [
                    0 => 'Ouverture',
                    1 => 'Fermerture',
                ],
                'label' => 'Etat',
                'required' => true,
                'placeholder' => "Sélectionnez l'etat...",
                'attr' => ['required'=>true,
                'class'=>'form-control mb-2', 
                'data-control' => "select2",],
            ])*/
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => MonnaieCaisse::class,
        ]);
    }
}
