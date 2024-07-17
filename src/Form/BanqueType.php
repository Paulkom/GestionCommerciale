<?php

namespace App\Form;

use App\Entity\Banque;
use App\Entity\Societe;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;


class BanqueType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('denominationBanque', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Dénomination',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2 unicite', 
                'data-column' =>'Banque|denominationBanque',
                'placeholder' => 'Entrer la dénomination'],
            ])
            ->add('sigle', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Sigle',
                'required' => true,
                'attr' => [
                'data-column' =>'Banque|sigle',
                'required'=>true, 
                'class'=>'form-control mb-2 unicite ', 
                'placeholder' => 'Entrer le sigle'],
            ])
            ->add('adresse', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Adresse',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer l\'adresse '],
            ])
            /*->add('societe',EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'required' => false,
                'label' => 'Société',
                'class' => Societe::class,
                'placeholder'=> 'Sélectionnez la société',
                'attr' => [
                    'required'=>false,
                    'class' => 'form-control form-select',
                    'data-control' => "select2",
                    'data-placeholder' => "Sélectionnez la societe"
                ]
            ])*/
            ->add('keys', HiddenType::class,[
                'mapped' => false,
                'attr' => ['class'=>'keys','data-id'=>'',
                'data-column' =>'Banque|denominationBanque|libelleFamille|sigle']
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
                            'data-column' =>'Banque|denominationBanque|libelleFamille|sigle'
                        ]
                    ]);
                }
            });
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Banque::class,
        ]);
    }
}
