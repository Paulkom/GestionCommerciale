<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\CommandeFrsRepository;
use Doctrine\Common\Collections\Collection;
use App\AjaxifySearch\Annotation\AjaxifySearch;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=CommandeFrsRepository::class)
 * @ORM\HasLifecycleCallbacks
 *  * @AjaxifySearch(
 *     alias = "commandeFrs",
 *     itemTemplate = "commande_frs/partials/item.html.twig",
 *     relations = { "fournisseur" },
 *     searchables = {
 *          "dateComFrs", "montantTotal", "nomProd", "fournisseur.denomination","fournisseur.nom"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class CommandeFrs
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="datetime")
     */
    private $dateComFrs;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantTotal;

    /**
     * @ORM\ManyToOne(targetEntity=Fournisseur::class, inversedBy="commandeFrs")
     * @ORM\JoinColumn(nullable=true)
     */
    private $fournisseur;

    /**
     * @ORM\OneToMany(targetEntity=Approvisionnement::class, mappedBy="commandeFrs")
     */
    private $approvisionnements;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondComFrs::class, mappedBy="commandeFrs", cascade={"persist"})
     */
    private $produitCondComFrs;

    /**
     * @ORM\ManyToOne(targetEntity=DemandeDePrix::class, inversedBy="commandeFrs")
     */
    private $demandeDePrix;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="commandeFrs",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\Column(type="string", length=100, nullable=true)
     */
    private $refCom;

    /**
     * @ORM\ManyToOne(targetEntity=Utilisateur::class, inversedBy="commandeFrss")
     */
    private $operateur;

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
        $this->approvisionnements = new ArrayCollection();
        $this->produitCondComFrs = new ArrayCollection();
        $this->dateComFrs = new \DateTime();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateComFrs(): ?\DateTimeInterface
    {
        return $this->dateComFrs;
    }

    public function setDateComFrs(\DateTimeInterface $dateComFrs): self
    {
        $this->dateComFrs = $dateComFrs;

        return $this;
    }

    public function getMontantTotal(): ?string
    {
        return $this->montantTotal;
    }

    public function setMontantTotal(string $montantTotal): self
    {
        $this->montantTotal = $montantTotal;

        return $this;
    }

    public function getFournisseur(): ?Fournisseur
    {
        return $this->fournisseur;
    }

    public function setFournisseur(?Fournisseur $fournisseur): self
    {
        $this->fournisseur = $fournisseur;

        return $this;
    }

    /**
     * @return Collection<int, Approvisionnement>
     */
    public function getApprovisionnements(): Collection
    {
        return $this->approvisionnements;
    }

    public function addApprovisionnement(Approvisionnement $approvisionnement): self
    {
        if (!$this->approvisionnements->contains($approvisionnement)) {
            $this->approvisionnements[] = $approvisionnement;
            $approvisionnement->setCommandeFrs($this);
        }

        return $this;
    }

    public function removeApprovisionnement(Approvisionnement $approvisionnement): self
    {
        if ($this->approvisionnements->removeElement($approvisionnement)) {
            // set the owning side to null (unless already changed)
            if ($approvisionnement->getCommandeFrs() === $this) {
                $approvisionnement->setCommandeFrs(null);
            }
        }

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
            $produitCondComFr->setCommandeFrs($this);
        }

        return $this;
    }

    public function removeProduitCondComFr(ProduitCondComFrs $produitCondComFr): self
    {
        if ($this->produitCondComFrs->removeElement($produitCondComFr)) {
            // set the owning side to null (unless already changed)
            if ($produitCondComFr->getCommandeFrs() === $this) {
                $produitCondComFr->setCommandeFrs(null);
            }
        }

        return $this;
    }

    public function getDemandeDePrix(): ?DemandeDePrix
    {
        return $this->demandeDePrix;
    }

    public function setDemandeDePrix(?DemandeDePrix $demandeDePrix): self
    {
        $this->demandeDePrix = $demandeDePrix;

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

    public function getRefCom(): ?string
    {
        return $this->refCom;
    }

    public function setRefCom(?string $refCom): self
    {
        $this->refCom = $refCom;

        return $this;
    }

    public function getOperateur(): ?Utilisateur
    {
        return $this->operateur;
    }

    public function setOperateur(?Utilisateur $operateur): self
    {
        $this->operateur = $operateur;

        return $this;
    }
}
