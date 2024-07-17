<?php

namespace App\Form;

use App\Entity\Famille;
use App\Entity\Conditionnement;
use App\Repository\FamilleRepository;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;


class FamilleType extends AbstractType
{
    private $em;
    private $session;
    public function __construct(EntityManagerInterface $em, SessionInterface $session)
    {
        $this->em  = $em;
        $this->session  = $session;
    }
    
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('codeFamille', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Code Famille',
                'required' => true,
                'attr' => ['required'=>true, 
                'maxlength' => 8,
                'class'=>'form-control mb-2 unicite', 
                'data-column' =>'Famille|codeFamille',
                'placeholder' => 'Entrer le libelle de la famille'],
            ])
            ->add('libelleFamille', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Libelle Famille',
                'required' => true,
                'attr' => ['required'=>true, 
                'class'=>'form-control mb-2 unicite', 
                'data-column' =>'Famille|libelleFamille',
                'placeholder' => 'Entrer le libelle de la famille'],
            ])
            ->add('familleParent',EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'required' => false,
                'label' => 'Parent',
                'class' => Famille::class,
                'query_builder' => function(FamilleRepository $fr){
                    $pv = $this->session->get('pointVente', []);
                    $qb = $this->em->createQueryBuilder()
                    ->select('f')
                    ->from("App\\Entity\\Famille",'f')
                    ->where('f.estSup IS NULL')
                    ->andWhere('f.pointVente = :val')
                    ->setParameter('val', ($pv != [])? $pv->getId() : 0 );
                    return $qb;
                },
                'placeholder'=> 'Sélectionnez le parent',
                'attr' => [
                    'required'=>false,
                    'class' => 'form-control form-select selectpicker',
                    'data-control' => "select2",
                    // 'data-placeholder' => "Sélectionnez le parent "
                ]
            ])
        
        ->add('keys', HiddenType::class,[
            'mapped' => false,
            'attr' => ['class'=>'keys','data-id'=>'',
            'data-column' =>'Famille|codeFamille|libelleFamille',
            ]
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
                        'data-column' =>'Famille|codeFamille|libelleFamille'
                    ]
                ]);
            }
        });
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Famille::class,
        ]);
    }
}
