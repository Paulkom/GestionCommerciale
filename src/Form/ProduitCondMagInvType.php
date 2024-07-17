<?php

namespace App\Form;

use App\Entity\ProduitCondMagInv;
use App\Entity\ProduitConditionnement;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use App\EventListener\UpdateProduitCondInvFieldsListener;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;

class ProduitCondMagInvType extends AbstractType
{
    protected $em;
    protected $requestStack;
    public function __construct(EntityManagerInterface $em, RequestStack $requestStack)
    {
        $this->em = $em;
        $this->requestStack = $requestStack;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('qteCondStockLog', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Qté Logique',
                'required' => true,
                'attr' => [
                    'required'=>true,
                    'class'=>'form-control form-control-solid decimal',
                    'readonly' => true,
                    'placeholder' => '0'
                ],
            ])
            ->add('qteCondStockPhy', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Qté Physique',
                'required' => true,
                'attr' => [
                    'required'=>true,
                    'class'=>'form-control form-control-solid decimal',
                    'placeholder' => '0'
                ],
            ])
            ->add('ecart', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Ecart',
                'required' => true,
                'attr' => [
                    'required'=>true,
                    'class'=>'form-control form-control-solid',
                    'readonly' => true,
                    'placeholder' => '0'
                ],
            ])
            ->add('estCloturer', HiddenType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Est CLoturer ?',
            ])
            /*->add('produitCondInv', EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Produit',
                'class' => ProduitConditionnement::class,
                'placeholder' => 'Sélectionnez un produit...',
                'required' => true,
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ]
            ])*/
            /*->add('debit')
            ->add('credit')
            ->add('prixUnitaire', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Prix Unitaire',
                'required' => true,
                'attr' => [
                    'required'=>true,
                    'class'=>'form-control form-control-solid',
                    'placeholder' => '0'
                ],
            ])*/
        ;

        $builder->addEventSubscriber(new UpdateProduitCondInvFieldsListener($this->em, $this->requestStack));
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProduitCondMagInv::class,
        ]);
    }
}
