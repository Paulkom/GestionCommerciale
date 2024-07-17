<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\FamilleRepository;
use Doctrine\Common\Collections\Collection;
use App\AjaxifySearch\Annotation\AjaxifySearch;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=FamilleRepository::class)
 * @ORM\HasLifecycleCallbacks
 *  * @AjaxifySearch(
 *     alias = "famille",
 *     itemTemplate = "famille/partials/item.html.twig",
 *     searchables = {
 *          "codeFamille", "libelleFamille"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class Famille
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $codeFamille;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $libelleFamille;

    /**
     * @ORM\ManyToOne(targetEntity=Famille::class, inversedBy="familles")
     */
    private $familleParent;

    /**
     * @ORM\OneToMany(targetEntity=Famille::class, mappedBy="familleParent", fetch="EAGER")
     */
    private $familles;

    /**
     * @ORM\OneToMany(targetEntity=Produit::class, mappedBy="famille", orphanRemoval=true, fetch="EAGER")
     */
    private $produits;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="familles",cascade={"persist"})
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
        $this->familles = new ArrayCollection();
        $this->produits = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCodeFamille(): ?string
    {
        return $this->codeFamille;
    }

    public function setCodeFamille(string $codeFamille): self
    {
        $this->codeFamille = $codeFamille;
        return $this;
    }

    public function getLibelleFamille(): ?string
    {
        return $this->libelleFamille;
    }

    public function setLibelleFamille(string $libelleFamille): self
    {
        $this->libelleFamille = $libelleFamille;

        return $this;
    }

    public function getFamilleParent(): ?self
    {
        return $this->familleParent;
    }

    public function setFamilleParent(?self $familleParent): self
    {
        $this->familleParent = $familleParent;

        return $this;
    }

    /**
     * @return Collection<int, self>
     */
    public function getFamilles(): Collection
    {
        return $this->familles;
    }

    public function addFamille(self $famille): self
    {
        if (!$this->familles->contains($famille)) {
            $this->familles[] = $famille;
            $famille->setFamilleParent($this);
        }

        return $this;
    }

    public function removeFamille(self $famille): self
    {
        if ($this->familles->removeElement($famille)) {
            // set the owning side to null (unless already changed)
            if ($famille->getFamilleParent() === $this) {
                $famille->setFamilleParent(null);
            }
        }

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
            $produit->setFamille($this);
        }

        return $this;
    }

    public function removeProduit(Produit $produit): self
    {
        if ($this->produits->removeElement($produit)) {
            // set the owning side to null (unless already changed)
            if ($produit->getFamille() === $this) {
                $produit->setFamille(null);
            }
        }

        return $this;
    }

    public function __toString()
    {
        return $this->libelleFamille . ' [' . $this->codeFamille . ']';
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
