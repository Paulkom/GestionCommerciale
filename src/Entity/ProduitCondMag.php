<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\ProduitCondMagRepository;
use Gedmo\Timestampable\Traits\TimestampableEntity;
use App\AjaxifySearch\Annotation\AjaxifySearch;

/**
 * @ORM\Entity(repositoryClass=ProduitCondMagRepository::class)
 * @ORM\HasLifecycleCallbacks
 * @AjaxifySearch(
 *     alias = "prodCondMag",
 *     itemTemplate = "ajaxify/produitcondmag/item.html.twig",
 *     relations = { "produitConditionnement", "magasin" },
 *     searchables = {
 *          "qteStockMag", "produit.refProd", "famille.libelleFamille", "magasin.codeMag", "magasin.nomMag",
 *          "produit.nomProd", "conditionnement.codeCond", "conditionnement.libelleCond"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class ProduitCondMag
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=Magasin::class, inversedBy="produitCondMags")
     * @ORM\JoinColumn(nullable=false)
     */
    private $magasin;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $qteStockMag;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitConditionnement::class, inversedBy="produitCondMags")
     * @ORM\JoinColumn(nullable=false)
     */
    private $produitConditionnement;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondSortieMag::class, mappedBy="prodCondMag")
     */
    private $produitCondSortieMags;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="produitCondMags")
     * @ORM\JoinColumn(nullable=true)
     */
    private $pointVente;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\OneToMany(targetEntity=ProduitDetacher::class, mappedBy="produitCondMag")
     */
    private $produitDetachers;

    public function __construct()
    {
        $this->produitCondSortieMags = new ArrayCollection();
        $this->produitDetachers = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
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

    public function getQteStockMag(): ?string
    {
        return $this->qteStockMag;
    }

    public function setQteStockMag(string $qteStockMag): self
    {
        $this->qteStockMag = $qteStockMag;
        return $this;
    }

    public function getProduitConditionnement(): ?ProduitConditionnement
    {
        return $this->produitConditionnement;
    }

    public function setProduitConditionnement(?ProduitConditionnement $produitConditionnement): self
    {
        $this->produitConditionnement = $produitConditionnement;
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
            $produitCondSortieMag->setProdCondMag($this);
        }

        return $this;
    }

    public function removeProduitCondSortieMag(ProduitCondSortieMag $produitCondSortieMag): self
    {
        if ($this->produitCondSortieMags->removeElement($produitCondSortieMag)) {
            // set the owning side to null (unless already changed)
            if ($produitCondSortieMag->getProdCondMag() === $this) {
                $produitCondSortieMag->setProdCondMag(null);
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


    public function getEstSup(): ?bool
    {
        return $this->estSup;
    }

    public function setEstSup(?bool $estSup): self
    {
        $this->estSup = $estSup;

        return $this;
    }

    /**
     * @return Collection<int, ProduitDetacher>
     */
    public function getProduitDetachers(): Collection
    {
        return $this->produitDetachers;
    }

    public function addProduitDetacher(ProduitDetacher $produitDetacher): self
    {
        if (!$this->produitDetachers->contains($produitDetacher)) {
            $this->produitDetachers[] = $produitDetacher;
            $produitDetacher->setProduitCondMag($this);
        }

        return $this;
    }

    public function removeProduitDetacher(ProduitDetacher $produitDetacher): self
    {
        if ($this->produitDetachers->removeElement($produitDetacher)) {
            // set the owning side to null (unless already changed)
            if ($produitDetacher->getProduitCondMag() === $this) {
                $produitDetacher->setProduitCondMag(null);
            }
        }

        return $this;
    }
    public function __toString()
    {
        return $this->getProduitConditionnement()->getProduit()->getNomProd() . ' ['. $this->getProduitConditionnement()->getConditionnement()->getLibelleCond().']';
    }
    
}
