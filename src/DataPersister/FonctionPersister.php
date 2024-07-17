<?php

namespace App\DataPersister;

use App\Entity\Fonction;
use ApiPlatform\Core\DataPersister\DataPersisterInterface;
use App\Repository\PointDeVenteRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class FonctionPersister implements DataPersisterInterface
{
    private $em;
    private $pvr;
    public function __construct(EntityManagerInterface $em, PointDeVenteRepository $pvr)
    {
        $this->em = $em;
        $this->pvr = $pvr;
    }

    public function supports($data): bool
    {
        return $data instanceof Fonction;
    }

    public function persist($data){

        $pv = $this->pvr->find(1);
        $data->setCreatedAt(new \DateTime());
        $data->setPointVente($pv);

        $this->em->persist($data);
        $this->em->flush();
        
    }

    public function remove($data){


    }

}