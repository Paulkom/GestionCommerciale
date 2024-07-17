<?php

namespace App\Form;

use App\Entity\Personnel;
use App\Entity\PersonnelCaisse;
use App\Repository\PersonnelRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Security\Core\Security;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;

class PersonnelCaissesType extends AbstractType
{
    private Security $security;
    private $em;
    public function __construct(EntityManagerInterface $em,Security $security){
        $this->security = $security;
        $this->em = $em;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            // ->add('statut',TextType::class, [
            //     'label_attr' => ['class' => 'form-label'],
            //     'label' => 'Etatut',
            //     'required' => true,
            //     'attr' => ['required'=>true, 
            //     'class'=>'form-control mb-2', 
            //     'placeholder' => 'Entrer le statut'],
            // ])
            ->add('personnel', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Personnel',
                'class' => Personnel::class,
                'placeholder' => 'Selectionnez un personnel',
                'query_builder' => function(PersonnelRepository $pr){
                   return  $qb = $this->em->createQueryBuilder()
                   ->select('p')
                   ->from('App\\Entity\\Personnel','p')
                   ->where('p.deletedAt IS NULL')
                   ->andWhere('p.id != :val')
                   ->setParameter('val', $this->security->getUser()->getPersonnel()->getId())
                   ;
                },
                'attr' => [
                    'required' => true, 
                    'data-control' => "select2",
                    'class' => 'form-control form-select personnel',
                    //'data-placeholder' => 'Entrer un utilisateur',
                    //'data-dropdown-parent'=> '#kt_modal_add_caisse'
                ],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => PersonnelCaisse::class,
        ]);
    }
}
