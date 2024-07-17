<?php

namespace App\Entity;

use App\Repository\LivraisonMagasinRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=LivraisonMagasinRepository::class)
 */
class LivraisonMagasin
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=Livraison::class, inversedBy="livraisonMagasins",cascade={"persist"})
     * @ORM\JoinColumn(nullable=false)
     */
    private $livraison;

    /**
     * @ORM\ManyToOne(targetEntity=Magasin::class, inversedBy="livraisonMagasins",cascade={"persist"})
     * @ORM\JoinColumn(nullable=false)
     */
    private $magasin;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondMagLiv::class, mappedBy="livraisonMag",cascade={"persist"})
     */
    private $produitCondMagLivs;

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
        $this->produitCondMagLivs = new ArrayCollection();
    }

    
    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLivraison(): ?Livraison
    {
        return $this->livraison;
    }

    public function setLivraison(?Livraison $livraison): self
    {
        $this->livraison = $livraison;
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
     * @return Collection<int, ProduitCondMagLiv>
     */
    public function getProduitCondMagLivs(): Collection
    {
        return $this->produitCondMagLivs;
    }

    public function addProduitCondMagLiv(ProduitCondMagLiv $produitCondMagLiv): self
    {
        if (!$this->produitCondMagLivs->contains($produitCondMagLiv)) {
            $this->produitCondMagLivs[] = $produitCondMagLiv;
            $produitCondMagLiv->setLivraisonMag($this);
        }

        return $this;
    }

    public function removeProduitCondMagLiv(ProduitCondMagLiv $produitCondMagLiv): self
    {
        if ($this->produitCondMagLivs->removeElement($produitCondMagLiv)) {
            // set the owning side to null (unless already changed)
            if ($produitCondMagLiv->getLivraisonMag() === $this) {
                $produitCondMagLiv->setLivraisonMag(null);
            }
        }

        return $this;
    }
}
