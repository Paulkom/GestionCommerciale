<?php

namespace App\Entity;

use App\Repository\DepenseRepository;
use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use DateTime;

/**
 * @ORM\Entity(repositoryClass=DepenseRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Depense
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $motif;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montant;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $beneficiere;

    /**
     * @ORM\ManyToOne(targetEntity=Caisse::class, inversedBy="depenses")
     */
    private $caisse;

    /**
     * @ORM\ManyToOne(targetEntity=Utilisateur::class, inversedBy="depenses")
     */
    private $user;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="depenses")
     */
    private $pointVente;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=TypeDepense::class, inversedBy="depenses")
     */
    private $typeDepense;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $dateDep;

    public function __construct()
    {
        $this->dateDep= new DateTime('now');
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getMotif(): ?string
    {
        return $this->motif;
    }

    public function setMotif(string $motif): self
    {
        $this->motif = $motif;

        return $this;
    }

    public function getMontant(): ?string
    {
        return $this->montant;
    }

    public function setMontant(string $montant): self
    {
        $this->montant = $montant;

        return $this;
    }

    public function getBeneficiere(): ?string
    {
        return $this->beneficiere;
    }

    public function setBeneficiere(string $beneficiere): self
    {
        $this->beneficiere = $beneficiere;

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

    public function getUser(): ?Utilisateur
    {
        return $this->user;
    }

    public function setUser(?Utilisateur $user): self
    {
        $this->user = $user;

        return $this;
    }

    public function getPointVente(): ?PointDeVente
    {
        return $this->pointVente;
    }

    public function setPointVente(?PointDeVente $pointVente): self
    {
        $this->pointVente = $pointVente;

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

    public function getTypeDepense(): ?TypeDepense
    {
        return $this->typeDepense;
    }

    public function setTypeDepense(?TypeDepense $typeDepense): self
    {
        $this->typeDepense = $typeDepense;

        return $this;
    }

    public function getDateDep(): ?\DateTimeInterface
    {
        return $this->dateDep;
    }

    public function setDateDep(?\DateTimeInterface $dateDep): self
    {
        $this->dateDep = $dateDep;

        return $this;
    }
}
