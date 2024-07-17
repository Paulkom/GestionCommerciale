<?php

namespace App\Form;

use App\Entity\Caisse;
use App\Entity\Livraison;
use App\Entity\Personnel;
use App\Entity\CommandeClient;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use App\Repository\CommandeClientRepository;
use App\Repository\PersonnelRepository;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class LivraisonType extends AbstractType
{
    private $em;
    private SessionInterface $session;
    public function __construct(EntityManagerInterface $entityManager,SessionInterface $session)
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
            ->add('totalResteAliv',HiddenType::class,[
            ])
            ->add('commandeCli',EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Commande',
                'class' => CommandeClient::class,
                'placeholder' => 'Sélectionnez ue commande...',
                'query_builder' => function(CommandeClientRepository $er){
                $pv = $this->session->get('pointVente', []);
                $qb = $this->em->createQueryBuilder()
                    ->select('c')
                    ->from('App\\Entity\\CommandeClient', 'c')
                    ->leftJoin('c.produitCondComClits','pc')
                    ->where('c.statut != :val')
                    ->andWhere('c.pointVente = :val2')
                        
                    //->leftJoin('c.livraisons', 'l', 'WITH', 'l.commandeCli = c.id')
                    //->leftJoin('l.livraisonMagasins','lm')
                    //->leftJoin('lm.produitCondMagLivs','pl')
                    ->groupBy('c.id')
                    ->having('SUM(pc.restAliv) > 0')
                    ->orHaving('SUM(pc.restAliv) IS NULL')
                    ->orderBy('c.id','DESC')
                    ->setParameter('val', 'Annuler')
                    ->setParameter('val2', ($pv != [])? $pv->getId() : 0 );
                    return $qb;
                },
                'attr' => [
                'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ],     
            ])
            ->add('dateLiv',BirthdayType::class, [
                'widget' => 'single_text',
                'format' => 'yyyy-MM-dd',
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Date de livraison',
                'required' => true,
                'attr' => ['required'=>true,
                'readonly'=>true,
                'class'=>'form-control mb-2 form-control-solid', 
                'placeholder' => 'Date de la livraison'],
            ])
            ->add('montantLiv',HiddenType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Montant',
                'required' => true,
                'attr' => [
                    'required'=>true, 
                    'readonly'=>true,
                    'class'=>'form-control mb-2  form-control-solid', 
                    'placeholder' => 'montant'
                ],
            ])
            
            ->add('livreur',EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Livreur',
                'class' => Personnel::class,
                'placeholder' => 'Sélectionnez le livreur',
                'query_builder' => function(PersonnelRepository $pr){
                    $pv = $this->session->get('pointVente', []);
                    $qb = $this->em->createQueryBuilder()
                    ->select('p')
                    ->from('App\\Entity\\Personnel','p')
                    ->where('p.estSup IS NULL')
                    ->andWhere('p.pointVente = :val')
                    ->setParameter('val', ($pv != [])? $pv->getId() : 0 );
                    return $qb;
                },
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ],
            ])
            ->add('livraisonMagasins', CollectionType::class, [
                'required' => false,
                'entry_type' => LivraisonMagasinType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                'prototype_name' => '__livraisonMagasins__'
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Livraison::class,
        ]);
    }
}
