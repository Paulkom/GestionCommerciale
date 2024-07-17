<?php

namespace App\Form;

use App\Entity\Banque;
use App\Entity\Facture;
use App\Entity\Paiement;
use App\Entity\ModePaiement;
use App\Repository\FactureRepository;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class PaiementType extends AbstractType
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
        ->add('truc',HiddenType::class,[
            'mapped'=>false,
            ])
        ->add('datePaie',BirthdayType::class, [
            'widget' => 'single_text',
            'format' => 'yyyy-MM-dd',
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Date de paiement',
            'required' => true,
            'attr' => ['required'=>true,
            'readonly'=>true,
            'class'=>'form-control mb-2 form-control-solid', 
            'placeholder' => 'Date de paiement'],
        ])
        ->add('montantPaye',NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Montant payé',
            'required' => true,
            'attr' => ['required'=>true, 
            //'readonly'=>true,
            'class'=>'form-control mb-2', 
            'placeholder' => 'montant payé'],
        ])
        ->add('montantRAPayer',NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Montant reste à payer',
            'required' => false,
            'attr' => ['required'=>false, 
            'readonly'=>true,
            'class'=>'form-control mb-2 form-control-solid', 
            'placeholder' => 'Montant reste à payer'],
        ])
        ->add('modePaiement',EntityType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Mode de paiement',
            'class' => ModePaiement::class,
            'query_builder' => function(){
                $qb = $this->em->createQueryBuilder()
                    ->select('m')
                    ->from('App\\Entity\\ModePaiement', 'm')
                    ->where('m.deletedAt IS NULL')
                ;
                return $qb;
            },
            'placeholder' => 'Sélectionnez le mode de paiement...',
            'attr' => [
                'required' => true,
                'data-control' => "select2",
                'class' => 'form-select'
            ],
        ])
        ->add('montantFacture',NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Montant dû',
            'mapped'=>false,
            'required' => true,
            'attr' => ['required'=>true, 
            'readonly'=>true,
            'class'=>'form-control mb-2 form-control-solid', 
            'placeholder' => 'Montant de la facture'],
        ])
        ->add('numeroMobileMoney', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Numéro Mobile Money',
            'required' => false,
            'attr' => [
                //'readonly'=>true,
                'class' => 'form-control mobilemoney',
                'placeholder' => 'Numéro Mobile Money'
            ],
        ])
        ->add('refOperation', TextType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Référence de la transaction',
            'required' => false,
            'attr' => [
                //'readonly'=>true,
                'class' => 'form-control virement cheque mobilemoney',
                'placeholder' => 'Référence'
            ],
        ])
        ->add('banque', EntityType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Banque',
            'class' => Banque::class,
            'choice_label' => 'sigle',
            'placeholder' => 'Sélectionnez une banque...',
            'required' => false,
            'attr' => [
                //'readonly'=>true,
                'data-control' => "select2",
                'class' => 'form-select virement cheque'
            ],
        ])
        ->add('montantRecu', NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Montant reçu',
            //'mapped' => false,
            'required' => false,
            'attr' => [
            'required'=>false, 
            'class'=>'form-control mb-2', 
            'placeholder' => 'Montant reçu...',],
        ])
        ->add('reliquat', NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Reliquat',
            //'mapped' => false,
            'required' => false,
            'attr' => [
            'required'=>false, 
            'readonly'=>true,
            'class'=>'form-control mb-2 form-control-solid', 
            'placeholder' => 'Reliquat'],
        ])
        ->add('facture',EntityType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Facture',
            'class' => Facture::class,
            'query_builder' => function(){
                $pv = $this->session->get('pointVente', []);
                $qb = $this->em->createQueryBuilder()
                        ->select('f')
                        ->from('App\\Entity\\Facture', 'f')
                        ->leftJoin("App\\Entity\\CommandeClient", 'c', 'WITH', 'c.id = f.commandeCli')
                        ->leftJoin('f.paiements', 'p', 'WITH', 'p.facture = f.id')
                        ->where('f.commandeCli != :val')
                        ->andWhere("c.deletedAt IS NULL")
                        ->andWhere('f.pointVente = :val1')
                        ->andWhere("f.typeFacture = :type")
                        ->andWhere("f.montantRest != 0 OR f.montantRest IS NULL")
                        // ->orWhere("f.montantRest IS NULL")
                        ->setParameter('val1', ($pv != [])? $pv->getId() : 0 )
                        ->setParameter('val',"")
                        ->setParameter('type',"FV")
                        // ->groupBy('f.id')
                        // ->having('SUM(p.montantPaye) < MAX(f.montantTotal)')
                        // ->orHaving('SUM(p.montantPaye) IS NULL')
                        ->orderBy('f.refFac','DESC')
                ;
                return $qb;
            },
            'choice_attr' => function(Facture $facture){
                $solde=0;
                $montantRest=0.00;
                if (count($facture->getCommandeCli()->getAcheteur()->getComptes()) > 0) {
                    $solde = $facture->getCommandeCli()->getAcheteur()->getComptes()[0]->getSolde();
                }else{
                    $solde="";
                }
                $montantRest = ($facture->getMontantRest() == "") ? $facture->getMontantTotal() : $facture->getMontantRest() ;
                return [
                    'data-montantIni'  => $facture->getMontantTotal(),
                    'data-montantRest' => $montantRest,
                    'data-solde' => $solde
                ];
            },
            'placeholder' => 'Sélectionnez une facture...',
            'attr' => [
                'required' => true,
                'data-control' => "select2",
                'class' => 'form-select'
            ],
        ])
        ;
    

        $builder->addEventListener(FormEvents::PRE_SET_DATA, function(FormEvent $event){
        /** @var Paiement $data */
        $data = $event->getData();
        $form = $event->getForm();
        if(!($data === null) && !empty($data->getId()))
        {
            $form
                ->remove('facture')
                ->add('facture', EntityType::class, [
                    'required' => true,
                    'label' => 'Facture',
                    'class' => Facture::class,
                    'query_builder' => function(FactureRepository $er){
                        $qb = $this->em->createQueryBuilder()
                        ->select('f')
                        ->from('App\\Entity\\Facture', 'f')
                        ->leftJoin('f.paiements', 'p', 'WITH', 'p.facture = f.id')
                        ->groupBy('f.id')
                        ->having('SUM(p.montantPaye) < MAX(f.montantTotal)')
                        ->orHaving('SUM(p.montantPaye) IS NULL')
                        ;
                        return $qb;
                    },
                    'choice_attr' => function(Facture $facture){
                        $solde = "";
                        $montantRest = 0.00;
                        if (count($facture->getCommandeCli()->getAcheteur()->getComptes()) > 0) {
                            $solde = $facture->getCommandeCli()->getAcheteur()->getComptes()[0]->getSolde();
                        }else{
                            $solde="";
                        }
                        $montantRest = ($facture->getMontantRest() == "") ? $montantRest = $facture->getMontantTotal() : $facture->getMontantRest() ;
                        return [
                            'data-montantIni'  => $facture->getMontantTotal(),
                            'data-montantRest' => $montantRest,
                            'data-solde' => $solde
                        ];
                    },
                    'placeholder'=> 'Sélectionnez une facture...',
                    'attr' => ['class' => 'sogema_sample_select form-control',]
                ]);
            }
        });
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Paiement::class,
        ]);
    }
}
