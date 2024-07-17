<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\ProduitCondFactureRepository;

/**
 * @ORM\Entity(repositoryClass=ProduitCondFactureRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class ProduitCondFacture
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitConditionnement::class, inversedBy="produitCondFactures")
     * @ORM\JoinColumn(nullable=false)
     */
    private $produit;

    /**
     * @ORM\ManyToOne(targetEntity=FactureProforma::class, inversedBy="produitCondFactures")
     * @ORM\JoinColumn(nullable=false)
     */
    private $factureProforma;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $qtite;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montant;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $prix;
    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $montantHtAprRse;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $typeRemise;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $valeurRemise;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $remise;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0)
     */
    private $prixHt;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0)
     */
    private $montantTvap;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0)
     */
    private $montantTtcp;


    public function getId(): ?int
    {
        return $this->id;
    }

    public function getProduit(): ?ProduitConditionnement
    {
        return $this->produit;
    }

    public function setProduit(?ProduitConditionnement $produit): self
    {
        $this->produit = $produit;
        return $this;
    }
    
    public function getFactureProforma(): ?FactureProforma
    {
        return $this->factureProforma;
    }

    public function setFactureProforma(?FactureProforma $factureProforma): self
    {
        $this->factureProforma = $factureProforma;
        return $this;
    }

    public function getQtite(): ?int
    {
        return $this->qtite;
    }

    public function setQtite(int $qtite): self
    {
        $this->qtite = $qtite;
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

    public function getPrix(): ?string
    {
        return $this->prix;
    }

    public function setPrix(string $prix): self
    {
        $this->prix = $prix;
        return $this;
    }

    public function getMontantHtAprRse(): ?string
    {
        return $this->montantHtAprRse;
    }

    public function setMontantHtAprRse(?string $montantHtAprRse): self
    {
        $this->montantHtAprRse = $montantHtAprRse;

        return $this;
    }

    public function getTypeRemise(): ?string
    {
        return $this->typeRemise;
    }

    public function setTypeRemise(?string $typeRemise): self
    {
        $this->typeRemise = $typeRemise;

        return $this;
    }

    public function getValeurRemise(): ?string
    {
        return $this->valeurRemise;
    }

    public function setValeurRemise(?string $valeurRemise): self
    {
        $this->valeurRemise = $valeurRemise;

        return $this;
    }

    public function getRemise(): ?string
    {
        return $this->remise;
    }

    public function setRemise(?string $remise): self
    {
        $this->remise = $remise;

        return $this;
    }
    public function __toString()
    {
        return $this->getProduit()->getProduit()->getNomProd() . ' ['. $this->getProduit()->getConditionnement()->getLibelleCond().']'.' '. $this->getProduit()->getPrixDeVente();
    }

    public function getPrixHt(): ?string
    {
        return $this->prixHt;
    }

    public function setPrixHt(string $prixHt): self
    {
        $this->prixHt = $prixHt;

        return $this;
    }

    public function getMontantTvap(): ?string
    {
        return $this->montantTvap;
    }

    public function setMontantTvap(string $montantTvap): self
    {
        $this->montantTvap = $montantTvap;

        return $this;
    }

    public function getMontantTtcp(): ?string
    {
        return $this->montantTtcp;
    }

    public function setMontantTtcp(string $montantTtcp): self
    {
        $this->montantTtcp = $montantTtcp;

        return $this;
    }

}
