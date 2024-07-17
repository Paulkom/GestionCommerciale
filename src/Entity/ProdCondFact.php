<?php

namespace App\Entity;

use App\Repository\ProdCondFactRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ProdCondFactRepository::class)
 */
class ProdCondFact
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitConditionnement::class, inversedBy="prodCondFacts")
     */
    private $produit;

    /**
     * @ORM\ManyToOne(targetEntity=Facture::class, inversedBy="prodCondFacts")
     */
    private $facture;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0)
     */
    private $prix;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0)
     */
    private $montant;

    /**
     * @ORM\Column(type="integer")
     */
    private $qtite;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitCondComClit::class, inversedBy="prodCondFacts",cascade={"persist"})
     */
    private $produitComClit;

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

    public function getFacture(): ?Facture
    {
        return $this->facture;
    }

    public function setFacture(?Facture $facture): self
    {
        $this->facture = $facture;
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

    public function getMontant(): ?string
    {
        return $this->montant;
    }

    public function setMontant(string $montant): self
    {
        $this->montant = $montant;

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

    public function getProduitComClit(): ?ProduitCondComClit
    {
        return $this->produitComClit;
    }

    public function setProduitComClit(?ProduitCondComClit $produitComClit): self
    {
        $this->produitComClit = $produitComClit;

        return $this;
    }
}
