<?php

namespace App\EventListener;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\ProduitConditionnement;
use Doctrine\ORM\Event\PreUpdateEventArgs;
use Doctrine\ORM\Event\PostPersistEventArgs;
use Doctrine\Persistence\Event\LifecycleEventArgs;

class ProduitConditionnementListener {
    /** @ORM\PreUpdate */
    public function preUpdateHandler(ProduitConditionnement $entity, PreUpdateEventArgs $args)
    {
        $em = $args->getObjectManager();
        $entity = $args->getObject();
    }
}