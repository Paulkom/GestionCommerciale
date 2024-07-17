<?php

namespace App\Form;

use App\Entity\ProdCondFact;
use App\Entity\ProduitCondComClit;
use App\Entity\ProduitConditionnement;
use App\Repository\ProduitCondComClitRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ProdCondFactType extends AbstractType
{
    public function __construct(
     private ProduitCondComClitRepository $prodCliRepository,
     private EntityManagerInterface $em)
    {
        
    }
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        ->add('produitComClit', EntityType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Produit',
            'class' => ProduitCondComClit::class,
            'choice_attr' => function(ProduitCondComClit $produit){
                return [
                    "data-restaliv" => $produit->getRestAliv(),
                    "data-prix"  =>$produit->getPrix(),
                    "data-qtite"  =>$produit->getQtite(),
                    "data-montant" =>$produit->getMontant(),
                ];
            },
            'placeholder'=> 'Sélectionnez le produit',
            'required'=>true,
            'attr' => [
                'required' => true, 
                'data-control' => "select2",
                'class' => 'form-control form-select',
                'data-placeholder' => 'Sélectionnez le produit',
            ],
        ])
        ->add('prix',NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Prix',
            'required' => true,
            'attr' => ['required'=>true, 
            'readonly'=>true,
            'class'=>'form-control mb-2 form-control-solid', 
            'placeholder' => ''],
        ])
        ->add('qtiteComd',NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'mapped'=>false,
            'label' => 'Qtité commandée',
            'required' => true,
            'attr' => ['required'=>true, 
            'readonly'=>true,
            'class'=>'form-control mb-2 form-control-solid', 
            'placeholder' => ''],
        ])
        ->add('qtite',NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Qtité à facturer',
            'required' => true,
            'attr' => [
            'required'=>true, 
            'readonly'=>false,
            'class'=>'form-control mb-2', 
            'placeholder' => 'Entrer la quantité'],
        ])
        ->add('montant',NumberType::class, [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Montant',
            'required' => true,
            'attr' => ['required'=>true, 
            'readonly'=>true,
            'class'=>'form-control mb-2 montant form-control-solid', 
            'placeholder' => 'montant'],
        ])
    ;
    $builder->addEventListener(
        FormEvents::PRE_SUBMIT, function (FormEvent $event) {
            $forme = $event->getForm();
            $data = $event->getData();
            //dd('data',$data);
            if(!($data === null))
            {
                $pro = $this->prodCliRepository->find((int)$data["produitComClit"]); 
               // dd($data["produitComClit"],$pro);
                $forme->remove("produitComClit");
                $forme->add('produitComClit', EntityType::class, [
                'label' => 'Produit',
                'class' => ProduitCondComClit::class,
                'choices'=>[$pro]
                ]);
               
            }
            
        }
    );    

$builder->addEventListener(FormEvents::PRE_SET_DATA, function (FormEvent $event){
    $data = $event->getData();
    $form = $event->getForm();
    if(!($data === null) && $data->getId())
    {
        /**
         * @var ProduitCondComClit[] $produits
         *  @var ProduitConditionnement[] $clipro1
         */
       // $produits = $data->getLivraisonMag()->getLivraison()->getCommandeCli() === null ? [] : $this->prodCliRepository->findByCommandeClit($data->getLivraisonMag()->getLivraison()->getCommandeCli());
      dump($data);
       //dd($data);
       $clipro = $data->getFacture()->getCommandeCli()->getProduitCondComClits();
        
        //$produit = $data->getProduit()->getId() === null ? null : $this->prodCliRepository->getOnPro($data->getProduit()->getId(),$data->getLivraisonMag()->getLivraison()->getCommandeCli()->getId());

        //$data->setProduitComClit($produit);
       //$event->setData($data);
        $form->remove('produitComClit')
        ->add('produitComClit',EntityType::class, [                                               
            'required' => true,
            'label_attr' => ['class' => 'form-label'],
            'label_html' => true,
            'class' => ProduitCondComClit::class,
            'choice_attr' => function(ProduitCondComClit $produit){
                return [
                    "data-restaliv" => $produit->getRestAliv(),
                    "data-prix"  =>$produit->getPrix(),
                    "data-qtite"  =>$produit->getQtite(),
                    "data-montant" =>$produit->getMontant(),
                ];
            },
            'placeholder'=> 'Sélectionnez le produit',
            'attr' => [
                'required' => true, 
                'data-control' => "select2",
                'class' => 'form-control form-select',
                'data-placeholder' => 'Sélectionnez le produit',
            ],
            'choices'=> $clipro,
            //$data->getLivraisonMag()->getLivraison()->getCommandeCli()->getProduitCondComClits()
        ])
        ;
    }
});



    }
    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProdCondFact::class,
        ]);
    }
}
