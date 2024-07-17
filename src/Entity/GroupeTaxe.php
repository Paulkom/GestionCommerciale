<?php

namespace App\Entity;

use App\Repository\GroupeTaxeRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=GroupeTaxeRepository::class)
 */
class GroupeTaxe
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $codeGr;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $libelleGr;

    /**
     * @ORM\ManyToOne(targetEntity=Taxe::class, inversedBy="groupeTaxes")
     * @ORM\JoinColumn(nullable=true)
     */
    private $tauxGr;

    /**
     * @ORM\OneToMany(targetEntity=Produit::class, mappedBy="groupeTaxe")
     */
    private $produits;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="groupeTaxes",cascade={"persist"})
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
        $this->produits = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCodeGr(): ?string
    {
        return $this->codeGr;
    }

    public function setCodeGr(string $codeGr): self
    {
        $this->codeGr = $codeGr;

        return $this;
    }

    public function getLibelleGr(): ?string
    {
        return $this->libelleGr;
    }

    public function setLibelleGr(string $libelleGr): self
    {
        $this->libelleGr = $libelleGr;

        return $this;
    }

    /**
     * @return Collection<int, Produit>
     */
    public function getProduits(): Collection
    {
        return $this->produits;
    }

    public function addProduit(Produit $produit): self
    {
        if (!$this->produits->contains($produit)) {
            $this->produits[] = $produit;
            $produit->setGroupeTaxe($this);
        }

        return $this;
    }

    public function removeProduit(Produit $produit): self
    {
        if ($this->produits->removeElement($produit)) {
            // set the owning side to null (unless already changed)
            if ($produit->getGroupeTaxe() === $this) {
                $produit->setGroupeTaxe(null);
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

    public function getTauxGr(): ?Taxe
    {
        return $this->tauxGr;
    }

    public function setTauxGr(?Taxe $tauxGr): self
    {
        $this->tauxGr = $tauxGr;

        return $this;
    }
}
