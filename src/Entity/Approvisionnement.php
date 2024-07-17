<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use Doctrine\Common\Collections\Collection;
use App\Repository\ApprovisionnementRepository;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=ApprovisionnementRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Approvisionnement
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="datetime")
     */
    private $dateAppro;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $montantTotal;

    /**
     * @ORM\ManyToOne(targetEntity=CommandeFrs::class, inversedBy="approvisionnements")
     */
    private $commandeFrs;

    /**
     * @ORM\OneToMany(targetEntity=ApproMagasin::class, mappedBy="approvisionnement", orphanRemoval=true, cascade={"persist"})
     */
    private $approMagasins;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="approvisionnements",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\ManyToOne(targetEntity=Fournisseur::class, inversedBy="approvisionnements")
     */
    private $fournisseur;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $reference;

    /**
     * @ORM\ManyToOne(targetEntity=ModelSignataire::class, inversedBy="approvisionnements")
     */
    private $modelSignataire;

    public function getEstSup(): ?bool
    {
        return $this->estSup;
    }

    public function setEstSup(?bool $estSup): self
    {
        $this->estSup = $estSup;

        return $this;
    }    

    public function __construct()
    {
        $this->dateAppro = new \DateTime();
        $this->approMagasins = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateAppro(): ?\DateTimeInterface
    {
        return $this->dateAppro;
    }

    public function setDateAppro(\DateTimeInterface $dateAppro): self
    {
        $this->dateAppro = $dateAppro;

        return $this;
    }

    public function getMontantTotal(): ?string
    {
        return $this->montantTotal;
    }

    public function setMontantTotal(string $montantTotal): self
    {
        $this->montantTotal = $montantTotal;

        return $this;
    }

    public function getCommandeFrs(): ?CommandeFrs
    {
        return $this->commandeFrs;
    }

    public function setCommandeFrs(?CommandeFrs $commandeFrs): self
    {
        $this->commandeFrs = $commandeFrs;

        return $this;
    }

    /**
     * @return Collection<int, ApproMagasin>
     */
    public function getApproMagasins(): Collection
    {
        return $this->approMagasins;
    }

    public function addApproMagasin(ApproMagasin $approMagasin): self
    {
        if (!$this->approMagasins->contains($approMagasin)) {
            $this->approMagasins[] = $approMagasin;
            $approMagasin->setApprovisionnement($this);
        }

        return $this;
    }

    public function removeApproMagasin(ApproMagasin $approMagasin): self
    {
        if ($this->approMagasins->removeElement($approMagasin)) {
            // set the owning side to null (unless already changed)
            if ($approMagasin->getApprovisionnement() === $this) {
                $approMagasin->setApprovisionnement(null);
            }
        }

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

    public function getFournisseur(): ?Fournisseur
    {
        return $this->fournisseur;
    }

    public function setFournisseur(?Fournisseur $fournisseur): self
    {
        $this->fournisseur = $fournisseur;

        return $this;
    }

    public function getReference(): ?string
    {
        return $this->reference;
    }

    public function setReference(?string $reference): self
    {
        $this->reference = $reference;

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

}
