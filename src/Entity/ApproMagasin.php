<?php

namespace App\Entity;

use App\Repository\ApproMagasinRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ApproMagasinRepository::class)
 */
class ApproMagasin
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=Approvisionnement::class, inversedBy="approMagasins")
     * @ORM\JoinColumn(nullable=false)
     */
    private $approvisionnement;

    /**
     * @ORM\ManyToOne(targetEntity=Magasin::class, inversedBy="approMagasins")
     * @ORM\JoinColumn(nullable=false)
     */
    private $magasin;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondApproMag::class, mappedBy="approMagasin", orphanRemoval=true, cascade={"persist"})
     */
    private $produitCondApproMags;

    public function __construct()
    {
        $this->produitCondApproMags = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getApprovisionnement(): ?Approvisionnement
    {
        return $this->approvisionnement;
    }

    public function setApprovisionnement(?Approvisionnement $approvisionnement): self
    {
        $this->approvisionnement = $approvisionnement;

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
     * @return Collection<int, ProduitCondApproMag>
     */
    public function getProduitCondApproMags(): Collection
    {
        return $this->produitCondApproMags;
    }

    public function addProduitCondApproMag(ProduitCondApproMag $produitCondApproMag): self
    {
        if (!$this->produitCondApproMags->contains($produitCondApproMag)) {
            $this->produitCondApproMags[] = $produitCondApproMag;
            $produitCondApproMag->setApproMagasin($this);
        }

        return $this;
    }

    public function removeProduitCondApproMag(ProduitCondApproMag $produitCondApproMag): self
    {
        if ($this->produitCondApproMags->removeElement($produitCondApproMag)) {
            // set the owning side to null (unless already changed)
            if ($produitCondApproMag->getApproMagasin() === $this) {
                $produitCondApproMag->setApproMagasin(null);
            }
        }

        return $this;
    }
}
