<?php

namespace App\EventListener;

use App\Entity\ProduitCondMag;
use App\Entity\ProduitCondSortieMag;
use App\Entity\SortieMag;
use Doctrine\ORM\Event\PreUpdateEventArgs;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use Doctrine\ORM\Mapping as ORM;

class SortieMagListener {
    /** @ORM\PostPersist */
    public function postPersistHandler(SortieMag $entity, LifecycleEventArgs $args)
    {
        $em = $args->getObjectManager();
        $entity = $args->getObject();
//        dd('Post persist : ', $args);
    }

    // -- UPDATE ---------------------------------------------------------

    /** @ORM\PreUpdate */
    public function preUpdateHandler(SortieMag $entity, PreUpdateEventArgs $args)
    {
        $em = $args->getObjectManager();
        $entity = $args->getObject();

        SortieMag::$oldMagasinUpdateValue = $args->getOldValue('magasin');
        SortieMag::$newMagasinUpdateValue = $args->getNewValue('magasin');
        SortieMag::$entityUpdateValue = $entity;

        dd('yeso');

        /*$produitCondMag = $em->getRepository(ProduitCondMag::class)->findOneBy([
            'produitConditionnement' => ProduitCondSortieMag::$entityRemovedValue->getProduitCond(),
            'magasin' => $args->getOldValue('magasin')
        ]);
        if($produitCondMag != null)
        {
            $produitCondMag->setQteStockMag(
                (double)$produitCondMag->getQteStockMag() + (double)ProduitCondSortieMag::$entityRemovedValue->getQteCondSortie()
            );
        }
        ProduitCondSortieMag::$entityRemovedValue->setSortieMag((clone $entity)->setMagasin(SortieMag::$oldMagasinUpdateValue));*/

        //dd('preUpdate Sortie Mag : ', ProduitCondSortieMag::$entityRemovedValue);
    }

    /** @ORM\PreRemove */
    public function preRemoveHandler(SortieMag $entity, LifecycleEventArgs $args)
    {
        $em = $args->getObjectManager();
        $entity = $args->getObject();
        //dd('preRemove Sortie Mag : ', $entity);
    }
    /** @ORM\PostRemove */
    public function postRemoveHandler(SortieMag $entity, LifecycleEventArgs $args)
    {
        $em = $args->getObjectManager();
        $entity = $args->getObject();
        //dd($entity);
    }
}