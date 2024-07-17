<?php

namespace App\EventListener;

use App\Entity\Magasin;
use App\Entity\ProduitConditionnement;
use App\Entity\ProduitCondMag;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\Form\FormInterface;
use Symfony\Component\HttpFoundation\RequestStack;

class UpdateProduitCondInvFieldsListener implements EventSubscriberInterface {

    protected $em;
    protected $requestStack;
    public function __construct(EntityManagerInterface $em, RequestStack $requestStack)
    {
        $this->em = $em;
        $this->requestStack = $requestStack;
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
        $produitCond = isset($data['produitCondInv']) ? $this->em->getRepository(ProduitConditionnement::class)->find($data['produitCondInv']) : null;
        $this->addElements($event->getForm(), null, $produitCond);
    }

    function onPreSetData(FormEvent $event)
    {
        $data = $event->getData();
        $produitCond = $data !== null && $data->getProduitCondInv() ? $data->getProduitCondInv() : null;
        $this->addElements($event->getForm(), null, $produitCond, $data);
    }

    protected function addElements(
        FormInterface $form,
        Magasin $magasin = null,
        ProduitConditionnement $produitConditionnement = null,
        $data = null
    )
    {
        $fieldOptions = [
            'label_attr' => ['class' => 'form-label'],
            'label' => 'Produit',
            'class' => ProduitConditionnement::class,
            'placeholder' => 'Sélectionnez un produit...',
            'required' => true,
            'choices' => [],
            'attr' => [
                'required' => true,
                'data-control' => "select2",
                'class' => 'form-select'
            ]
        ];

        if($produitConditionnement !== null)
        {
            $fieldOptions['choices'] = [$produitConditionnement];
            if($data !== null)
            {
                $magasin = $data->getInventaireMag()->getMagasin();
                $prodCondMag = $this->em->getRepository(ProduitCondMag::class)->findOneBy([
                    'produitConditionnement' => $produitConditionnement,
                    'magasin' => $magasin,
                ]);

                $fieldOptions['choice_attr'] = function (ProduitConditionnement $produitConditionnement) use ($prodCondMag, $data) {
                    return [
                        'data-prix-vente'   => $data->getPrixUnitaire(),
                        'data-stock-mag'    => $prodCondMag->getQteStockMag(),
                        'data-stock-global' => $produitConditionnement->getQteStockCond(),
                    ];
                };
            }
        }

        $form->add('produitCondInv', EntityType::class, $fieldOptions);
    }
}