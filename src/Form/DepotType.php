<?php

namespace App\Form;

use App\Entity\Banque;
use App\Entity\Client;
use App\Entity\Transaction;
use App\Entity\CompteBanque;
use App\Entity\ModePaiement;
use App\Repository\ClientRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class DepotType extends AbstractType
{

    private $em;
    private $session;
    public function __construct(EntityManagerInterface $entityManager, SessionInterface $session)
    {
        $this->em = $entityManager;
        $this->session = $session;
    }
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        ->add('truc',HiddenType::class,[
            'mapped'=>false,
            ])
        ->add('dateTransac',BirthdayType::class, [
            'widget' => 'single_text',
            'format' => 'yyyy-MM-dd',
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Date du dépôt',
            'required' => true,
            'attr' => ['required'=>true,
            'readonly'=>true,
            'class'=>'form-control mb-2 form-control-solid', 
            'placeholder' => 'Date de facture'],
        ])
        ->add('numeroMobileMoney', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Numéro Mobile Money',
            'required' => false,
            'attr' => [
                //'readonly'=>true,
                'class' => 'form-control telephone mobilemoney',
                'placeholder' => 'Numéro Mobile Money'
            ],
        ])
        ->add('refTransac', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Référence de la transaction',
            'required' => false,
            'attr' => [
                //'readonly'=>true,
                'class' => 'form-control virement cheque mobilemoney',
                'placeholder' => 'Référence'
            ],
        ])

        ->add('motif', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Motif du dépôt',
            'required' => false,
            'attr' => [
                //'readonly'=>true,
                'class' => 'form-control',
                'placeholder' => 'motif du dépôt'
            ],
        ])
        ->add('montantTransac', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Montant',
            'required' => true,
            'attr' => [
                //'readonly'=>true,
                'class' => 'form-control decimal',
                'placeholder' => '0'
            ],
        ])
        ->add('comptebanque', EntityType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Compte bancaire',
            'class' => CompteBanque::class,
            'query_builder' => function(){
                $qb = $this->em->createQueryBuilder()
                    ->select('c')
                    ->from('App\\Entity\\CompteBanque','c')
                    ->where('c.estSup IS NULL')
                    ;
                    return $qb;
            },
            'choice_label' => function(CompteBanque $compte){
                return ' [ '.$compte->getBanque()->getSigle().' ] '.$compte->getNumeroCompteBQ();
            },
            // 'choice_label' => 'sigle',
            'placeholder' => 'Sélectionnez un compte...',
            'required' => false,
            'attr' => [
                //'readonly'=>true,
                'data-placeholder' => 'Sélectionnez un compte...',
                'data-control' => "select2",
                'class' => 'form-select decimal virement cheque'
            ],
        ])
        ->add('modePaiement', EntityType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Mode de paiement',
            'class' => ModePaiement::class,
            'choice_label' => 'libelle',
            'query_builder' => function (){
                $qb = $this->em->createQueryBuilder()
                ->select('m')
                ->from("App\\Entity\\ModePaiement",'m')
                ->where('m.estSup IS NULL')
                ;
                return $qb;
            },
            'placeholder' => 'Sélectionnez un mode...',
            'required' => true,
            'attr' => [
                'required' => true,
                'data-control' => "select2",
                'class' => 'form-select'
            ],
        ])
        ->add('client', EntityType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Client',
            'required' => true,
            'class' => Client::class,
            'query_builder' => function(ClientRepository $er){
                $pv = $this->session->get('pointVente', []);
                $qb = $this->em->createQueryBuilder()
                    ->select('c')
                    ->from('App\\Entity\\Client', 'c')
                    ->leftJoin('c.comptes', 'com', 'WITH', 'com.client = c.id')
                    ->where('com.client != :val')
                    ->andWhere('c.estSup IS NULL')
                    ->setParameter('val',"")
                    ->andWhere('c.pointVente = :val')
                    ->setParameter('val', ($pv != [])? $pv->getId() : 0 )
                ;
                return $qb;
            },
            'placeholder' => 'Sélectionnez un client...',
            'attr' => [
                'required' => true,
                'data-control' => "select2",
                'class' => 'form-select'
            ],
        ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Transaction::class,
        ]);
    }
}
