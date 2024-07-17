<?php

namespace App\Form;

use App\Entity\Personnel;
use App\Entity\Utilisateur;
use App\Repository\ProfilRepository;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use App\Repository\PersonnelRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use App\Form\UtilisateurPointDeVenteType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Validator\Constraints\Length;
use Symfony\Component\Validator\Constraints\NotBlank;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;


class UtilisateurType extends AbstractType
{
   

    private $em;
    private $profilRepo;

    public function __construct(EntityManagerInterface $entityManager, ProfilRepository $profilRepo)
    {
        $this->em = $entityManager;
        $this->profilRepo = $profilRepo;
    }
    
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $routes = array();
        $profils = $this->profilRepo->findBy(['deletedAt' => NULL]);
       
        foreach ($profils as $pro ) {
            if($pro->getRoles() != []){
                $routes[$pro->getTitre()] = $pro->getId();
            }
        }

        $builder
            ->add('username', TextType::class, [
                // 'label_attr' => ['class' => 'form-label'],
                'label' => 'Nom d\'utilisateur',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2 unicite', 
                'placeholder' => 'Entrer le nom de l\'utilisateur'],
            ])
            
            // ->add('roles',ChoiceType::class,[
            //     'label'=>"Droit",
            //     'choices'=>[
            //         'UTILISATEUR' => "ROLE_USER",
            //         'ADMINISTRATEUR' => "ROLE_ADMIN",
            //         'SUPER ADMINISTRATEUR' => "ROLE_SUPER_ADMIN",
            //         'CAISSIERE' => "ROLE_CAISSIERE"
            //     ],
            //     'multiple'=>true,
            //     'required' => false,
            //     'attr'=>[
            //         'required' => false,
            //         'data-control' => 'select2',
            //         'class'=>'js-example-basic-single form-control d-none',
            //     ],
            // ])

            ->add('profil', ChoiceType::class,[
                'choices' => $routes,
                'label' => 'Profil(s)',
                // 'mapped' => false,
                'multiple' => true,
                'placeholder' => 'Sélectionner le(s) profil(s)',
                'attr' => [ 
                    'required' => false,
                    'data-control' => 'select2',
                    'class' => 'js-example-basic-single form-control' 
                ],
                'required' => false,
            ])
            ->add('password', RepeatedType::class, [
                'type' => PasswordType::class,
                'invalid_message' => 'Ce mot de passe ne correspond pas.',
                'options' => ['attr' => ['class' => 'password-field']],
                'required' => true,
                'mapped' => false,
                'first_options'  => ['label' => 'Mot de passe', 'attr'=>['placeholder' => 'Mot de passe', 'class' => 'form-control']],
                'second_options' => ['label' => 'Confirmation', 'attr'=>['placeholder' => 'Confirmer le mot de passe', 'class' => 'form-control']],
                'constraints' => [
                    new NotBlank([
                        'message' => 'Entrez un mot de passe',
                    ]),
                    new Length([
                        'min' => 3,
                        'minMessage' => 'Votre mot de passe doit contenir au moins {{ limit }} caractères',
                        // max length allowed by Symfony for security reasons
                        'max' => 4096,
                    ]),
                ],
            ])
            ->add('utilisateurPointDeVentes', CollectionType::class, [
                'required' => true,
                'entry_type' => UtilisateurPointDeVenteType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__utilisateurPointDeVentes__'
            ])
            ->add('personnel', EntityType::class, [
                'label' => 'Personnel',
                'class' => Personnel::class,
                'placeholder' => 'Veuillez sélectionner un personnel',
                'query_builder' => function(PersonnelRepository $pr){
                    $qb = $this->em->createQueryBuilder()
                        ->select('p')
                        ->from('App\\Entity\\Personnel', 'p')
                        ->leftJoin('p.utilisateur','u')
                        ->where('p.deletedAt IS NULL')
                    ;
                    return $qb;
                },
                'choice_label' => function(Personnel $personnel){
                    return $personnel->getNom().' '.$personnel->getPrenoms();
                },
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

                if( $data->getusername() != ''){
                    $form->remove('password')
                    ->add('password', RepeatedType::class, [
                        'type' => PasswordType::class,
                        'invalid_message' => 'Ce mot de passe ne correspond pas.',
                        'options' => ['attr' => ['class' => 'password-field']],
                        'required' => false,
                        'mapped' => false,
                        'first_options'  => ['label' => 'Mot de passe', 'attr'=>['placeholder' => 'Mot de passe', 'class' => 'form-control']],
                        'second_options' => ['label' => 'Confirmation', 'attr'=>['placeholder' => 'Confirmer le mot de passe', 'class' => 'form-control']],
                        'constraints' => [
                            new NotBlank([
                                'message' => 'Entrez un mot de passe',
                            ]),
                            new Length([
                                'min' => 3,
                                'minMessage' => 'Votre mot de passe doit contenir au moins {{ limit }} caractères',
                                // max length allowed by Symfony for security reasons
                                'max' => 4096,
                            ]),
                        ],
                    ]);
                }

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
            // ->add('password')
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Utilisateur::class,
        ]);
    }

    // public function getParent()
    // {
    //     return PersonnelType::class;
    // }
}
