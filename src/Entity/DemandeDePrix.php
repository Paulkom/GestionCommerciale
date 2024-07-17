<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\DemandeDePrixRepository;
use Doctrine\Common\Collections\Collection;
use App\AjaxifySearch\Annotation\AjaxifySearch;
use Doctrine\Common\Collections\ArrayCollection;


/**
 * @ORM\Entity(repositoryClass=DemandeDePrixRepository::class)
 * @ORM\HasLifecycleCallbacks
 *  * @AjaxifySearch(
 *     alias = "demande_de_prix",
 *     itemTemplate = "demande_de_prix/partials/item.html.twig",
 *     searchables = {
 *          "fournisseur", "dateDdp"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class DemandeDePrix
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
    private $dateDdp;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $montantTotal;

    /**
     * @ORM\ManyToOne(targetEntity=Fournisseur::class, inversedBy="demandeDePrixes")
     * @ORM\JoinColumn(nullable=false)
     */
    private $fournisseur;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondDdp::class, mappedBy="demandeDePrix", orphanRemoval=true, cascade={"persist"})
     */
    private $produitCondDdps;

    /**
     * @ORM\OneToMany(targetEntity=CommandeFrs::class, mappedBy="demandeDePrix")
     */
    private $commandeFrs;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="demandeDePrixes",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estTransformer;

    /**
     * @ORM\Column(type="string", length=100, nullable=true)
     */
    private $refDdp;

    /**
     * @ORM\ManyToOne(targetEntity=Utilisateur::class, inversedBy="demandeDePrixs")
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
        $this->produitCondDdps = new ArrayCollection();
        $this->dateDdp = new \DateTime();
        $this->commandeFrs = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateDdp(): ?\DateTimeInterface
    {
        return $this->dateDdp;
    }

    public function setDateDdp(\DateTimeInterface $dateDdp): self
    {
        $this->dateDdp = $dateDdp;

        return $this;
    }

    public function getMontantTotal(): ?string
    {
        return $this->montantTotal;
    }

    public function setMontantTotal(?string $montantTotal): self
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
            $produitCondDdp->setDemandeDePrix($this);
        }

        return $this;
    }

    public function removeProduitCondDdp(ProduitCondDdp $produitCondDdp): self
    {
        if ($this->produitCondDdps->removeElement($produitCondDdp)) {
            // set the owning side to null (unless already changed)
            if ($produitCondDdp->getDemandeDePrix() === $this) {
                $produitCondDdp->setDemandeDePrix(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, CommandeFrs>
     */
    public function getCommandeFrs(): Collection
    {
        return $this->commandeFrs;
    }

    public function addCommandeFr(CommandeFrs $commandeFr): self
    {
        if (!$this->commandeFrs->contains($commandeFr)) {
            $this->commandeFrs[] = $commandeFr;
            $commandeFr->setDemandeDePrix($this);
        }

        return $this;
    }

    public function removeCommandeFr(CommandeFrs $commandeFr): self
    {
        if ($this->commandeFrs->removeElement($commandeFr)) {
            // set the owning side to null (unless already changed)
            if ($commandeFr->getDemandeDePrix() === $this) {
                $commandeFr->setDemandeDePrix(null);
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

    public function getEstTransformer(): ?bool
    {
        return $this->estTransformer;
    }

    public function setEstTransformer(?bool $estTransformer): self
    {
        $this->estTransformer = $estTransformer;

        return $this;
    }

    public function getRefDdp(): ?string
    {
        return $this->refDdp;
    }

    public function setRefDdp(?string $refDdp): self
    {
        $this->refDdp = $refDdp;

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
