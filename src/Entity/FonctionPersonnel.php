<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\FonctionPersonnelRepository;

/**
 * @ORM\Entity(repositoryClass=FonctionPersonnelRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class FonctionPersonnel
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=Personnel::class, inversedBy="fonctionPersonnels")
     * @ORM\JoinColumn(nullable=true)
     */
    private $personnel;

    /**
     * @ORM\ManyToOne(targetEntity=Fonction::class, inversedBy="fonctionPersonnels")
     * @ORM\JoinColumn(nullable=true)
     */
    private $fonction;

    /**
     * @ORM\Column(type="boolean")
     */
    private $estActif = false;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $dateDebutFonc;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $dateFinFonc;

    /**
     * @ORM\Column(type="decimal", precision=20, scale=2, nullable=true)
     */
    private $salaireDeBase;
    

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

    public function getEstActif(): ?bool
    {
        return $this->estActif;
    }

    public function setEstActif(bool $estActif): self
    {
        $this->estActif = $estActif;

        return $this;
    }

    public function getDateDebutFonc(): ?\DateTimeInterface
    {
        return $this->dateDebutFonc;
    }

    public function setDateDebutFonc(?\DateTimeInterface $dateDebutFonc): self
    {
        $this->dateDebutFonc = $dateDebutFonc;

        return $this;
    }

    public function getDateFinFonc(): ?\DateTimeInterface
    {
        return $this->dateFinFonc;
    }

    public function setDateFinFonc(?\DateTimeInterface $dateFinFonc): self
    {
        $this->dateFinFonc = $dateFinFonc;

        return $this;
    }

    public function getSalaireDeBase(): ?string
    {
        return $this->salaireDeBase;
    }

    public function setSalaireDeBase(?string $salaireDeBase): self
    {
        $this->salaireDeBase = $salaireDeBase;

        return $this;
    }
}
