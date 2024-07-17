<?php

namespace App\Form;

use App\Entity\Magasin;
use App\Entity\Personnel;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use App\Repository\PersonnelRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;

use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class MagasinType extends AbstractType
{
    private $em;
    private $pointVente;
    public function __construct(EntityManagerInterface $entityManager, SessionInterface $session)
    {
        $this->em = $entityManager;
        $this->pointVente = $session->get('pointVente',[]);
    }
    
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('nomMag', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Nom du magasin',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2 unicite', 
                'data-column' =>'Magasin|nomMag',
                'placeholder' => 'Entrer le nom du magasin'],
            ])
            ->add('codeMag', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Code du magasin',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2 unicite', 
                'data-column' =>'Magasin|codeMag',
                'placeholder' => 'Entrer le code du magasin'],
            ])
            ->add('adresse', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Adresse du magasin',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer l\'adresse du magasin'],
            ])
            ->add('estPrincipal', CheckboxType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Est Principal ?',
                'required' => false,
                'attr' => [
                    'class' => 'form-check-input',
                ],
            ])
            ->add('superviseur',EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'required' => true,
                'label' => 'Magasinier',
                'class' => Personnel::class,
                'query_builder' => function(PersonnelRepository $pr){
                    $qb = $this->em->createQueryBuilder()
                        ->select('p')
                        ->from('App\\Entity\\Personnel', 'p')
                        ->where('p.deletedAt IS NULL')
                        ->andWhere('p.pointVente = :val')
                        ->setParameter('val', ($this->pointVente) ? $this->pointVente->getId() : null )
                    ;
                    return $qb;
                },
                'placeholder'=> 'Sélectionnez le magasinier',
                'attr' => [
                    'required'=>true,
                    'class' => 'form-control form-select',
                    'data-control' => "select2",
                    'data-placeholder' => 'Sélectionnez le magasinier',
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
            'data_class' => Magasin::class,
        ]);
    }
}
