<?php

namespace App\Form;

use App\Entity\Pays;
use App\Entity\Client;
use App\Entity\CommandeClient;
use App\Entity\FormatImpression;
use App\Entity\ModelSignataire;
use App\Entity\ProduitCondComClit;
use App\Services\LibrairieService;
use Symfony\Component\Form\AbstractType;
use App\Form\ElementSupplementaireComClitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;

class CommandeClientType extends AbstractType
{

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        
        $builder
            ->add('truc',HiddenType::class,[
                'mapped'=>false,
                ])
            ->add('dateCom',BirthdayType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date commande',
                'required' => true,
                'attr' => ['required'=>true,
                'readonly'=>true,
                'class'=>'form-control mb-2 form-control-solid', 
                'placeholder' => 'Date de la commande'],
            ])
            ->add('dateLivPrev',BirthdayType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date Liv. Prev.',
                'required' => false,
                'attr' => ['required'=>false,
                //'readonly'=>true,
                'class'=>'form-control mb-2 ', 
                'placeholder' => 'Date Livraison Prevu.'],
            ])
            //->add('statut')
            ->add('montantHt', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant HT',
                'required' => true,
                'attr' => ['required'=>true, 
                'readonly'=>true,
                'class'=>'decimal form-control mb-2 form-control-solid', 
                'placeholder' => 'Montant HT'],
            ])
            ->add('montantTS', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant Taxe S.',
                'required' => true,
                'attr' => ['required'=>true, 
                'readonly'=>true,
                'class'=>'decimal form-control mb-2 form-control-solid', 
                'placeholder' => 'Montant Taxe S.'],
            ])
            ->add('montantAib', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant AIB',
                'required' => false,
                'attr' => [
                'readonly'=>true,
                'class'=>'decimal form-control mb-2 form-control-solid', 
                'placeholder' => 'Montant AIP'],
            ])
            ->add('tauxAib', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label'],
                'choices'  => [
                    '1%' => '1',
                    '5%' => '5',
                ],
                'label' => 'Taux AIB',
                'required' => false,
                'placeholder' => 'Sélectionnez le taux ...',
                'attr' => [
                    'class'=>'form-control mb-2 form-select', 
                    'data-control' => "select2",
                    // 'data-placeholder' => 'Type de commande'
                ],
            ])
            // ->add('typeRemise', ChoiceType::class, [
            //     'label_attr' => ['class' => 'form-label'],
            //     'choices'  => [
            //          'Pourcentage'=>'%' ,
            //         'Montant'=>'MT'  ,
            //     ],
            //     'label' => 'Type de remise',
            //     'required' => false,
            //     'placeholder' => 'Sélectionnez le type ..',
            //     'attr' => [
            //     //'required'=>true,
            //     'class'=>' form-control mb-2 form-select', 
            //     'data-control' => "select2",
            //     //'data-placeholder' => 'Type de remise'
            //     ],
            // ])
            ->add('typeCommande', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label'],
                'choices'  => [
                    'Au comptoir' => 'Au comptoir',
                    'Sur Commande' => 'Sur Commande',
                ],
                'label' => 'Type commande',
                'required' => true,
                'placeholder' => 'Sélectionnez le type ...',
                'attr' => [
                    //'required'=>true,
                'class'=>'form-control mb-2 form-select', 
                'data-control' => "select2",
                    // 'data-placeholder' => 'Type de commande'
                ],
            ])
            ->add('typeFacture', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label'],
                'choices'  => [
                    'Facture de vente' => 'FV',
                    'Facture de vente à l\'exportation' => 'EV',
                ],
                'label' => 'Type de Fact.',
                'required' => true,
                'placeholder' => 'Sélectionnez le type ...',
                'choice_attr' => [
                    'Facture de vente' => ['selected' => true],
                ],
                'attr' => [
                    'required'=>true,
                    'class'=>'form-control mb-2 form-select', 
                    'data-control' => "select2",
                ],
            ])
            // ->add('valeurRemise', NumberType::class, [
            //     'label_attr' => ['class' => 'form-label'],
            //     'label' => 'Valeur Remise',
            //     'required' => false,
            //     'attr' => ['required'=>false, 
            //     //'readonly'=>true,
            //     'class'=>'decimal form-control mb-2 form-control-solid', 
            //     'placeholder' => 'Valeur de la remise'],
            // ])
            // ->add('remise', NumberType::class, [
            //     'label_attr' => ['class' => 'form-label'],
            //     'label' => 'MH Remise',
            //     'required' => false,
            //     'attr' => ['required'=>false, 
            //     'readonly'=>true,
            //     'class'=>'decimal form-control mb-2 form-control-solid', 
            //     'placeholder' => 'Montant HT'],
            // ])
            ->add('montantTtc', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant TTC',
                'required' => true,
                'attr' => ['required'=>true, 
                'readonly'=>true,
                'class'=>'decimal form-control mb-2 form-control-solid', 
                'placeholder' => 'Montant TTC'],
            ])
            ->add('montantHtToAprRse', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'MT HT Apr. Rse.',
                'required' => true,
                'attr' => ['required'=>true, 
                'readonly'=>true,
                'class'=>'decimal form-control mb-2 form-control-solid', 
                'placeholder' => 'Montant ht après remise'],
            ])
            ->add('montantTva', NumberType::class, [
                'label_attr' => ['class' => 'form-label ' ],
                'label' => 'Montant TVA',
                'required' => true,
                'attr' => ['required'=>true, 
                'readonly'=>true,
                'class'=>'decimal form-control mb-2 form-control-solid', 
                'placeholder' => 'Montant TVA'],
            ])
            ->add('acheteur',EntityType::class,[
                'label_attr' => ['class' => 'form-label'],
                'label_html' => true,
                'required' => false,
                'label' => 'Client &nbsp; &nbsp;&nbsp;&nbsp;<a href="#" id="newclient" data-bs-toggle="modal" data-bs-target="#kt_modal_scrollable_2" class="btn-active-light-primary"><span class="badge badge-primary badge-circle badge-sm">+</span> Ajouter un client</a>',
                'class' => Client::class,
                'placeholder'=> 'Sélectionnez le Client',
                'choice_attr' => function(Client $cli){
                    return  ['selected' => ($cli->getNom() == 'Ordinaire') ? true : false];
                },
                'attr' => [
                    //'required'=>true,
                    'class' => 'form-control form-select',
                    'data-control' => "select2",
                    //'data-placeholder' => "Sélectionnez le client "
                ]
            ])
            ->add('produitCondComClits', CollectionType::class, [
                'required' => true,
                'entry_type' => ProdCondComClitType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
            ])
            ->add('elementSupplementaires', CollectionType::class, [
                'required' => true,
                'entry_type' => ElementSupplementaireComClitType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
            ])

            // Ajouter un client lors de le vente

            ->add('nom', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Nom',
                'required' => false,
                'mapped' => false,
                'attr' => ['required'=>false, 
                'class'=>'form-control mb-2 physique', 
                'placeholder' => 'Entrer le nom'],
            ])
            ->add('prenom', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Prénoms',
                'required' => false,
                'mapped' => false,
                'attr' => ['required'=>false, 
                'class'=>'form-control mb-2 physique', 
                'placeholder' => 'Entrer le(s) prenom(s)'],
            ])
            ->add('adresse', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Adresse',
                'required' => false,
                'mapped' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer l\'adresse'],
            ])
            ->add('email', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Email',
                'required' => false,
                'mapped' => false,
                'attr' => [
                'required'=>false,
                'data-fv-email-address'=>"true",
                'data-fv-email-address___message' => "Cet email n'est pas valide.",
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer l\'email'],
            ])
            ->add('telephone1', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Téléphone 1',
                //'required' => true,
                'mapped' => false,
                'attr' => [
                    //'required'=>true,
                'class'=>'form-control mb-2 telephone', 
                'placeholder' => 'Entrer le numero de téléphone'],
            ])
            ->add('telephone2', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Téléphone 2',
                'required' => false,
                'mapped' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 telephone', 
                'placeholder' => 'Entrer le numero de téléphone'],
            ])
            ->add('raisonSociale', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Raison sociale',
                'required' => false,
                'mapped' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 moral', 
                'placeholder' => 'Entrer la raison sociale'],
            ])
            ->add('ifu', IntegerType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'N° IFU',
                'required' => false,
                'mapped' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2', 
                'placeholder' => 'Entrer le numero IFU'],
            ])
            ->add('rccm', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'N° RCCM',
                'mapped' => false,
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 moral', 
                'placeholder' => 'Entrer le numero du Registre de commerce'],
            ])
            ->add('sigle', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Sigle',
                'mapped' => false,
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 moral', 
                'placeholder' => 'Entrer le sigle'],
            ])
            ->add('denomination', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Dénomination',
                'required' => false,
                'mapped' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 moral', 
                'placeholder' => 'Entrer la denomination'],
            ])
            ->add('statut', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label ok'],
                'choices'  => [
                    'Physique' => 'Physique',
                    'Moral' => 'Moral',
                ],
                'mapped' => false,
                'choice_attr' => [
                    'Physique' => ['checked' => true],
                ],
                'expanded' => true,
                'multiple' => false,
                'attr' => ['required'=>true],
            ])
            ->add('dateNais', BirthdayType::class, [
                'widget' => 'single_text',
                'mapped' => false,
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date de naissance',
                'required' => false,
                'attr' => ['required'=>false,
                'class'=>'form-control mb-2 physique', 
                'placeholder' => 'Date de naissance'],
            ])

            //information pour le paiement lors de la vente
            ->add('montantRecu', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant reçu',
                'mapped' => false,
                'required' => false,
                'attr' => [
                'required'=>false, 
                //'readonly'=>true,
                'class'=>'form-control mb-2 decimal comptoire comp', 
                'placeholder' => 'Montant reçu'],
            ])
            ->add('reliquat', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Reliquat',
                'mapped' => false,
                'required' => false,
                'attr' => [
                'required'=>false, 
                'readonly'=>true,
                'class'=>'form-control mb-2 comptoire form-control-solid', 
                'placeholder' => 'Reliquat'],
            ])
            ->add('paysOrigine',EntityType::class,[
                'label_attr' => ['class' => 'form-label'],
                'label_html' => true,
                'required' => false,
                'label' => 'Pays d\'origine',
                'class' => Pays::class,
                'placeholder'=> 'Sélectionnez un pays',
                'attr' => [
                    //'required'=>true,
                    'class' => 'form-control form-select vente_exportation',
                    'data-control' => "select2",
                    //'data-placeholder' => "Sélectionnez le client "
                ]
            ])
            ->add('paysDestination',EntityType::class,[
                'label_attr' => ['class' => 'form-label'],
                'label_html' => true,
                'required' => false,
                'label' => 'Pays de destination',
                'class' => Pays::class,
                'placeholder'=> 'Sélectionnez un pays',
                'attr' => [
                    //'required'=>true,
                    'class' => 'form-control form-select vente_exportation',
                    'data-control' => "select2",
                    //'data-placeholder' => "Sélectionnez le client "
                ]
            ])
            ->add('modelSignataire',EntityType::class,[
                'label_attr' => ['class' => 'form-label'],
                'label_html' => true,
                'required' => false,
                'label' => 'Modèle signataire',
                'class' => ModelSignataire::class,
                'placeholder'=> 'Sélectionnez un modèle',
                'choice_label' => function(ModelSignataire $model){
                    return $model->getLibelle();
                },
                'choice_attr' => function(ModelSignataire $model){
                    return ['selected' => ($model->getEstDefault())? true : false ];
                },
                'attr' => [
                    //'required'=>true,
                    'class' => 'form-control form-control-solid form-select',
                    'data-control' => "select2",
                    //'data-placeholder' => "Sélectionnez le client "
                ]
            ])
            ->add('formatImpression',EntityType::class,[
                'label_attr' => ['class' => 'form-label'],
                'mapped' => false,
                'label_html' => true,
                'required' => false,
                'label' => 'Format impression',
                'class' => FormatImpression::class,
                'placeholder'=> 'Format impression',
                'choice_label' => function(FormatImpression $format){
                    return $format->getLibelle();
                },
                'choice_attr' => function(FormatImpression $format){
                    return ['selected' => ($format->getEstActif())? true : false ];
                },
                'attr' => [
                    //'required'=>true,
                    'class'              => 'form-control form-control-solid form-select',
                    'data-control'       => "select2",
                    //'data-placeholder' => "Sélectionnez le client"
                ]
            ])
            ->add('lieuChargement', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Lieu de chargement',
                'required' => false,
                'attr' => [
                'required'=>false, 
                'class'=>'form-control mb-2 form-control-solid vente_exportation', 
                'placeholder' => 'Lieu de chargement'],
            ])
            ->add('lieuDechargement', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Lieu de déchargement',
                'required' => false,
                'attr' => [
                'required'=>false, 
                'class'=>'form-control mb-2 form-control-solid vente_exportation', 
                'placeholder' => 'Lieu de dechargement'],
            ])
            ->add('checknet', HiddenType::class, [
                'mapped' => false,
                'required' => false,
                'attr' => [
                'required'=>false, ],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => CommandeClient::class,
        ]);
    }
}
