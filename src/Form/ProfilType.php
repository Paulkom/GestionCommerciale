<?php

namespace App\Form;

use App\Entity\Profil;
use App\Repository\MenuRepository;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Routing\RouterInterface;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;

class ProfilType extends AbstractType
{
    protected $menuRepo;
    public function __construct(MenuRepository $menuRepo) {
        $this->menuRepo = $menuRepo;
    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $routes = array();
        $menus = $this->menuRepo->findBy(['deletedAt' => NULL, 'sousTitre' => NULL]);
        
        foreach ($menus as $menu ) {
            if($menu->getRoles() != []){
                // dd($menu->getRoles()[0]);
                $routes[$menu->getTitre()] = $menu->getRoles();
            }
            //  $routes[$menu->getRoles()] = $menu->getTitre();
        
        }

        // foreach ($allRoutes as $route => $params) {
        //     $routes[$route . ' (' . $params->getHost() . ')'] = $route;
        //     $defaults = $params->getDefaults();
        // }
        
        $builder
            ->add('titre', TextType::class, [
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Désignation',
                'required' => false,
                'attr' => [
                    'class'=>'form-control',
                    'placeholder' => 'Désignation profil'
                ],
            ])
            ->add('roles', ChoiceType::class,[
                'choices' => $routes,
                'label' => 'Route',
                // 'mapped' => false,
                'multiple' => true,
                'placeholder' => 'Sélectionner une route',
                'attr' => [ 
                    'data-control' => 'select2',
                    'data-close-on-select' => "false",
                    'class' => 'js-example-basic-single form-control' 
                ],
                'required' => false,
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Profil::class,
        ]);
    }
}
