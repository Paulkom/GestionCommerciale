<?php

namespace App\EventListener;

use App\Entity\Magasin;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\FormInterface;

class UpdateInventaireMagFieldsListener implements EventSubscriberInterface {

    protected $em;
    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
    }

    public static function getSubscribedEvents()
    {
        return array(
            FormEvents::PRE_SET_DATA => 'onPreSetData',
            FormEvents::PRE_SUBMIT   => 'onPreSubmit',
        );
    }

    function onPreSubmit(FormEvent $event)
    {
        $data = $event->getData();
        $magasin = isset($data['magasin']) ? $this->em->getRepository(Magasin::class)->find($data['magasin']) : null;
        $this->addElements($event->getForm(), $magasin);
    }

    function onPreSetData(FormEvent $event)
    {
        $data = $event->getData();
        $magasin = $data !== null && $data->getMagasin() ? $data->getMagasin() : null;
        $this->addElements($event->getForm(), $magasin);
    }

    protected function addElements(
        FormInterface $form,
        Magasin $magasin = null
    )
    {
        $fieldOptions = [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Magasin',
            'class' => Magasin::class,
            'placeholder' => 'Sélectionnez un magasin...',
            'required' => true,
            'choices' => [],
            'attr' => [
                'required' => true,
                'data-control' => "select2",
                'class' => 'form-select'
            ]
        ];

        if($magasin !== null)
        {
            $fieldOptions['data'] = $magasin;
            $fieldOptions['choices'] = [$magasin];
        }

        $form->add('magasin', EntityType::class, $fieldOptions);
    }
}