<?php

namespace App\Form;

use App\Entity\Caisse;
use App\Entity\ListCaisse;
use App\Entity\Personnel;
use App\Repository\ListCaisseRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CollectionType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class CaisseType extends AbstractType
{
    private $em;
    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->em = $entityManager;
    }
    
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('lcaisse',EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Caisse',
                'class' => ListCaisse::class,
                'placeholder' => 'Sélectionnez une caisse...',
                'query_builder' => function(ListCaisseRepository $er){
                    $qb = $this->em->createQueryBuilder()
                        ->select('l')
                        ->from('App\\Entity\\ListCaisse', 'l')
                        ->andWhere('l.etat = 0')
                        ->andWhere('l.deletedAt IS NULL')
                    ;
                    return $qb;
                },
                'attr' => [
                   // 'readonly'=>true,
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select '
                ],
            ])
            ->add('fondRoulement', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Fond de roulement',
                'required' => false,
                'attr' => [
                    //'required'=>true,
                    'readonly'=>true,
                    'class'=>'form-control mb-2 form-control-solid', 
                    'placeholder' => 'Entrer le fond de roulement'
                ],
            ])
            ->add('ecart', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'ecart',
                'required' => true,
                'attr' => [
                'required'=>true, 
                'readonly'=>true,
                'class'=>'form-control mb-2 form-control-solid', 
                'placeholder' => 'ecart'],
            ])
            ->add('depense', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Dépense',
                'required' => true,
                'attr' => [
                'required'=>true, 
                'readonly'=>true,
                'class'=>'form-control mb-2 form-control-solid', 
                'placeholder' => 'Dépense'],
            ])
            ->add('chiffreAffaire', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Recette journalière',
                'required' => true,
                'attr' => [
                'required'=>true, 
                'readonly'=>true,
                'class'=>'form-control mb-2 form-control-solid', 
                'placeholder' => "Chiffre d'affaire"],
            ])
            ->add('soldeCloture', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Solde de cloture',
                'required' => true,
                'attr' => [
                'required'=>true, 
                'readonly'=>true,
                'class'=>'form-control mb-2 form-control-solid', 
                'placeholder' => '0'],
            ])
            ->add('monnaieCaisses', CollectionType::class, [
                'required' => false,
                'entry_type' => MonnaieCaisseType::class,
                'entry_options' => [
                'label' => false],
                'required'=>true,
                'label' => false,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                //'data'=>[]
            ])
           ->add('personnelCaisses', CollectionType::class, [
                'required' => false,
                'entry_type' => PersonnelCaissesType::class,
                'entry_options' => ['label' => false],
                'label' => false,
                'required'=>true,
                'allow_add' => true,
                'allow_delete' => true,
                'by_reference' => false,
                //'data'=>[]
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Caisse::class,
        ]);
    }
}
