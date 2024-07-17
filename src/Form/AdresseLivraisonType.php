<?php

namespace App\Form;

use App\Entity\AdresseLivraison;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class AdresseLivraisonType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        ->add('libelleAdresse', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Maison / N° carré',
            'required' => true,
            'attr' => ['required'=>true, 
            'class'=>'form-control mb-2', 
            'placeholder' => 'Entrer le nom de maison '],
        ])
        ->add('quartier', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Quartier',
            'required' => true,
            'attr' => ['required'=>true, 
            'class'=>'form-control mb-2', 
            'placeholder' => 'Entrer le nom du quartier'],
        ])
        ->add('ville', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Ville',
            'required' => true,
            'attr' => ['required'=>true, 
            'class'=>'form-control mb-2', 
            'placeholder' => 'Entrer le nom  de la ville'],
        ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => AdresseLivraison::class,
        ]);
    }
}
