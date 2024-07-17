<?php

namespace App\EventListener;

use App\Entity\ProduitCondMag;
use App\Entity\ProduitCondSortieMag;
use App\Entity\SortieMag;
use Doctrine\ORM\Event\PreFlushEventArgs;
use Doctrine\ORM\Event\PreUpdateEventArgs;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use Doctrine\ORM\Mapping as ORM;

class ProduitCondSortieMagListener {
    protected $produitCondMag;
    // -- PERSIST --------------------------------------------------------

    /** @ORM\PrePersist */
    public function prePersistHandler(ProduitCondSortieMag $entity, LifecycleEventArgs $args)
    {
    }
    /** @ORM\PostPersist */
    public function postPersistHandler(ProduitCondSortieMag $entity, LifecycleEventArgs $args)
    {
        $em = $args->getObjectManager();
        $entity = $args->getObject();

        $entity->getProduitCond()->setQteStockCond(
            (double)$entity->getProduitCond()->getQteStockCond() - (double)$entity->getQteCondSortie()
        ); //mise a jour du stock dans produit Conditionnement

        $entity->getProduitCond()->getProduit()->setStock(
            (double)$entity->getProduitCond()->getProduit()->getStock() - ((double)$entity->getProduitCond()->getQteCond() * (double)$entity->getQteCondSortie())
        ); //mise a jour du stock dans produit


        $produitCondMag =  $em->getRepository(ProduitCondMag::class)->findOneBy([
            'produitConditionnement' => $entity->getProduitCond(),
            'magasin' => $entity->getSortieMag()->getMagasin()]);
        if($produitCondMag != null){
            $produitCondMag->setQteStockMag((double)$produitCondMag->getQteStockMag() - (double)$entity->getQteCondSortie());
        }else{
            $produitCondMag = new ProduitCondMag;
            $produitCondMag->setQteStockMag((double)$entity->getQteCondSortie());
        }
        $produitCondMag->setMagasin($entity->getSortieMag()->getMagasin());
        $produitCondMag->setProduitConditionnement($entity->getProduitCond());
        $entity->setProdCondMag($produitCondMag);
        
        $em->persist($produitCondMag);

        $em->flush();
    }

    // -- UPDATE ---------------------------------------------------------

