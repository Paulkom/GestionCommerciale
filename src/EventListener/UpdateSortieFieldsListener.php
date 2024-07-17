<?php

namespace App\EventListener;

use App\Entity\Personnel;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\FormInterface;

class UpdateSortieFieldsListener implements EventSubscriberInterface {

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
        $auteur = $this->em->getRepository(Personnel::class)->find($data['auteur']);
        $this->addElements($form, $auteur);
    }

    function onPreSetData(FormEvent $event)
    {
        $data = $event->getData();
        $form = $event->getForm();
        $auteur = $data->getAuteur() ? $data->getAuteur() : null;
        $this->addElements($form, $auteur);
    }

    protected function addElements(FormInterface $form, Personnel $auteur = null, $options = [])
    {
        if($auteur !== null)
        {
            $form->add('auteur', EntityType::class, array(
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Personne concernée',
                'required' => true,
                'data' => $auteur,
                'class' => Personnel::class,
                'placeholder' => 'Auteur de la sortie...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ],
            ));
        }
    }
}