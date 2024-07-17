<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\ModelSignatairePersonnelFonctionRepository;

/**
 * @ORM\Entity(repositoryClass=ModelSignatairePersonnelFonctionRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class ModelSignatairePersonnelFonction
{
    use Timestampable;
    
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=Personnel::class, inversedBy="modelSignatairePersonnelFonctions")
     * @ORM\JoinColumn(nullable=false)
     */
    private $personnel;

    /**
     * @ORM\ManyToOne(targetEntity=Fonction::class, inversedBy="modelSignatairePersonnelFonctions")
     * @ORM\JoinColumn(nullable=false)
     */
    private $fonction;

    /**
     * @ORM\ManyToOne(targetEntity=ModelSignataire::class, inversedBy="modelSignatairePersonnelFonctions")
     * @ORM\JoinColumn(nullable=false)
     */
    private $modelSignataire;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    public function getId(): ?int
    {
        return $this->id;
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

    public function getFonction(): ?Fonction
    {
        return $this->fonction;
    }

    public function setFonction(?Fonction $fonction): self
    {
        $this->fonction = $fonction;

        return $this;
    }

    public function getModelSignataire(): ?ModelSignataire
    {
        return $this->modelSignataire;
    }

    public function setModelSignataire(?ModelSignataire $modelSignataire): self
    {
        $this->modelSignataire = $modelSignataire;

        return $this;
    }

    public function getEstSup(): ?bool
    {
        return $this->estSup;
    }

    public function setEstSup(?bool $estSup): self
    {
        $this->estSup = $estSup;

        return $this;
    }

    
}
