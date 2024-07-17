<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\InventaireRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;
use App\AjaxifySearch\Annotation\AjaxifySearch;

/**
 * @ORM\Entity(repositoryClass=InventaireRepository::class)
 * @ORM\HasLifecycleCallbacks
 * @AjaxifySearch(
 *     alias = "inventaire",
 *     itemTemplate = "inventaire/partials/item.html.twig",
 *     searchables = {
 *          "dateDebutInv", "dateFinInv"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class Inventaire
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
    private $dateDebutInv;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $dateFinInv;

    /**
     * @ORM\ManyToOne(targetEntity=TypeInventaire::class, inversedBy="inventaires")
     */
    private $typeInv;

    /**
     * @ORM\Column(type="text")
     */
    private $motif;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $totalDebit;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $totalCredit;

    /**
     * @ORM\OneToMany(targetEntity=InventaireMag::class, mappedBy="inventaire", cascade={"persist", "remove"}, orphanRemoval=true)
     */
    private $inventaireMags;

    /**
     * @ORM\ManyToMany(targetEntity=Personnel::class, inversedBy="inventaires")
     */
    private $personnesConcernees;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estCloturer;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="inventaires",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\ManyToOne(targetEntity=ModelSignataire::class, inversedBy="inventaires")
     */
    private $modelSignataire;

    public function __construct()
    {
        $this->inventaireMags = new ArrayCollection();
        $this->personnesConcernees = new ArrayCollection();
        $this->dateDebutInv = new \DateTime();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateDebutInv(): ?\DateTimeInterface
    {
        return $this->dateDebutInv;
    }

    public function setDateDebutInv(\DateTimeInterface $dateDebutInv): self
    {
        $this->dateDebutInv = $dateDebutInv;

        return $this;
    }

    public function getDateFinInv(): ?\DateTimeInterface
    {
        return $this->dateFinInv;
    }

    public function setDateFinInv(?\DateTimeInterface $dateFinInv): self
    {
        $this->dateFinInv = $dateFinInv;

        return $this;
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

    public function getTotalDebit(): ?string
    {
        return $this->totalDebit;
    }

    public function setTotalDebit(?string $totalDebit): self
    {
        $this->totalDebit = $totalDebit;

        return $this;
    }

    public function getTotalCredit(): ?string
    {
        return $this->totalCredit;
    }

    public function setTotalCredit(?string $totalCredit): self
    {
        $this->totalCredit = $totalCredit;

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

    public function getEstCloturer(): ?bool
    {
        return $this->estCloturer;
    }

    public function setEstCloturer(?bool $estCloturer): self
    {
        $this->estCloturer = $estCloturer;

        return $this;
    }

    public function getTypeInv(): ?TypeInventaire
    {
        return $this->typeInv;
    }

    public function setTypeInv(?TypeInventaire $typeInv): self
    {
        $this->typeInv = $typeInv;

        return $this;
    }

    /**
     * @return Collection<int, InventaireMag>
     */
    public function getInventaireMags(): Collection
    {
        return $this->inventaireMags;
    }

    public function addInventaireMag(InventaireMag $inventaireMag): self
    {
        if (!$this->inventaireMags->contains($inventaireMag)) {
            $this->inventaireMags[] = $inventaireMag;
            $inventaireMag->setInventaire($this);
        }

        return $this;
    }

    public function removeInventaireMag(InventaireMag $inventaireMag): self
    {
        if ($this->inventaireMags->removeElement($inventaireMag)) {
            // set the owning side to null (unless already changed)
            if ($inventaireMag->getInventaire() === $this) {
                $inventaireMag->setInventaire(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Personnel>
     */
    public function getPersonnesConcernees(): Collection
    {
        return $this->personnesConcernees;
    }

    public function addPersonnesConcernee(Personnel $personnesConcernee): self
    {
        if (!$this->personnesConcernees->contains($personnesConcernee)) {
            $this->personnesConcernees[] = $personnesConcernee;
        }

        return $this;
    }

    public function removePersonnesConcernee(Personnel $personnesConcernee): self
    {
        $this->personnesConcernees->removeElement($personnesConcernee);

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
