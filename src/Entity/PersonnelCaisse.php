<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\PersonnelCaisseRepository;

/**
 * @ORM\Entity(repositoryClass=PersonnelCaisseRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class PersonnelCaisse
{
    use Timestampable;
    
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255,nullable=true)
     */
    private $statut;

    /**
     * @ORM\ManyToOne(targetEntity=Caisse::class, inversedBy="personnelCaisses",cascade={"persist"})
     * @ORM\JoinColumn(nullable=false)
     */
    private $caisse;

    /**
     * @ORM\ManyToOne(targetEntity=Personnel::class, inversedBy="personnelCaisses",cascade={"persist"})
     */
    private $personnel;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStatut(): ?string
    {
        return $this->statut;
    }

    public function setStatut(string $statut): self
    {
        $this->statut = $statut;

        return $this;
    }

    public function getCaisse(): ?Caisse
    {
        return $this->caisse;
    }

    public function setCaisse(?Caisse $caisse): self
    {
        $this->caisse = $caisse;

        return $this;
    }

    public function getPersonnel(): ?Personnel
    {
        return $this->personnel;
    }

    public function setPersonnel(?Personnel $personnel): self
    {
        $this->personnel = $personnel;
        return $this;
    }

    
}
