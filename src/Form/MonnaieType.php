<?php

namespace App\Form;

use App\Entity\Monnaie;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;


class MonnaieType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('libelle',TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'libelle',
                'required' => true,
                'attr' => ['required'=>true, 
                'data-column' =>'Monnaie|libelle',
                'class'=>'form-control mb-2 unicite', 
                'placeholder' => 'Entrer le libelle'],
            ])
            ->add('valeur',NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Valeur',
                'required' => true,
                'attr' => [
                    'required'=>true, 
                'data-column' =>'Monnaie|valeur',
                'class'=>'form-control mb-2 unicite telephone', 
                'placeholder' => 'Entrer la valeur'],
            ])
            ->add('keys', HiddenType::class,[
                'mapped' => false,
                'attr' => ['class'=>'keys','data-id'=>'']
            ]);
    
            $builder->addEventListener(FormEvents::PRE_SET_DATA, function (FormEvent $event){
                $data = $event->getData();
                $form = $event->getForm();
                if(!(null === $data))
                {
                    $form->remove('keys')
                    ->add('keys', HiddenType::class, [
                        'mapped'=>false,
                        'attr' => [
                            'class'=>'keys',
                            'data-id'=>$data->getId(),
                        ]
                    ]);
                }
            });
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Monnaie::class,
        ]);
    }
}
