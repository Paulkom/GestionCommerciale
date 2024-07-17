<?php

namespace App\Entity;

use App\Repository\ProduitCondSortieMagRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ProduitCondSortieMagRepository::class)
 * @ORM\HasLifecycleCallbacks
 * @ORM\EntityListeners({"App\EventListener\ProduitCondSortieMagListener"})
 */
class ProduitCondSortieMag
{
    public static $entityRemovedValue = null;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=SortieMag::class, inversedBy="produitCondSortieMags")
     * @ORM\JoinColumn(nullable=false)
     */
    private $sortieMag;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitConditionnement::class, inversedBy="produitCondSortieMags")
     * @ORM\JoinColumn(nullable=false)
     */
    private $produitCond;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $qteCondSortie;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $prixUnitaire;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $montant;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitCondMag::class, inversedBy="produitCondSortieMags")
     */
    private $prodCondMag;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;
    

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getSortieMag(): ?SortieMag
    {
        return $this->sortieMag;
    }

    public function setSortieMag(?SortieMag $sortieMag): self
    {
        $this->sortieMag = $sortieMag;

        return $this;
    }

    public function getProduitCond(): ?ProduitConditionnement
    {
        return $this->produitCond;
    }

    public function setProduitCond(?ProduitConditionnement $produitCond): self
    {
        $this->produitCond = $produitCond;

        return $this;
    }

    public function getQteCondSortie(): ?string
    {
        return $this->qteCondSortie;
    }

    public function setQteCondSortie(string $qteCondSortie): self
    {
        $this->qteCondSortie = $qteCondSortie;

        return $this;
    }

    public function getPrixUnitaire(): ?string
    {
        return $this->prixUnitaire;
    }

    public function setPrixUnitaire(?string $prixUnitaire): self
    {
        $this->prixUnitaire = $prixUnitaire;

        return $this;
    }

    public function getMontant(): ?string
    {
        return $this->montant;
    }

    public function setMontant(?string $montant): self
    {
        $this->montant = $montant;

        return $this;
    }

    public function getProdCondMag(): ?ProduitCondMag
    {
        return $this->prodCondMag;
    }

    public function setProdCondMag(?ProduitCondMag $prodCondMag): self
    {
        $this->prodCondMag = $prodCondMag;

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
