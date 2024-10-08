<?php

namespace App\Form;

use App\Entity\ListCaisse;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ListCaisseType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        ->add('code', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Code',
            'required' => true,
            'attr' => [
                'required'=>true, 
                'class'=>'form-control mb-2 unicite', 
                'data-column' =>'ListCaisse|code',
                'placeholder' => 'Entrer le code du caisse'
            ],
        ])
        ->add('libelle', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Libelle',
            'required' => true,
            'attr' => ['required'=>true, 
            'class'=>'form-control mb-2 unicite',
            'data-column' =>'ListCaisse|libelle',
            'placeholder' => 'Entrer le libelle du caisse'],
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
            'data_class' => ListCaisse::class,
        ]);
    }
}
