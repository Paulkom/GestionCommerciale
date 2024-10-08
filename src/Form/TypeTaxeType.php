<?php

namespace App\Form;

use App\Entity\TypeTaxe;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;

class TypeTaxeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('code', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Code',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer le code du type'],
            ])
            ->add('libelle', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Libelle',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer le libelle du type'],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => TypeTaxe::class,
        ]);
    }
}
