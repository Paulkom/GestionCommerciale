<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\ProduitRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;
use Gedmo\Timestampable\Traits\TimestampableEntity;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use App\AjaxifySearch\Annotation\AjaxifySearch;

/**
 * @ORM\Entity(repositoryClass=ProduitRepository::class)
 * @UniqueEntity("codeProduit")
 * @ORM\HasLifecycleCallbacks
 * @AjaxifySearch(
 *     alias = "produit",
 *     itemTemplate = "produit/partials/item.html.twig",
 *     relations = { "famille" },
 *     searchables = {
 *          "stock", "prixVenteProd", "nomProd","codeProduit", "famille.libelleFamille",
 *          "descProd", "refProd", "estTaxable", "seuilAppro"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class Produit
{
    CONST CUMP  = 1;
    CONST FIFO  = 2;
    CONST LIFO  = 3;
    CONST LOTS  = 4;

    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $refProd;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $nomProd;

    /**
     * @ORM\Column(type="text", nullable=true)
     */
    private $descProd;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $prixAchatProd;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $prixVenteProd;

    /**
     * @ORM\Column(type="boolean")
     */
    private $estTaxable;

    /**
     * @ORM\Column(type="boolean")
     */
    private $estService;

    /**
     * @ORM\Column(type="boolean")
     */
    private $estModeCarreau;

    /**
     * @ORM\Column(type="binary", nullable=true)
     */
    private $codeQR;

    /**
     * @ORM\Column(type="binary", nullable=true)
     */
    private $codeBarre;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $seuilAppro;

    /**
     * @ORM\ManyToOne(targetEntity=Famille::class, inversedBy="produits", fetch="EAGER")
     * @ORM\JoinColumn(nullable=false)
     */
    private $famille;

    /**
     * @ORM\OneToMany(targetEntity=Media::class, mappedBy="produit", cascade={"persist", "remove"})
     */
    private $medias;

    /**
     * @ORM\OneToMany(targetEntity=ProduitConditionnement::class, mappedBy="produit", cascade={"persist", "remove"}, orphanRemoval=true)
     */
    private $produitConditionnements;


    // /**
    //  * @ORM\OneToMany(targetEntity=ProduitCondDdp::class, mappedBy="produit", orphanRemoval=true)
    //  */
    // private $produitCondDdps;

    // /**
    //  * @ORM\OneToMany(targetEntity=ProduitCondComFrs::class, mappedBy="produit")
    //  */
    // private $produitCondComFrs;

    // /**
    //  * @ORM\OneToMany(targetEntity=ProduitCondFacture::class, mappedBy="produit", orphanRemoval=true)
    //  */
    // private $produitCondFactures;

    // /**
    //  * @ORM\OneToMany(targetEntity=ProduitCondMagLiv::class, mappedBy="produit", orphanRemoval=true)
    //  */
    // private $produitCondMagLivs;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="produits")
     * @ORM\JoinColumn(nullable=true)
     */
    private $pointVente;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, options={"default" : 0})
     */
    private $stock;

    /**
     * @ORM\Column(name="code_produit", type="string", length=255, nullable=true, unique=true)
     */
    private $codeProduit;

    /**
     * @ORM\Column(type="integer", nullable=true)
     */
    private $suiviStock;

    /**
     * @ORM\ManyToOne(targetEntity=GroupeTaxe::class, inversedBy="produits")
     */
    private $groupeTaxe;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $modeDefPrix;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $metreCarreParCarton;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $pieceParCarton;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $pieceParMetreCarre;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $surfaceParPiece;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $couleurCarreau;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=Magasin::class, inversedBy="produits")
     * @ORM\JoinColumn(nullable=true)
     */
    private $magasinDefaut;

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
        $this->medias = new ArrayCollection();
        $this->produitConditionnements = new ArrayCollection();
        // $this->produitCondDdps = new ArrayCollection();
        // $this->produitCondComFrs = new ArrayCollection();
        // $this->produitCondFactures = new ArrayCollection();
        // $this->produitCondMagLivs = new ArrayCollection();
        $this->estModeCarreau = false;
        $this->prixAchatProd = 0;
        $this->prixVenteProd = 0;
        $this->seuilAppro = 10;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getRefProd(): ?string
    {
        return $this->refProd;
    }

    public function setRefProd(?string $refProd): self
    {
        $this->refProd = $refProd;

        return $this;
    }

    public function getNomProd(): ?string
    {
        return $this->nomProd;
    }

    public function setNomProd(string $nomProd): self
    {
        $this->nomProd = $nomProd;

        return $this;
    }

    public function getDescProd(): ?string
    {
        return $this->descProd;
    }

    public function setDescProd(?string $descProd): self
    {
        $this->descProd = $descProd;

        return $this;
    }

    public function getPrixAchatProd(): ?string
    {
        return $this->prixAchatProd;
    }

    public function setPrixAchatProd(?string $prixAchatProd): self
    {
        $this->prixAchatProd = $prixAchatProd;

        return $this;
    }

    public function getPrixVenteProd(): ?string
    {
        return $this->prixVenteProd;
    }

    public function setPrixVenteProd(?string $prixVenteProd): self
    {
        $this->prixVenteProd = $prixVenteProd;

        return $this;
    }

    public function getEstTaxable(): ?bool
    {
        return $this->estTaxable;
    }

    public function setEstTaxable(bool $estTaxable): self
    {
        $this->estTaxable = $estTaxable;

        return $this;
    }

    public function getCodeQR()
    {
        return $this->codeQR;
    }

    public function setCodeQR($codeQR): self
    {
        $this->codeQR = $codeQR;

        return $this;
    }

    public function getCodeBarre()
    {
        return $this->codeBarre;
    }

    public function setCodeBarre($codeBarre): self
    {
        $this->codeBarre = $codeBarre;

        return $this;
    }

    public function getSeuilAppro(): ?string
    {
        return $this->seuilAppro;
    }

    public function setSeuilAppro(string $seuilAppro): self
    {
        $this->seuilAppro = $seuilAppro;

        return $this;
    }

    public function getFamille(): ?Famille
    {
        return $this->famille;
    }

    public function setFamille(?Famille $famille): self
    {
        $this->famille = $famille;

        return $this;
    }

    /**
     * @return Collection<int, Media>
     */
    public function getMedias(): Collection
    {
        return $this->medias;
    }

    public function addMedia(Media $media): self
    {
        if (!$this->medias->contains($media)) {
            $this->medias[] = $media;
            $media->setProduit($this);
        }

        return $this;
    }

    public function removeMedia(Media $media): self
    {
        if ($this->medias->removeElement($media)) {
            // set the owning side to null (unless already changed)
            if ($media->getProduit() === $this) {
                $media->setProduit(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, ProduitConditionnement>
     */
    public function getProduitConditionnements(): Collection
    {
        return $this->produitConditionnements;
    }

    public function addProduitConditionnement(ProduitConditionnement $produitConditionnement): self
    {
        if (!$this->produitConditionnements->contains($produitConditionnement)) {
            $this->produitConditionnements[] = $produitConditionnement;
            $produitConditionnement->setProduit($this);
        }

        return $this;
    }

    public function removeProduitConditionnement(ProduitConditionnement $produitConditionnement): self
    {
        if ($this->produitConditionnements->removeElement($produitConditionnement)) {
            // set the owning side to null (unless already changed)
            if ($produitConditionnement->getProduit() === $this) {
                $produitConditionnement->setProduit(null);
            }
        }

        return $this;
    }

    // /**
    //  * @return Collection<int, ProduitCondDdp>
    //  */
    // public function getProduitCondDdps(): Collection
    // {
    //     return $this->produitCondDdps;
    // }

    // public function addProduitCondDdp(ProduitCondDdp $produitCondDdp): self
    // {
    //     if (!$this->produitCondDdps->contains($produitCondDdp)) {
    //         $this->produitCondDdps[] = $produitCondDdp;
    //         $produitCondDdp->setProduit($this);
    //     }

    //     return $this;
    // }

    // public function removeProduitCondDdp(ProduitCondDdp $produitCondDdp): self
    // {
    //     if ($this->produitCondDdps->removeElement($produitCondDdp)) {
    //         // set the owning side to null (unless already changed)
    //         if ($produitCondDdp->getProduit() === $this) {
    //             $produitCondDdp->setProduit(null);
    //         }
    //     }

    //     return $this;
    // }

    // /**
    //  * @return Collection<int, ProduitCondComFrs>
    //  */
    // public function getProduitCondComFrs(): Collection
    // {
    //     return $this->produitCondComFrs;
    // }

    // public function addProduitCondComFr(ProduitCondComFrs $produitCondComFr): self
    // {
    //     if (!$this->produitCondComFrs->contains($produitCondComFr)) {
    //         $this->produitCondComFrs[] = $produitCondComFr;
    //         $produitCondComFr->setProduit($this);
    //     }

    //     return $this;
    // }

    // public function removeProduitCondComFr(ProduitCondComFrs $produitCondComFr): self
    // {
    //     if ($this->produitCondComFrs->removeElement($produitCondComFr)) {
    //         // set the owning side to null (unless already changed)
    //         if ($produitCondComFr->getProduit() === $this) {
    //             $produitCondComFr->setProduit(null);
    //         }
    //     }

    //     return $this;
    // }

    // /**
    //  * @return Collection<int, ProduitCondFacture>
    //  */
    // public function getProduitCondFactures(): Collection
    // {
    //     return $this->produitCondFactures;
    // }

    // public function addProduitCondFacture(ProduitCondFacture $produitCondFacture): self
    // {
    //     if (!$this->produitCondFactures->contains($produitCondFacture)) {
    //         $this->produitCondFactures[] = $produitCondFacture;
    //         $produitCondFacture->setProduit($this);
    //     }

    //     return $this;
    // }

    // public function removeProduitCondFacture(ProduitCondFacture $produitCondFacture): self
    // {
    //     if ($this->produitCondFactures->removeElement($produitCondFacture)) {
    //         // set the owning side to null (unless already changed)
    //         if ($produitCondFacture->getProduit() === $this) {
    //             $produitCondFacture->setProduit(null);
    //         }
    //     }

    //     return $this;
    // }



    public function getEstService(): ?bool
    {
        return $this->estService;
    }

    public function setEstService(bool $estService): self
    {
        $this->estService = $estService;

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

    public function getStock(): ?string
    {
        return $this->stock;
    }

    public function setStock(?string $stock): self
    {
        $this->stock = $stock;

        return $this;
    }

    public function getCodeProduit(): ?string
    {
        return $this->codeProduit;
    }

    public function setCodeProduit(?string $codeProduit): self
    {
        $this->codeProduit = $codeProduit;

        return $this;
    }

    public function getSuiviStock(): ?int
    {
        return $this->suiviStock;
    }

    public function setSuiviStock(?int $suiviStock): self
    {
        $this->suiviStock = $suiviStock;

        return $this;
    }

    public function getGroupeTaxe(): ?GroupeTaxe
    {
        return $this->groupeTaxe;
    }

    public function setGroupeTaxe(?GroupeTaxe $groupeTaxe): self
    {
        $this->groupeTaxe = $groupeTaxe;

        return $this;
    }

    public function getModeDefPrix(): ?string
    {
        return $this->modeDefPrix;
    }

    public function setModeDefPrix(?string $modeDefPrix): self
    {
        $this->modeDefPrix = $modeDefPrix;

        return $this;
    }

    public function getMagasinDefaut(): ?Magasin
    {
        return $this->magasinDefaut;
    }

    public function setMagasinDefaut(?Magasin $magasinDefaut): self
    {
        $this->magasinDefaut = $magasinDefaut;

        return $this;
    }

    public function getEstModeCarreau(): ?bool
    {
        return $this->estModeCarreau;
    }

    public function setEstModeCarreau(bool $estModeCarreau): self
    {
        $this->estModeCarreau = $estModeCarreau;

        return $this;
    }

    public function getMetreCarreParCarton(): ?string
    {
        return $this->metreCarreParCarton;
    }

    public function setMetreCarreParCarton(?string $metreCarreParCarton): self
    {
        $this->metreCarreParCarton = $metreCarreParCarton;

        return $this;
    }

    public function getPieceParCarton(): ?string
    {
        return $this->pieceParCarton;
    }

    public function setPieceParCarton(?string $pieceParCarton): self
    {
        $this->pieceParCarton = $pieceParCarton;

        return $this;
    }

    public function getPieceParMetreCarre(): ?string
    {
        return $this->pieceParMetreCarre;
    }

    public function setPieceParMetreCarre(?string $pieceParMetreCarre): self
    {
        $this->pieceParMetreCarre = $pieceParMetreCarre;

        return $this;
    }

    public function getSurfaceParPiece(): ?string
    {
        return $this->surfaceParPiece;
    }

    public function setSurfaceParPiece(?string $surfaceParPiece): self
    {
        $this->surfaceParPiece = $surfaceParPiece;

        return $this;
    }

    public function getCouleurCarreau(): ?string
    {
        return $this->couleurCarreau;
    }

    public function setCouleurCarreau(?string $couleurCarreau): self
    {
        $this->couleurCarreau = $couleurCarreau;

        return $this;
    }

    public function __toString()
    {
        return $this->nomProd;
    }

}