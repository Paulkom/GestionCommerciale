<?php

namespace App\Entity;

use App\Repository\InventaireMagRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=InventaireMagRepository::class)
 */
class InventaireMag
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=Inventaire::class, inversedBy="inventaireMags")
     * @ORM\JoinColumn(nullable=false)
     */
    private $inventaire;

    /**
     * @ORM\ManyToOne(targetEntity=Magasin::class)
     * @ORM\JoinColumn(nullable=false)
     */
    private $magasin;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondMagInv::class, mappedBy="inventaireMag", cascade={"persist", "remove"})
     */
    private $produitCondMagInvs;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

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
        $this->produitCondMagInvs = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getInventaire(): ?Inventaire
    {
        return $this->inventaire;
    }

    public function setInventaire(?Inventaire $inventaire): self
    {
        $this->inventaire = $inventaire;

        return $this;
    }

    public function getMagasin(): ?Magasin
    {
        return $this->magasin;
    }

    public function setMagasin(?Magasin $magasin): self
    {
        $this->magasin = $magasin;

        return $this;
    }

    /**
     * @return Collection<int, ProduitCondMagInv>
     */
    public function getProduitCondMagInvs(): Collection
    {
        return $this->produitCondMagInvs;
    }

    public function addProduitCondMagInv(ProduitCondMagInv $produitCondMagInv): self
    {
        if (!$this->produitCondMagInvs->contains($produitCondMagInv)) {
            $this->produitCondMagInvs[] = $produitCondMagInv;
            $produitCondMagInv->setInventaireMag($this);
        }

        return $this;
    }

    public function removeProduitCondMagInv(ProduitCondMagInv $produitCondMagInv): self
    {
        if ($this->produitCondMagInvs->removeElement($produitCondMagInv)) {
            // set the owning side to null (unless already changed)
            if ($produitCondMagInv->getInventaireMag() === $this) {
                $produitCondMagInv->setInventaireMag(null);
            }
        }

        return $this;
    }
}
