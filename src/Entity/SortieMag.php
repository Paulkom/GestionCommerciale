<?php

namespace App\Entity;

use App\Repository\SortieMagRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=SortieMagRepository::class)
 * @ORM\EntityListeners({"App\EventListener\SortieMagListener"})
 */
class SortieMag
{
    public static $oldMagasinUpdateValue = null;
    public static $newMagasinUpdateValue = null;
    public static $entityUpdateValue = null;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=Sortie::class, inversedBy="sortieMags")
     * @ORM\JoinColumn(nullable=false)
     */
    private $sortie;

    /**
     * @ORM\ManyToOne(targetEntity=Magasin::class, inversedBy="sortieMags")
     * @ORM\JoinColumn(nullable=false)
     */
    private $magasin;

    /**
     * @ORM\OneToMany(
     *     targetEntity=ProduitCondSortieMag::class,
     *     mappedBy="sortieMag",
     *     cascade={"persist", "remove"},
     *     orphanRemoval=true
     *     )
     */
    private $produitCondSortieMags;

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
        $this->produitCondSortieMags = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getSortie(): ?Sortie
    {
        return $this->sortie;
    }

    public function setSortie(?Sortie $sortie): self
    {
        $this->sortie = $sortie;

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
     * @return Collection<int, ProduitCondSortieMag>
     */
    public function getProduitCondSortieMags(): Collection
    {
        return $this->produitCondSortieMags;
    }

    public function addProduitCondSortieMag(ProduitCondSortieMag $produitCondSortieMag): self
    {
        if (!$this->produitCondSortieMags->contains($produitCondSortieMag)) {
            $this->produitCondSortieMags[] = $produitCondSortieMag;
            $produitCondSortieMag->setSortieMag($this);
        }

        return $this;
    }

    public function removeProduitCondSortieMag(ProduitCondSortieMag $produitCondSortieMag): self
    {
        if ($this->produitCondSortieMags->removeElement($produitCondSortieMag)) {
            // set the owning side to null (unless already changed)
            if ($produitCondSortieMag->getSortieMag() === $this) {
                $produitCondSortieMag->setSortieMag(null);
            }
        }

        return $this;
    }
}
