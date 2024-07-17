<?php

namespace App\EventListener;

use App\Entity\ProduitConditionnement;
use Doctrine\ORM\Mapping as ORM;
use App\Entity\ProduitCondMag;
use App\Entity\ProduitCondTrans;
use Doctrine\ORM\Event\PreFlushEventArgs;
use Doctrine\ORM\Event\PreUpdateEventArgs;
use Doctrine\Persistence\Event\LifecycleEventArgs;

class ProduitCondTransListener {
    // -- PERSIST --------------------------------------------------------

    /** @ORM\PrePersist */
    public function prePersistHandler(ProduitCondTrans $entity, LifecycleEventArgs $args)
    {
    }
    /** @ORM\PostPersist */
    public function postPersistHandler(ProduitCondTrans $entity, LifecycleEventArgs $args)
    {
        $em = $args->getObjectManager(); 
        $entity = $args->getObject();

        $produitCondMag1 =  $em->getRepository(ProduitCondMag::class)->findOneBy([
            'produitConditionnement' => $entity->getProduitCond(),
            'magasin' => $entity->getTransfert()->getMagasinTrans1()
        ]);
        $produitCondMag2 =  $em->getRepository(ProduitCondMag::class)->findOneBy([
            'produitConditionnement' => $entity->getProduitCond(),
            'magasin' => $entity->getTransfert()->getMagasinTrans2()
        ]);

        //Magasin 1
        if($produitCondMag1 != null){
            $produitCondMag1->setQteStockMag($produitCondMag1->getQteStockMag() - $entity->getQteCondTrans());
        }
        $produitCondMag1->setMagasin($entity->getTransfert()->getMagasinTrans1());
        $produitCondMag1->setProduitConditionnement($entity->getProduitCond());

        //Magasin 2
        if($produitCondMag2 != null){
            $produitCondMag2->setQteStockMag($produitCondMag2->getQteStockMag() + $entity->getQteCondTrans());
        }
        else
        {
            $produitCondMag2 = new ProduitCondMag;
            $produitCondMag2->setQteStockMag($entity->getQteCondTrans());
        }


        $produitCondMag2->setMagasin($entity->getTransfert()->getMagasinTrans2());
        $produitCondMag2->setProduitConditionnement($entity->getProduitCond());
        
        $em->persist($produitCondMag1);
        $em->persist($produitCondMag2);
        $em->flush();
    }

    // -- UPDATE ---------------------------------------------------------

    /** @ORM\PreUpdate */
    public function preUpdateHandler(ProduitCondTrans $entity, PreUpdateEventArgs $args)
    {
        $em = $args->getObjectManager();
        $entity = $args->getObject();
        if ($args->hasChangedField('qteCondTrans')) {
            $oldValue = $args->getOldValue('qteCondTrans');
            $newValue = $args->getNewValue('qteCondTrans');

            $produitCondMag1 =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                'produitConditionnement' => $entity->getProduitCond(),
                'magasin' => $entity->getTransfert()->getMagasinTrans1()
            ]);
            if($produitCondMag1 != null)
            {
                $produitCondMag1->setQteStockMag((double)$produitCondMag1->getQteStockMag() + (double)$oldValue - (double)$newValue);
                $produitCondMag1->setMagasin($entity->getTransfert()->getMagasinTrans1());
                $produitCondMag1->setProduitConditionnement($entity->getProduitCond());
            }

            $produitCondMag2 =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                'produitConditionnement' => $entity->getProduitCond(),
                'magasin' => $entity->getTransfert()->getMagasinTrans2()
            ]);
            if($produitCondMag2 != null)
            {
                $produitCondMag2->setQteStockMag((double)$produitCondMag2->getQteStockMag() - (double)$oldValue + (double)$newValue);
            }
            else
            {
                $produitCondMag2 = new ProduitCondMag;
                $produitCondMag2->setQteStockMag($entity->getQteCondTrans());
                $produitCondMag2->setMagasin($entity->getTransfert()->getMagasinTrans2());
                $produitCondMag2->setProduitConditionnement($entity->getProduitCond());
            }

        }

        
    }
    /** @ORM\PostUpdate */
    public function postUpdateHandler(ProduitCondTrans $entity, LifecycleEventArgs $args)
    {
        $em = $args->getObjectManager();
        $em->flush();
    }

    // -- REMOVE ---------------------------------------------------------

    /** @ORM\PreRemove */
    public function preRemoveHandler(ProduitCondTrans $entity, LifecycleEventArgs $args)
    {
        $em = $args->getObjectManager();
        dd($entity);
    }
    /** @ORM\PostRemove */
    public function postRemoveHandler(LifecycleEventArgs $args)
    {
    }

    // -- FLUSH ----------------------------------------------------------

    /** @ORM\PreFlush */
    public function preFlushHandler(ProduitCondTrans $entity, PreFlushEventArgs $args)
    {
    }

    // -- LOAD ----------------------------------------------------------

    /** @ORM\PostLoad */
    public function postLoadHandler(ProduitCondTrans $entity, LifecycleEventArgs $args)
    {

    }
}