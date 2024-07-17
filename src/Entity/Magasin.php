<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\MagasinRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=MagasinRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Magasin
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
    private $nomMag;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $codeMag;

    /**
     * @ORM\Column(type="boolean")
     */
    private $estPrincipal;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $adresse;

    /**
     * @ORM\ManyToOne(targetEntity=Personnel::class, inversedBy="magasins")
     * @ORM\JoinColumn(nullable=true)
     */
    private $superviseur;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondMag::class, mappedBy="magasin", orphanRemoval=true)
     */
    private $produitCondMags;

    /**
     * @ORM\OneToMany(targetEntity=Transfert::class, mappedBy="magasinTrans1", orphanRemoval=true)
     */
    private $transfertsMag1;

    /**
     * @ORM\OneToMany(targetEntity=Transfert::class, mappedBy="magasinTrans2", orphanRemoval=true)
     */
    private $transfertsMag2;

    // /**
    //  * @ORM\OneToMany(targetEntity=ProduitCondMagLiv::class, mappedBy="magasin", orphanRemoval=true)
    //  */
    // private $produitCondMagLivs;

    /**
     * @ORM\OneToMany(targetEntity=SortieMag::class, mappedBy="magasin", orphanRemoval=true)
     */
    private $sortieMags;

    /**
     * @ORM\OneToMany(targetEntity=LivraisonMagasin::class, mappedBy="magasin")
     */
    private $livraisonMagasins;
    
    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estDefaut;

    /**
     * @ORM\OneToMany(targetEntity=ApproMagasin::class, mappedBy="magasin", orphanRemoval=true)
     */
    private $approMagasins;


    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondComClit::class, mappedBy="magasin")
     */
    private $produitCondComClits;

    /**
     * @ORM\OneToMany(targetEntity=Produit::class, mappedBy="magasinDefaut")
     */
    private $produits;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="magasins",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\OneToMany(targetEntity=Detachement::class, mappedBy="magasin")
     */
    private $detachements;

   
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
        $this->produitCondMags = new ArrayCollection();
        // $this->produitCondMagLivs = new ArrayCollection();
        $this->transfertsMag1 = new ArrayCollection();
        $this->transfertsMag2 = new ArrayCollection();
        $this->sortieMags = new ArrayCollection();
        $this->livraisonMagasins = new ArrayCollection();
        $this->approMagasins = new ArrayCollection();
        $this->produitCondComClits = new ArrayCollection();
        $this->produits = new ArrayCollection();
        $this->detachements = new ArrayCollection();
    }

    public function __toString()
    {
        return $this->getNomMag();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNomMag(): ?string
    {
        return $this->nomMag;
    }

    public function setNomMag(string $nomMag): self
    {
        $this->nomMag = $nomMag;

        return $this;
    }

    public function getCodeMag(): ?string
    {
        return $this->codeMag;
    }

    public function setCodeMag(string $codeMag): self
    {
        $this->codeMag = $codeMag;

        return $this;
    }

    public function getAdresse(): ?string
    {
        return $this->adresse;
    }

    public function setAdresse(string $adresse): self
    {
        $this->adresse = $adresse;

        return $this;
    }

    public function getSuperviseur(): ?Personnel
    {
        return $this->superviseur;
    }

    public function setSuperviseur(?Personnel $superviseur): self
    {
        $this->superviseur = $superviseur;

        return $this;
    }

    /**
     * @return Collection<int, ProduitCondMag>
     */
    public function getProduitCondMags(): Collection
    {
        return $this->produitCondMags;
    }

    public function addProduitCondMag(ProduitCondMag $produitCondMag): self
    {
        if (!$this->produitCondMags->contains($produitCondMag)) {
            $this->produitCondMags[] = $produitCondMag;
            $produitCondMag->setMagasin($this);
        }

        return $this;
    }

    public function removeProduitCondMag(ProduitCondMag $produitCondMag): self
    {
        if ($this->produitCondMags->removeElement($produitCondMag)) {
            // set the owning side to null (unless already changed)
            if ($produitCondMag->getMagasin() === $this) {
                $produitCondMag->setMagasin(null);
            }
        }

        return $this;
    }

    // /**
    //  * @return Collection<int, ProduitCondMagLiv>
    //  */
    // public function getProduitCondMagLivs(): Collection
    // {
    //     return $this->produitCondMagLivs;
    // }

   /* public function addProduitCondMagLiv(ProduitCondMagLiv $produitCondMagLiv): self
    {
        if (!$this->produitCondMagLivs->contains($produitCondMagLiv)) {
            $this->produitCondMagLivs[] = $produitCondMagLiv;
            $produitCondMagLiv->setMagasin($this);
        }

        return $this;
    }

    public function removeProduitCondMagLiv(ProduitCondMagLiv $produitCondMagLiv): self
    {
        if ($this->produitCondMagLivs->removeElement($produitCondMagLiv)) {
            // set the owning side to null (unless already changed)
            if ($produitCondMagLiv->getMagasin() === $this) {
                $produitCondMagLiv->setMagasin(null);
            }
        }

        return $this;
    }
*/
    /**
     * @return Collection<int, Transfert>
     */
    public function getTransfertsMag1(): Collection
    {
        return $this->transfertsMag1;
    }

    public function addTransfertsMag1(Transfert $transfertsMag1): self
    {
        if (!$this->transfertsMag1->contains($transfertsMag1)) {
            $this->transfertsMag1[] = $transfertsMag1;
            $transfertsMag1->setMagasinTrans1($this);
        }

        return $this;
    }

    public function removeTransfertsMag1(Transfert $transfertsMag1): self
    {
        if ($this->transfertsMag1->removeElement($transfertsMag1)) {
            // set the owning side to null (unless already changed)
            if ($transfertsMag1->getMagasinTrans1() === $this) {
                $transfertsMag1->setMagasinTrans1(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Transfert>
     */
    public function getTransfertsMag2(): Collection
    {
        return $this->transfertsMag2;
    }

    public function addTransfertsMag2(Transfert $transfertsMag2): self
    {
        if (!$this->transfertsMag2->contains($transfertsMag2)) {
            $this->transfertsMag2[] = $transfertsMag2;
            $transfertsMag2->setMagasinTrans2($this);
        }

        return $this;
    }

    public function removeTransfertsMag2(Transfert $transfertsMag2): self
    {
        if ($this->transfertsMag2->removeElement($transfertsMag2)) {
            // set the owning side to null (unless already changed)
            if ($transfertsMag2->getMagasinTrans2() === $this) {
                $transfertsMag2->setMagasinTrans2(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, SortieMag>
     */
    public function getSortieMags(): Collection
    {
        return $this->sortieMags;
    }

    public function addSortieMag(SortieMag $sortieMag): self
    {
        if (!$this->sortieMags->contains($sortieMag)) {
            $this->sortieMags[] = $sortieMag;
            $sortieMag->setMagasin($this);
        }

        return $this;
    }

    public function removeSortieMag(SortieMag $sortieMag): self
    {
        if ($this->sortieMags->removeElement($sortieMag)) {
            // set the owning side to null (unless already changed)
            if ($sortieMag->getMagasin() === $this) {
                $sortieMag->setMagasin(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, LivraisonMagasin>
     */
    public function getLivraisonMagasins(): Collection
    {
        return $this->livraisonMagasins;
    }

    public function addLivraisonMagasin(LivraisonMagasin $livraisonMagasin): self
    {
        if (!$this->livraisonMagasins->contains($livraisonMagasin)) {
            $this->livraisonMagasins[] = $livraisonMagasin;
            $livraisonMagasin->setMagasin($this);
   
        }
        return $this;
    }
    public function getEstDefaut(): ?bool
    {
        return $this->estDefaut;
    }

    public function setEstDefaut(?bool $estDefaut): self
    {
        $this->estDefaut = $estDefaut;

        return $this;
    }

    /**
     * @return Collection<int, ApproMagasin>
     */
    public function getApproMagasins(): Collection
    {
        return $this->approMagasins;
    }

    public function addApproMagasin(ApproMagasin $approMagasin): self
    {
        if (!$this->approMagasins->contains($approMagasin)) {
            $this->approMagasins[] = $approMagasin;
            $approMagasin->setMagasin($this);
        }

        return $this;
    }

    public function removeLivraisonMagasin(LivraisonMagasin $livraisonMagasin): self
    {
        if ($this->livraisonMagasins->removeElement($livraisonMagasin)) {
            // set the owning side to null (unless already changed)
            if ($livraisonMagasin->getMagasin() === $this) {
                $livraisonMagasin->setMagasin(null);

            }
        }
        return $this;
    }

    public function removeApproMagasin(ApproMagasin $approMagasin): self
    {
        if ($this->approMagasins->removeElement($approMagasin)) {
            // set the owning side to null (unless already changed)
            if ($approMagasin->getMagasin() === $this) {
                $approMagasin->setMagasin(null);
            }
        }

        return $this;
    }

    // public function addProduitCondMagLiv(ProduitCondMagLiv $produitCondMagLiv): self
    // {
    //     if (!$this->produitCondMagLivs->contains($produitCondMagLiv)) {
    //         $this->produitCondMagLivs[] = $produitCondMagLiv;
    //         $produitCondMagLiv->setMagasin($this);
    //     }

    //     return $this;
    // }

    // public function removeProduitCondMagLiv(ProduitCondMagLiv $produitCondMagLiv): self
    // {
    //     if ($this->produitCondMagLivs->removeElement($produitCondMagLiv)) {
    //         // set the owning side to null (unless already changed)
    //         if ($produitCondMagLiv->getMagasin() === $this) {
    //             $produitCondMagLiv->setMagasin(null);
    //         }
    //     }

    //     return $this;
    // }

    /**
     * @return Collection<int, ProduitCondComClit>
     */
    public function getProduitCondComClits(): Collection
    {
        return $this->produitCondComClits;
    }

    public function addProduitCondComClit(ProduitCondComClit $produitCondComClit): self
    {
        if (!$this->produitCondComClits->contains($produitCondComClit)) {
            $this->produitCondComClits[] = $produitCondComClit;
            $produitCondComClit->setMagasin($this);
        }

        return $this;
    }

    public function removeProduitCondComClit(ProduitCondComClit $produitCondComClit): self
    {
        if ($this->produitCondComClits->removeElement($produitCondComClit)) {
            // set the owning side to null (unless already changed)
            if ($produitCondComClit->getMagasin() === $this) {
                $produitCondComClit->setMagasin(null);
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

    public function addProduitConditionnement(Produit $produit): self
    {
        if (!$this->produits->contains($produit)) {
            $this->produits[] = $produit;
            $produit->setMagasinDefaut($this);
        }

        return $this;
    }

    public function removeProduitConditionnement(Produit $produit): self
    {
        if ($this->produits->removeElement($produit)) {
            // set the owning side to null (unless already changed)
            if ($produit->getMagasinDefaut() === $this) {
                $produit->setMagasinDefaut(null);
            }
        }

        return $this;
    }

    public function addProduit(Produit $produit): self
    {
        if (!$this->produits->contains($produit)) {
            $this->produits[] = $produit;
            $produit->setMagasinDefaut($this);
        }

        return $this;
    }

    public function removeProduit(Produit $produit): self
    {
        if ($this->produits->removeElement($produit)) {
            // set the owning side to null (unless already changed)
            if ($produit->getMagasinDefaut() === $this) {
                $produit->setMagasinDefaut(null);
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

    public function getEstPrincipal(): ?bool
    {
        return $this->estPrincipal;
    }

    public function setEstPrincipal(bool $estPrincipal): self
    {
        $this->estPrincipal = $estPrincipal;

        return $this;
    }

    /**
     * @return Collection<int, Detachement>
     */
    public function getDetachements(): Collection
    {
        return $this->detachements;
    }

    public function addDetachement(Detachement $detachement): self
    {
        if (!$this->detachements->contains($detachement)) {
            $this->detachements[] = $detachement;
            $detachement->setMagasin($this);
        }

        return $this;
    }

    public function removeDetachement(Detachement $detachement): self
    {
        if ($this->detachements->removeElement($detachement)) {
            // set the owning side to null (unless already changed)
            if ($detachement->getMagasin() === $this) {
                $detachement->setMagasin(null);
            }
        }

        return $this;
    }

}
