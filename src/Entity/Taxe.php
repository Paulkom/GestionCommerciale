<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use App\Repository\TaxeRepository;
use App\Entity\Traits\Timestampable;

/**
 * @ORM\Entity(repositoryClass=TaxeRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Taxe
{
    use Timestampable;

    CONST DEDUCTIBLE = 0;
    CONST COLLECTEE  = 1;

    CONST POURCENTAGE = 0;
    CONST MONTANT     = 1;
    CONST QUANTITE    = 2;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $libelle;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $appellation;

    /**
     * @ORM\ManyToOne(targetEntity=TypeTaxe::class, inversedBy="taxes")
     * @ORM\JoinColumn(nullable=true)
     */
    private $typeTaxe;

    /**
     * @ORM\Column(type="integer")
     */
    private $typeTaux;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $taux;

    /**
     * @ORM\Column(type="integer")
     */
    private $sens;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $codeTaxe;

    /**
     * @ORM\OneToMany(targetEntity=GroupeTaxe::class, mappedBy="tauxGr")
     */
    private $groupeTaxes;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="taxes",cascade={"persist"})
     */
    private $pointVente;

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
        $this->groupeTaxes = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLibelle(): ?string
    {
        return $this->libelle;
    }

    public function setLibelle(string $libelle): self
    {
        $this->libelle = $libelle;

        return $this;
    }

    public function getAppellation(): ?string
    {
        return $this->appellation;
    }

    public function setAppellation(string $appellation): self
    {
        $this->appellation = $appellation;

        return $this;
    }

    public function getTypeTaxe(): ?TypeTaxe
    {
        return $this->typeTaxe;
    }

    public function setTypeTaxe(?TypeTaxe $typeTaxe): self
    {
        $this->typeTaxe = $typeTaxe;

        return $this;
    }

    public function getTypeTaux(): ?int
    {
        $result = '';
        if($this->typeTaux === self::POURCENTAGE)
            $result = '%';
        else if($this->typeTaux === self::MONTANT)
            $result = 'Montant';
        else if($this->typeTaux === self::QUANTITE)
            $result = 'Quantité';

        return $this->typeTaux;
    }

    public function setTypeTaux(int $typeTaux): self
    {
        $this->typeTaux = $typeTaux;

        return $this;
    }

    public function getTaux(): ?string
    {
        return $this->taux;
    }

    public function setTaux(?string $taux): self
    {
        $this->taux = $taux;

        return $this;
    }

    public function getSens(): ?int
    {
        $result = '';
        if($this->sens === self::DEDUCTIBLE)
            $result = 'Déductible';
        else if($this->sens === self::COLLECTEE)
            $result = 'Collectée';

        return $this->sens;
    }

    public function setSens(int $sens): self
    {
        $this->sens = $sens;

        return $this;
    }

    public function getCodeTaxe(): ?string
    {
        return $this->codeTaxe;
    }

    public function setCodeTaxe(string $codeTaxe): self
    {
        $this->codeTaxe = $codeTaxe;

        return $this;
    }

    /**
     * @return Collection<int, GroupeTaxe>
     */
    public function getGroupeTaxes(): Collection
    {
        return $this->groupeTaxes;
    }

    public function addGroupeTax(GroupeTaxe $groupeTax): self
    {
        if (!$this->groupeTaxes->contains($groupeTax)) {
            $this->groupeTaxes[] = $groupeTax;
            $groupeTax->setTauxGr($this);
        }

        return $this;
    }

    public function removeGroupeTax(GroupeTaxe $groupeTax): self
    {
        if ($this->groupeTaxes->removeElement($groupeTax)) {
            // set the owning side to null (unless already changed)
            if ($groupeTax->getTauxGr() === $this) {
                $groupeTax->setTauxGr(null);
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

}
