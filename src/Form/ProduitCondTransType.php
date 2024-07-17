<?php

namespace App\Form;

use App\Entity\ProduitCondTrans;
use App\Entity\ProduitConditionnement;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\OptionsResolver\OptionsResolver;
use App\EventListener\UpdateProdCondTransFieldsListener;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;

class ProduitCondTransType extends AbstractType
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
            ->add('qteCondTrans', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Qté',
                'required' => true,
                'attr' => [
                    'required'=>true,
                    'class'=>'form-control form-control-solid decimal',
                    'placeholder' => '0'
                ],
            ])
            ->add('prixUnitaire', NumberType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Prix Unitaire',
                'required' => true,
                'attr' => [
                    'required'=>true,
                    'class'=>'form-control form-control-solid decimal',
                    'placeholder' => '0'
                ],
            ])
        ;

        $builder->addEventSubscriber(new UpdateProdCondTransFieldsListener($this->em, $this->requestStack));
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => ProduitCondTrans::class,
        ]);
    }
}
