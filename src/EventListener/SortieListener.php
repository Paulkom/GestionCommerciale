<?php

namespace App\EventListener;

use App\Entity\Sortie;
use Doctrine\ORM\Event\PreUpdateEventArgs;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use Doctrine\ORM\Mapping as ORM;

class SortieListener {
    /** @ORM\PostPersist */
    public function postPersistHandler(Sortie $entity, LifecycleEventArgs $args)
    {
        $em = $args->getObjectManager();
        $entity = $args->getObject();
//        dd('Post persist : ', $args);
    }

    // -- UPDATE ---------------------------------------------------------

    /** @ORM\PreUpdate */
    public function preUpdateHandler(Sortie $entity, PreUpdateEventArgs $args)
    {
        $em = $args->getObjectManager();
        $entity = $args->getObject();

        // Sortie::$oldMagasinUpdateValue = $args->getOldValue('magasin');
        // Sortie::$newMagasinUpdateValue = $args->getNewValue('magasin');
        // Sortie::$entityUpdateValue = $entity;

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
    public function preRemoveHandler(Sortie $entity, LifecycleEventArgs $args)
    {
        $em = $args->getObjectManager();
        $entity = $args->getObject();
        //dd('preRemove Sortie Mag : ', $entity);
    }
    /** @ORM\PostRemove */
    public function postRemoveHandler(Sortie $entity, LifecycleEventArgs $args)
    {
        $em = $args->getObjectManager();
        $entity = $args->getObject();
        //dd($entity);
    }
}