<?php

namespace App\Form;

use App\Entity\Client;
use App\Entity\Compte;
use App\Repository\ClientRepository;
use Doctrine\ORM\EntityManagerInterface;
use phpDocumentor\Reflection\Types\Null_;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;


class CompteType extends AbstractType
{

    private $em;
    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->em = $entityManager;
    }
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('intitule',TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Intitule du compte',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'class' => 'form-control',
                    'placeholder' => 'Intitule du compte',
                    'data-column' =>'Compte|intitule',
                ],
            ])
            ->add('soldeInitial', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Dépôt initial',
                'required' => true,
                'attr' => [
                    //'readonly'=>true,
                    'required' => true,
                    'class' => 'form-control decimal',
                    'placeholder' => 'solde initial'
                ],
            ])
            // ->add('solde', TextType::class, [
            //     'label_attr' => ['class' => 'form-label'],
            //     'label' => 'solde',
            //     'required' => true,
            //     'attr' => [
            //         //'readonly'=>true,
            //         'required' => true,
            //         'class' => 'form-control ',
            //         'placeholder' => 'Solde général'
            //     ],
            // ])
            ->add('client', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Client',
                'required' => true,
                'class' => Client::class,
                'query_builder' => function(ClientRepository $er){
                    $qb = $this->em->createQueryBuilder()
                        ->select('c')
                        ->from('App\\Entity\\Client', 'c')
                        ->leftJoin('c.comptes', 'com', 'WITH', 'com.client = c.id')
                        ->andwhere('com.client IS NULL')
                    ;
                    return $qb; 
                },
                'placeholder' => 'Sélectionnez un client...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ],
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
            'data_class' => Compte::class,
        ]);
    }
}
