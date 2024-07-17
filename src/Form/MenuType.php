<?php

namespace App\Form;

use App\Entity\Menu;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Routing\RouterInterface;

class MenuType extends AbstractType
{
    protected $router;
    public function __construct(RouterInterface $router) {
        $this->router = $router;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $collection = $this->router->getRouteCollection();
        $allRoutes = $collection->all();
        $routes = array();
        foreach ($allRoutes as $route => $params) {
            $routes[$route . ' (' . $params->getPath() . ')'] = $route;
        }

        $builder
            ->add('sousTitre', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Sous Titre',
                'required' => false,
                'attr' => ['required'=>false,
                    'class'=>'form-control mb-2',
                    'placeholder' => 'Sous Titre...'],
            ])
            ->add('titre', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Titre',
                'required' => true,
                'attr' => ['required'=>true,
                    'class'=>'form-control mb-2',
                    'placeholder' => 'Titre...'],
            ])
            ->add('url', ChoiceType::class, [
                'label_attr' => ['class' => 'form-label'],
                'choices' => $routes,
                'label' => 'Url',
                'required' => false,
                'placeholder'=> 'Url...',
                'attr' => [
                    'required'=>false,
                    'class' => 'form-control form-select',
                    'data-control' => "select2",
                    'data-placeholder' => 'Url...',
                ],
            ])
            ->add('active', CheckboxType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Actif ?',
                'required' => false,
                'attr' => [
                    'class' => 'form-check-input',
                ],
            ])
            ->add('icon', TextareaType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Icon',
                'required' => false,
                'attr' => ['required'=>false,
                    'class'=>'form-control mb-2',
                    'placeholder' => 'Icon...'],
            ])
            ->add('menuSuperieur',EntityType::class, [
                'label_attr' => ['class' => 'form-label'],
                'required' => false,
                'label' => 'Menu Parent',
                'class' => Menu::class,
                'choice_label'=> 'titre',
                'placeholder'=> 'Sélectionnez un menu',
                'attr' => [
                    'required'=>false,
                    'class' => 'form-control form-select',
                    'data-control' => "select2",
                    'data-placeholder' => 'Sélectionnez un menu...',
                ]
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Menu::class,
        ]);
    }
}