    /** @ORM\PreUpdate */
    public function preUpdateHandler(ProduitCondSortieMag $entity, PreUpdateEventArgs $args)
    {
        $em = $args->getObjectManager();
        $entity = $args->getObject();
        $qteStockCond = (double)$entity->getProduitCond()->getQteStockCond();
        // dd($args);
        if ($args->hasChangedField('qteCondSortie')) {
            $oldValue = $args->getOldValue('qteCondSortie');
            $newValue = $args->getNewValue('qteCondSortie');
            
            if($args->hasChangedField('produitCond'))
            {
                //Remettre la quantité stock globale de l'ancien produit conditionnement
                $oldQte = (double)$args->getOldValue('produitCond')->getQteStockCond() + (double)$oldValue;
                $args->getOldValue('produitCond')->setQteStockCond($oldQte);

                //on remet aussi le stock du produit à sa place
                $oldStockProduit = (double)$args->getOldValue('produitCond')->getProduit()->getStock() + ((double)$args->getOldValue('produitCond')->getQteCond() * (double)$oldValue);
                $args->getOldValue('produitCond')->getProduit()->setStock($oldStockProduit);

                //Remettre la quantité stock globale de l'ancien produit conditionnement
                $qteStockCond -= (double)$newValue;

                //Remettre à jour les stocks dans ProduitCondMag
                $oldProduitCondMag =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                    'produitConditionnement' => $args->getOldValue('produitCond'),
                    'magasin' => $entity->getSortieMag()->getMagasin()
                ]);
                $newProduitCondMag =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                    'produitConditionnement' => $args->getNewValue('produitCond'),
                    'magasin' => $entity->getSortieMag()->getMagasin()
                ]);
                $oldProduitCondMag->setQteStockMag((double)$oldProduitCondMag->getQteStockMag() + (double)$oldValue);
                $newProduitCondMag->setQteStockMag((double)$newProduitCondMag->getQteStockMag() - (double)$newValue);

                //le nouveau produit
                $newProduitCondMag->getProduitConditionnement()->getProduit()->setStock(
                    $newProduitCondMag->getProduitConditionnement()->getProduit()->getStock() - 
                    ($newProduitCondMag->getProduitConditionnement()->getQteCond() * (double)$newValue)
                );   
                
            }
            else
            {
                $qteStockCond += (double)$oldValue - (double)$newValue;

                //Remettre à jour les stocks dans ProduitCondMag
                $produitCondMag =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                    'produitConditionnement' => $entity->getProduitCond(),
                    'magasin' => $entity->getSortieMag()->getMagasin()
                ]);
                $produitCondMag->setQteStockMag((double)$produitCondMag->getQteStockMag() + (double)$oldValue - (double)$newValue);
            }
            $entity->getProduitCond()->setQteStockCond($qteStockCond);

        }else{
            $oldAndNewValue = $entity->getQteCondSortie();
            if($args->hasChangedField('produitCond'))
            {
                //Remettre la quantité stock globale de l'ancien produit conditionnement
                $oldQte = (double)$args->getOldValue('produitCond')->getQteStockCond() + (double)$oldAndNewValue;
                $args->getOldValue('produitCond')->setQteStockCond($oldQte);
                

                //on remet aussi le stock du produit à sa place
                $oldStockProduit = (double)$args->getOldValue('produitCond')->getProduit()->getStock() + ((double)$args->getOldValue('produitCond')->getQteCond() * (double)$oldAndNewValue);
                $args->getOldValue('produitCond')->getProduit()->setStock($oldStockProduit);

                //Remettre la quantité stock globale de l'ancien produit conditionnement
                $qteStockCond -= (double)$oldAndNewValue;

                //Remettre à jour les stocks dans ProduitCondMag
                $oldProduitCondMag =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                    'produitConditionnement' => $args->getOldValue('produitCond'),
                    'magasin' => $entity->getSortieMag()->getMagasin()
                ]);
                $newProduitCondMag =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                    'produitConditionnement' => $args->getNewValue('produitCond'),
                    'magasin' => $entity->getSortieMag()->getMagasin()
                ]);
                $oldProduitCondMag->setQteStockMag((double)$oldProduitCondMag->getQteStockMag() + (double)$oldAndNewValue);
                $newProduitCondMag->setQteStockMag((double)$newProduitCondMag->getQteStockMag() - (double)$oldAndNewValue);

                //le nouveau produit
                $newProduitCondMag->getProduitConditionnement()->getProduit()->setStock(
                    $newProduitCondMag->getProduitConditionnement()->getProduit()->getStock() - 
                    ($newProduitCondMag->getProduitConditionnement()->getQteCond() * (double)$oldAndNewValue)
                );   
            }
            $entity->getProduitCond()->setQteStockCond($qteStockCond);
        }
    }
    
    /** @ORM\PostUpdate */
    public function postUpdateHandler(ProduitCondSortieMag $entity, LifecycleEventArgs $args)
    {
        // dd('yes');
        $em = $args->getObjectManager();
        $em->flush();
    }

    // -- REMOVE ---------------------------------------------------------

    /** @ORM\PreRemove */
    public function preRemoveHandler(ProduitCondSortieMag $entity, LifecycleEventArgs $args)
    {
        // $qteStockCond = (double)$entity->getProduitCond()->getQteStockCond() + (double)$entity->getQteCondSortie();
        // $qteStock = (double)$entity->getProduitCond()->getProduit()->getStock() + ($qteStockCond * (double)$entity->getProduitCond()->getQteCond());
        // $qteStockMag = (double)$entity->getProdCondMag()->getQteStockMag() + (double)$entity->getQteCondSortie();

        // $entity->getProduitCond()->setQteStockCond($qteStockCond);
        // $entity->getProduitCond()->getProduit()->setStock($qteStock);
        // $entity->getProdCondMag()->setQteStockMag($qteStockMag);
    }
    /** @ORM\PostRemove */
    public function postRemoveHandler(ProduitCondSortieMag $entity, LifecycleEventArgs $args)
    {
        $em = $args->getObjectManager();
        if($entity !== null && $entity->getId() !== null)
            $em->flush();
    }

    // -- FLUSH ----------------------------------------------------------

    /** @ORM\PreFlush */
    public function preFlushHandler(ProduitCondSortieMag $entity, PreFlushEventArgs $args)
    {
    }

    // -- LOAD ----------------------------------------------------------

    /** @ORM\PostLoad */
    public function postLoadHandler(ProduitCondSortieMag $entity, LifecycleEventArgs $args)
    {

    }
}