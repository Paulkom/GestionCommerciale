<?php

namespace App\EventListener;

use App\Entity\Magasin;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\FormInterface;

class UpdateTransfertFieldsListener implements EventSubscriberInterface {

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
        $transfert = $event->getData();

        // Search for selected magasinTrans1 and convert it into an Entity
        $magasinTrans1 = $this->em->getRepository(Magasin::class)->find($transfert['magasinTrans1']);

        $this->addElements($form, $magasinTrans1);
    }

    function onPreSetData(FormEvent $event)
    {
        $transfert = $event->getData();
        $form = $event->getForm();

        // When you create a new transfert, the Magasin is always empty
        $magasinTrans1 = $transfert->getMagasinTrans1() ? $transfert->getMagasinTrans1() : null;

        $this->addElements($form, $magasinTrans1);
    }

    protected function addElements(FormInterface $form, Magasin $magasinTrans1 = null, $options = [])
    {
        $repoMag = $this->em->getRepository(Magasin::class);
        if($magasinTrans1 !== null)
        {
            // 4. Ajouter l'élément Magasin1
            $form->add('magasinTrans1', EntityType::class, array(
                'label_attr' => ['class' => 'form-label'],
                'label' => 'Magasin A',
                'required' => true,
                'data' => $magasinTrans1,
                'class' => Magasin::class,
                'placeholder' => 'Sélectionnez un magasin...',
                'attr' => [
                    'required' => true,
                    'data-control' => "select2",
                    'class' => 'form-select'
                ],
            ));
        }

        // MagasinTrans2 empty, unless there is a selected MagasinTrans1 (Edit View)
        $magTrans2 = array();

        // If there is a magasinTrans1 stored in the Transfert entity, load the magasinTrans2 of it
        if ($magasinTrans1) {
            // Fetch magasinTrans2 of the magasinTrans1 if there's a selected magasinTrans1
            $magTrans2 = $repoMag->createQueryBuilder("q")
                ->where("q.id != :mag1Id")
                ->setParameter("mag1Id", $magasinTrans1->getId())
                ->getQuery()
                ->getResult();
        }

        // Add the magasinTrans2 field with the properly data
        $form->add('magasinTrans2', EntityType::class, array(
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Magasin B',
            'required' => true,
            'placeholder' => 'Sélectionnez d\'abord le magasin A...',
            'class' => Magasin::class,
            'choices' => $magTrans2,
            'attr' => [
                'required' => true,
                'data-control' => "select2",
                'class' => 'form-select'
            ],
        ));
    }
}