<?php

namespace App\Entity;

use App\Repository\ProduitCondComClitRepository;
use Doctrine\Common\Collections\ArrayCollection;
use App\Entity\Traits\Timestampable;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ProduitCondComClitRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class ProduitCondComClit
{
    use Timestampable;
    
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitConditionnement::class, inversedBy="produitCondComClits",cascade={"persist"})
     */
    private $produit;

    /**
     * @ORM\ManyToOne(targetEntity=CommandeClient::class, inversedBy="produitCondComClits",cascade={"persist"})
     */
    private $commandeClit;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=3)
     */
    private $qtite;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $taxeSpecifique;

    /**
     * @ORM\Column(type="integer")
     */
    private $montant;

    /**
     * @ORM\Column(type="integer")
     */
    private $prix;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=3, nullable=true)
     */
    private $restAliv;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondMagLiv::class, mappedBy="produitComClit")
     */
    private $produitCondMagLivs;

    /**
     * @ORM\OneToMany(targetEntity=ProdCondFact::class, mappedBy="produitComClit")
     */
    private $prodCondFacts;

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
     * @ORM\ManyToOne(targetEntity=Magasin::class, inversedBy="produitCondComClits")
     */
    private $magasin;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0)
     */
    private $prixHt;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0)
     */
    private $montantTtcp;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0)
     */
    private $montantTvap;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $carton;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $piece;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $libelleProduit;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $groupeTaxeProduit;

    public function __construct()
    {
        $this->produitCondMagLivs = new ArrayCollection();
        $this->prodCondFacts = new ArrayCollection();
    }

    
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

    public function getCommandeClit(): ?CommandeClient
    {
        return $this->commandeClit;
    }

    public function setCommandeClit(?CommandeClient $commandeClit): self
    {
        $this->commandeClit = $commandeClit;

        return $this;
    }
 

    public function getMontant(): ?int
    {
        return $this->montant;
    }

    public function setMontant(int $montant): self
    {
        $this->montant = $montant;
        return $this;
    }

    public function getPrix(): ?int
    {
        return $this->prix;
    }

    public function setPrix(int $prix): self
    {
        $this->prix = $prix;

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
            $produitCondMagLiv->setProduitComClit($this);
        }

        return $this;
    }

    public function removeProduitCondMagLiv(ProduitCondMagLiv $produitCondMagLiv): self
    {
        if ($this->produitCondMagLivs->removeElement($produitCondMagLiv)) {
            // set the owning side to null (unless already changed)
            if ($produitCondMagLiv->getProduitComClit() === $this) {
                $produitCondMagLiv->setProduitComClit(null);
            }
        }

        return $this;
    }

    public function __toString()
    {
        return $this->getProduit()->getProduit()->getNomProd() . ' ['. $this->getProduit()->getConditionnement()->getLibelleCond().']'.' '. $this->getProduit()->getPrixDeVente();
    }

    /**
     * @return Collection<int, ProdCondFact>
     */
    public function getProdCondFacts(): Collection
    {
        return $this->prodCondFacts;
    }

    public function addProdCondFact(ProdCondFact $prodCondFact): self
    {
        if (!$this->prodCondFacts->contains($prodCondFact)) {
            $this->prodCondFacts[] = $prodCondFact;
            $prodCondFact->setProduitComClit($this);
        }

        return $this;
    }

    public function removeProdCondFact(ProdCondFact $prodCondFact): self
    {
        if ($this->prodCondFacts->removeElement($prodCondFact)) {
            // set the owning side to null (unless already changed)
            if ($prodCondFact->getProduitComClit() === $this) {
                $prodCondFact->setProduitComClit(null);
            }
        }

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

    public function getMagasin(): ?Magasin
    {
        return $this->magasin;
    }

    public function setMagasin(?Magasin $magasin): self
    {
        $this->magasin = $magasin;

        return $this;
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

    public function getMontantTtcp(): ?string
    {
        return $this->montantTtcp;
    }

    public function setMontantTtcp(string $montantTtcp): self
    {
        $this->montantTtcp = $montantTtcp;

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

    public function getCarton(): ?string
    {
        return $this->carton;
    }

    public function setCarton(?string $carton): self
    {
        $this->carton = $carton;

        return $this;
    }

    public function getPiece(): ?string
    {
        return $this->piece;
    }

    public function setPiece(?string $piece): self
    {
        $this->piece = $piece;

        return $this;
    }

    public function getLibelleProduit(): ?string
    {
        return $this->libelleProduit;
    }

    public function setLibelleProduit(?string $libelleProduit): self
    {
        $this->libelleProduit = $libelleProduit;

        return $this;
    }

    public function getGroupeTaxeProduit(): ?string
    {
        return $this->groupeTaxeProduit;
    }

    public function setGroupeTaxeProduit(?string $groupeTaxeProduit): self
    {
        $this->groupeTaxeProduit = $groupeTaxeProduit;

        return $this;
    }

    public function getQtite(): ?string
    {
        return $this->qtite;
    }

    public function setQtite(string $qtite): self
    {
        $this->qtite = $qtite;

        return $this;
    }

    public function getTaxeSpecifique(): ?string
    {
        return $this->taxeSpecifique;
    }

    public function setTaxeSpecifique(string $taxeSpecifique): self
    {
        $this->taxeSpecifique = $taxeSpecifique;

        return $this;
    }

    public function getRestAliv(): ?string
    {
        return $this->restAliv;
    }

    public function setRestAliv(?string $restAliv): self
    {
        $this->restAliv = $restAliv;

        return $this;
    }

}
