<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use Gedmo\Timestampable\Traits\TimestampableEntity;
use App\Repository\ProduitConditionnementRepository;
use App\AjaxifySearch\Annotation\AjaxifySearch;

/**
 * @ORM\Entity(repositoryClass=ProduitConditionnementRepository::class)
 * @ORM\HasLifecycleCallbacks
 * @ORM\EntityListeners({"App\EventListener\ProduitConditionnementListener"})
 * @AjaxifySearch(
 *     alias = "produitConditionnement",
 *     itemTemplate = "ajaxify/produitconditionnement/item.html.twig",
 *     relations = { "produit", "conditionnement" },
 *     searchables = {
 *          "qteCond", "qteStockCond", "prixDeVente", "produit.refProd", "famille.libelleFamille",
 *          "produit.nomProd", "conditionnement.codeCond", "conditionnement.libelleCond"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class ProduitConditionnement
{
    use Timestampable;

    public static $oldQteStockCond = 0;
    public static $newQteStockCond = 0;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=Produit::class, inversedBy="produitConditionnements")
     * @ORM\JoinColumn(nullable=false)
     */
    private $produit;

    /**
     * @ORM\ManyToOne(targetEntity=Conditionnement::class, inversedBy="produitConditionnements")
     * @ORM\JoinColumn(nullable=false)
     */
    private $conditionnement;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, options={"default" : 0})
     */
    private $qteCond;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, options={"default" : 0})
     */
    private $qteStockCond;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $prixMin;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $prixMax;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $prixDeVente;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $prixDeVenteHT;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $prixDeVenteTTC;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $cump;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondTrans::class, mappedBy="produitCond", orphanRemoval=true)
     */
    private $produitCondTrans;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondComClit::class, mappedBy="produit")
     */
    private $produitCondComClits;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondSortieMag::class, mappedBy="produitCond", orphanRemoval=true)
     */
    private $produitCondSortieMags;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondMag::class, mappedBy="produitConditionnement", orphanRemoval=true)
     */
    private $produitCondMags;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondApproMag::class, mappedBy="produitConditionnement", orphanRemoval=true)
     */
    private $produitCondApproMags;

    /**
     * @ORM\OneToMany(targetEntity=ProdCondFact::class, mappedBy="produit")
     */
    private $prodCondFacts;

    // /**
    //  * @ORM\OneToMany(targetEntity=ProduitCondFacture::class, mappedBy="produit",cascade={"persist"})
    //  */
    // private $prodCondFactures;

     /**
     * @ORM\OneToMany(targetEntity=ProduitCondFacture::class, mappedBy="produit",cascade={"persist"})
     */
    private $produitCondFactures;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondMagInv::class, mappedBy="produitCondInv")
     */
    private $produitCondMagInvs;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondDdp::class, mappedBy="produitCond")
     */
    private $produitCondDdps;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $stockInit;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondComFrs::class, mappedBy="produitCond", orphanRemoval=true)
     */
    private $produitCondComFrs;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, options={"default" : 0})
     */
    private $qteStockCondLogique = 0;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $nomProCond;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="produitConditionnements", cascade={"persist"})
     */
    private $pointVente;


    private $lib = null;

    /**
     * @ORM\OneToMany(targetEntity=ProduitDetacher::class, mappedBy="cible")
     */
    private $produitDetachers;

    /**
     * @ORM\Column(type="boolean")
     */
    private $estUniteBase;


    public function __construct()
    {
        $this->produitCondTrans = new ArrayCollection();
        $this->produitCondComClits = new ArrayCollection();
        $this->produitCondSortieMags = new ArrayCollection();
        $this->produitCondMags = new ArrayCollection();
        $this->produitCondApproMags = new ArrayCollection();
        $this->prodCondFacts = new ArrayCollection();
        $this->produitCondMagInvs = new ArrayCollection();
        $this->produitCondDdps = new ArrayCollection();
        $this->prixDeVente = 0;
        $this->prixDeVenteHT = 0;
        $this->prixDeVenteTTC = 0;
        $this->prixMin = 0;
        $this->prixMax = 0;
        $this->cump = 0;
        $this->qteStockCond = 0;
        $this->estUniteBase =false;
        $this->produitCondComFrs = new ArrayCollection();
        $this->produitDetachers = new ArrayCollection();
        // $this->prodCondFactures = new ArrayCollection();
        $this->produitCondFactures = new ArrayCollection();
    }

    public function __toString()
    {
        return $this->getProduit()->getNomProd() . ' ['. $this->getConditionnement()->getLibelleCond().']';
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getProduit(): ?Produit
    {
        return $this->produit;
    }

    public function setProduit(?Produit $produit): self
    {
        $this->produit = $produit;

        return $this;
    }

    public function getConditionnement(): ?Conditionnement
    {
        return $this->conditionnement;
    }

    public function setConditionnement(?Conditionnement $conditionnement): self
    {
        $this->conditionnement = $conditionnement;

        return $this;
    }

    public function getQteStockCond(): ?string
    {
        return $this->qteStockCond;
    }

    public function setQteStockCond(string $qteStockCond): self
    {
        $this->qteStockCond = $qteStockCond;

        return $this;
    }

    public function getPrixDeVente(): ?string
    {
        return $this->prixDeVente;
    }

    public function setPrixDeVente(?string $prixDeVente): self
    {
        $this->prixDeVente = $prixDeVente;

        return $this;
    }

    public function getPrixDeVenteHT(): ?string
    {
        return $this->prixDeVenteHT;
    }

    public function setPrixDeVenteHT(?string $prixDeVenteHT): self
    {
        $this->prixDeVenteHT = $prixDeVenteHT;

        return $this;
    }

    public function getPrixDeVenteTTC(): ?string
    {
        return $this->prixDeVenteTTC;
    }

    public function setPrixDeVenteTTC(?string $prixDeVenteTTC): self
    {
        $this->prixDeVenteTTC = $prixDeVenteTTC;

        return $this;
    }

    /**
     * @return Collection<int, ProduitCondTrans>
     */
    public function getProduitCondTrans(): Collection
    {
        return $this->produitCondTrans;
    }

    public function addProduitCondTran(ProduitCondTrans $produitCondTran): self
    {
        if (!$this->produitCondTrans->contains($produitCondTran)) {
            $this->produitCondTrans[] = $produitCondTran;
            $produitCondTran->setProduitCond($this);
        }

        return $this;
    }

    public function removeProduitCondTran(ProduitCondTrans $produitCondTran): self
    {
        if ($this->produitCondTrans->removeElement($produitCondTran)) {
            // set the owning side to null (unless already changed)
            if ($produitCondTran->getProduitCond() === $this) {
                $produitCondTran->setProduitCond(null);
            }
        }

        return $this;
    }

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
            $produitCondComClit->setProduit($this);
        }

        return $this;
    }

    public function removeProduitCondComClit(ProduitCondComClit $produitCondComClit): self
    {
        if ($this->produitCondComClits->removeElement($produitCondComClit)) {
            // set the owning side to null (unless already changed)
            if ($produitCondComClit->getProduit() === $this) {
                $produitCondComClit->setProduit(null);
            }
        }
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
            $produitCondSortieMag->setProduitCond($this);
        }

        return $this;
    }

    public function removeProduitCondSortieMag(ProduitCondSortieMag $produitCondSortieMag): self
    {
        if ($this->produitCondSortieMags->removeElement($produitCondSortieMag)) {
            // set the owning side to null (unless already changed)
            if ($produitCondSortieMag->getProduitCond() === $this) {
                $produitCondSortieMag->setProduitCond(null);
            }
        }

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
            $produitCondApproMag->setProduitConditionnement($this);
        }

        return $this;
    }
    public function removeProduitCondApproMag(ProduitCondApproMag $produitCondApproMag): self
    {
        if ($this->produitCondApproMags->removeElement($produitCondApproMag)) {
            // set the owning side to null (unless already changed)
            if ($produitCondApproMag->getProduitConditionnement() === $this) {
                $produitCondApproMag->setProduitConditionnement(null);
            }
        }

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
            $produitCondMag->setProduitConditionnement($this);
        }

        return $this;
    }

    public function removeProduitCondMag(ProduitCondMag $produitCondMag): self
    {
        if ($this->produitCondMags->removeElement($produitCondMag)) {
            // set the owning side to null (unless already changed)
            if ($produitCondMag->getProduitConditionnement() === $this) {
                $produitCondMag->setProduitConditionnement(null);
            }
        }

        return $this;
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
            $prodCondFact->setProduit($this);
        }

        return $this;
    }

    public function removeProdCondFact(ProdCondFact $prodCondFact): self
    {
        if ($this->prodCondFacts->removeElement($prodCondFact)) {
            // set the owning side to null (unless already changed)
            if ($prodCondFact->getProduit() === $this) {
                $prodCondFact->setProduit(null);
            }
        }

        return $this;
    }

    public function getQteCond(): ?string
    {
        return $this->qteCond;
    }

    public function setQteCond(string $qteCond): self
    {
        $this->qteCond = $qteCond;

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
            $produitCondMagInv->setProduitCondInv($this);
        }

        return $this;
    }

    public function removeProduitCondMagInv(ProduitCondMagInv $produitCondMagInv): self
    {
        if ($this->produitCondMagInvs->removeElement($produitCondMagInv)) {
            // set the owning side to null (unless already changed)
            if ($produitCondMagInv->getProduitCondInv() === $this) {
                $produitCondMagInv->setProduitCondInv(null);
            }
        }

        return $this;
    }

    public function getPrixMin(): ?string
    {
        return $this->prixMin;
    }

    public function setPrixMin(?string $prixMin): self
    {
        $this->prixMin = $prixMin;

        return $this;
    }

    public function getPrixMax(): ?string
    {
        return $this->prixMax;
    }

    public function setPrixMax(?string $prixMax): self
    {
        $this->prixMax = $prixMax;

        return $this;
    }

    /**
     * @return Collection<int, ProduitCondDdp>
     */
    public function getProduitCondDdps(): Collection
    {
        return $this->produitCondDdps;
    }

    public function addProduitCondDdp(ProduitCondDdp $produitCondDdp): self
    {
        if (!$this->produitCondDdps->contains($produitCondDdp)) {
            $this->produitCondDdps[] = $produitCondDdp;
            $produitCondDdp->setProduitCond($this);
        }

        return $this;
    }

    public function removeProduitCondDdp(ProduitCondDdp $produitCondDdp): self
    {
        if ($this->produitCondDdps->removeElement($produitCondDdp)) {
            // set the owning side to null (unless already changed)
            if ($produitCondDdp->getProduitCond() === $this) {
                $produitCondDdp->setProduitCond(null);
            }
        }

        return $this;
    }

    public function getCump(): ?string
    {
        return $this->cump;
    }

    public function setCump(?string $cump): self
    {
        $this->cump = $cump;

        return $this;
    }

    public function getStockInit(): ?string
    {
        return $this->stockInit;
    }

    public function setStockInit(?string $stockInit): self
    {
        $this->stockInit = $stockInit;

        return $this;
    }

    /**
     * @return Collection<int, ProduitCondComFrs>
     */
    public function getProduitCondComFrs(): Collection
    {
        return $this->produitCondComFrs;
    }

    public function addProduitCondComFr(ProduitCondComFrs $produitCondComFr): self
    {
        if (!$this->produitCondComFrs->contains($produitCondComFr)) {
            $this->produitCondComFrs[] = $produitCondComFr;
            $produitCondComFr->setProduitCond($this);
        }

        return $this;
    }

    public function removeProduitCondComFr(ProduitCondComFrs $produitCondComFr): self
    {
        if ($this->produitCondComFrs->removeElement($produitCondComFr)) {
            // set the owning side to null (unless already changed)
            if ($produitCondComFr->getProduitCond() === $this) {
                $produitCondComFr->setProduitCond(null);
            }
        }

        return $this;
    }

    public function getQteStockCondLogique(): ?string
    {
        return $this->qteStockCondLogique;
    }

    public function setQteStockCondLogique(string $qteStockCondLogique): self
    {
        $this->qteStockCondLogique = $qteStockCondLogique;
        return $this;
    }

    public function getNomProCond(): ?string
    {
        return $this->nomProCond;
    }

    public function setNomProCond(string $nomProCond): self
    {
        $this->nomProCond = $nomProCond;

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
            $produitDetacher->getCible($this);
        }

        return $this;
    }

    public function removeProduitDetacher(ProduitDetacher $produitDetacher): self
    {
        if ($this->produitDetachers->removeElement($produitDetacher)) {
            // set the owning side to null (unless already changed)
            if ($produitDetacher->getCible() === $this) {
                $produitDetacher->getCible(null);
            }
        }

        return $this;
    }

    public function getEstUniteBase(): ?bool
    {
        return $this->estUniteBase;
    }

    public function setEstUniteBase(bool $estUniteBase): self
    {
        $this->estUniteBase = $estUniteBase;

        return $this;
    }


    /**
     * @return Collection<int, ProduitCondFacture>
     */
    public function getProduitCondFactures(): Collection
    {
        return $this->produitCondFactures;
    }

    public function addProduitCondFacture(ProduitCondFacture $produitCondFacture): self
    {
        if (!$this->produitCondFactures->contains($produitCondFacture)) {
            $this->produitCondFactures[] = $produitCondFacture;
            $produitCondFacture->setProduit($this);
        }

        return $this;
    }

    public function removeProduitCondFacture(ProduitCondFacture $produitCondFacture): self
    {
        if ($this->produitCondFactures->removeElement($produitCondFacture)) {
            // set the owning side to null (unless already changed)
            if ($produitCondFacture->getProduit() === $this) {
                $produitCondFacture->setProduit(null);
            }
        }

        return $this;
    }



}
