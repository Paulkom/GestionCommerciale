<?php

namespace App\EventListener;

use App\Entity\Produit;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class ProduitListener {
    // -- PERSIST --------------------------------------------------------

    private SessionInterface $session;
    public function __construct(SessionInterface $session)
    {
        $this->session = $session;
    }
    


}