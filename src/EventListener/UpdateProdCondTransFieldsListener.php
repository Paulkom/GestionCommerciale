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

class UpdateProdCondTransFieldsListener implements EventSubscriberInterface {

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
        $request = $this->requestStack->getMainRequest();
        $alldata = $request->request->all()['transfert'] ?? null;
        $magasinTrans1 = isset($alldata['magasinTrans1']) ? $this->em->getRepository(Magasin::class)->find($alldata['magasinTrans1']) : null;
        $this->addElements($event->getForm(), $magasinTrans1);
    }

    function onPreSetData(FormEvent $event)
    {
        $data = $event->getData();
        $request = $this->requestStack->getMainRequest();
        $alldata = $request->request->all()['transfert'] ?? null;
        $magasinTrans1 = isset($alldata['magasinTrans1']) ? $this->em->getRepository(Magasin::class)->find($alldata['magasinTrans1']) : null;
        $produitCond = $data !== null && $data->getProduitCond() ? $data->getProduitCond() : null;
        $this->addElements($event->getForm(), $magasinTrans1, $produitCond, $data);
    }

    protected function addElements(
        FormInterface $form,
        Magasin $magasinTrans1 = null,
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

        if($magasinTrans1 !== null)
        {
            $results = $this->em->createQueryBuilder()
                ->select("p")
                ->from("App\Entity\ProduitConditionnement", "p")
                ->innerJoin("p.produitCondMags", "pm")
                ->innerJoin("pm.magasin", "m")
                ->where("m.id = " . $magasinTrans1->getId())
                ->getQuery()
                ->getResult();
            $fieldOptions['choices'] = $results;
        }

        if($produitConditionnement !== null)
        {
            $fieldOptions['choices'] = [$produitConditionnement];
            if($data !== null)
            {
                $magasinTrans1 = $data->getTransfert()->getMagasinTrans1();
                $prodCondMag1 = $this->em->getRepository(ProduitCondMag::class)->findOneBy([
                    'produitConditionnement' => $produitConditionnement,
                    'magasin' => $magasinTrans1,
                ]);

                $fieldOptions['choice_attr'] = function (ProduitConditionnement $produitConditionnement) use ($prodCondMag1, $data) {
                    return [
                        'data-prix-vente'   => $data->getPrixUnitaire(),
                        'data-stock-mag'    => $prodCondMag1->getQteStockMag(),
                        'data-stock-global' => $produitConditionnement->getQteStockCond(),
                        'optionValue'       => 'prodCondTans-'.$produitConditionnement->getId(),
                    ];
                };
            }
        }

        $form->add('produitCond', EntityType::class, $fieldOptions);
    }
}