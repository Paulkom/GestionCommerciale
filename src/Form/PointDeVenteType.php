<?php

namespace App\Form;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use App\Entity\PointDeVente;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;

use Symfony\Component\OptionsResolver\OptionsResolver;

class PointDeVenteType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('code',TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Code',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2 unicite', 
                'data-column' =>'PointDeVente|code',
                'placeholder' => 'Entrer le code du point de vente'],
            ])
            ->add('libelle',TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Libelle',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2 unicite', 
                'data-column' =>'PointDeVente|libelle',
                'placeholder' => 'Entrer le libelle'],
            ])
            ->add('adresse',TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Adresse',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer l\'adresse du point de vente'],
            ])
            ->add('tel',TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Numéro de téléphone',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2 unicite telephone', 
                'data-column' =>'PointDeVente|telephone',
                'placeholder' => 'Entrer le numéro de téléphone'],
            ])
            ->add('estPrincipal',CheckboxType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Est principal ?',
                'required' => false,
                'attr' => [
                    'required' => false,
                    'class' => 'form-check-input'
                ]
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
            'data_class' => PointDeVente::class,
        ]);
    }
}
