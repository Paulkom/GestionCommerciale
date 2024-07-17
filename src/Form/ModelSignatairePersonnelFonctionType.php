<?php

namespace App\Form;

use App\Entity\Fonction;
use App\Entity\Personnel;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\AbstractType;
use App\Entity\ModelSignatairePersonnelFonction;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class ModelSignatairePersonnelFonctionType extends AbstractType
{
    private $session;
    private $em;
    public function __construct(EntityManagerInterface $em, SessionInterface $session)
    {
        $this->session = $session;
        $this->em = $em;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('personnel', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Signataire',
                'class' => Personnel::class,
                'choice_attr'  => function(Personnel $pe){
                    return ['optionValue' => 'pers-'.$pe->getId() ];
                },
                'placeholder'=> 'Sélectionnez un signataire...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select',
                    //'data-placeholder' => 'Sélectionnez une famille...'
                ],
            ])
            ->add('fonction', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Fonction',
                'class' => Fonction::class,
                'query_builder' => function(){
                    $pv = $this->session->get('pointVente', []);
                    $qb = $this->em->createQueryBuilder()
                    ->select('f')
                    ->from("App\\Entity\\Fonction",'f')
                    ->where('f.estSup IS NULL')
                    ->andWhere('f.pointVente = :val')
                    ->setParameter('val', ($pv != [])? $pv->getId() : 0 );
                    // dd($qb);
                    return $qb;
                },
                'choice_label' => function(Fonction $fonc){
                    return $fonc->getIntitule().' [ '.$fonc->getCode().' ] ';
                },
                'choice_attr' => function(Fonction $fonct){
                    return ['optionValue' => 'fonc-'.$fonct->getId(),];
                },
                'placeholder'=> 'Sélectionnez une fonction ...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select',
                    //'data-placeholder' => 'Sélectionnez une famille...'
                ],
            ])
            // ->add('position', TextType::class, [
            //     'label_attr' => ['class' => 'form-label'],
            //     'label' => 'Position',
            //     'required' => true,
            //     'attr' => [
            //         'required'=>true, 
            //         'class'=>'form-control mb-2 unicite', 
            //         'placeholder' => 'Position sur le document ex: 1'
            //     ],
            // ])
            // ->add('modelSignataire')
        ;
        
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ModelSignatairePersonnelFonction::class,
        ]);
    }
}
