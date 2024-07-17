<?php

namespace App\EventListener;

use App\Entity\CompteBanque;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\FormInterface;

class UpdateTransacFieldsListener implements EventSubscriberInterface {

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
        $form = $event->getForm();
        $data = $event->getData();
        $compteBanque = $this->em->getRepository(CompteBanque::class)->find($data['compteBanque']);
        $this->addElements($form, $compteBanque);
    }

    function onPreSetData(FormEvent $event)
    {
        $data = $event->getData();
        $form = $event->getForm();
        $compteBanque = $data != null && $data->getCompteBanque() ? $data->getCompteBanque() : null;
        $this->addElements($form, $compteBanque);
    }

    protected function addElements(FormInterface $form, CompteBanque $compteBanque = null, $options = [])
    {
        $fieldOptions = [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Compte bancaire',
            'required' => true,
            'class' => CompteBanque::class,
            'placeholder' => 'Sélectionnez un compte...',
            'attr' => [
                'required' => true,
                'data-control' => "select2",
                'class' => 'form-select'
            ],
        ];

        if($compteBanque !== null)
            $fieldOptions['data'] = $compteBanque;

        // 4. Ajouter l'élément CompteBanque
        $form->add('compteBanque', EntityType::class, $fieldOptions);
    }
}