<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use Doctrine\Common\Collections\Collection;
use App\Repository\ModelSignataireRepository;
use App\AjaxifySearch\Annotation\AjaxifySearch;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=ModelSignataireRepository::class)
 * @ORM\HasLifecycleCallbacks
 *  * @AjaxifySearch(
 *     alias = "model",
 *     itemTemplate = "model_signataire/partials/item.html.twig",
 *     relations = { "modelSignatairePersonnelFonction" },
 *     searchables = {
 *          "code", "libelle",  "modelSignatairePersonnelFonction.personnel",
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class ModelSignataire
{
    use Timestampable;
    
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="boolean")
     */
    private $estDefault;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $libelle;

    /**
     * @ORM\OneToMany(targetEntity=ModelSignatairePersonnelFonction::class, mappedBy="modelSignataire",cascade={"persist"})
     */
    private $modelSignatairePersonnelFonctions;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="modelSignataires")
     * @ORM\JoinColumn(nullable=true)
     */
    private $pointVente;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\OneToMany(targetEntity=CommandeClient::class, mappedBy="modelSignataire")
     */
    private $commandeClients;

    /**
     * @ORM\OneToMany(targetEntity=FactureProforma::class, mappedBy="modelSignataire")
     */
    private $factureProformas;

    /**
     * @ORM\OneToMany(targetEntity=Livraison::class, mappedBy="modelSignataire")
     */
    private $livraisons;

    /**
     * @ORM\OneToMany(targetEntity=Approvisionnement::class, mappedBy="modelSignataire")
     */
    private $approvisionnements;

    /**
     * @ORM\OneToMany(targetEntity=Inventaire::class, mappedBy="modelSignataire")
     */
    private $inventaires;

    public function __construct()
    {
        $this->modelSignatairePersonnelFonctions = new ArrayCollection();
        $this->commandeClients = new ArrayCollection();
        $this->factureProformas = new ArrayCollection();
        $this->livraisons = new ArrayCollection();
        $this->approvisionnements = new ArrayCollection();
        $this->inventaires = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLibelle(): ?string
    {
        return $this->libelle;
    }

    public function setLibelle(string $libelle): self
    {
        $this->libelle = $libelle;

        return $this;
    }

    /**
     * @return Collection<int, ModelSignatairePersonnelFonction>
     */
    public function getModelSignatairePersonnelFonctions(): Collection
    {
        return $this->modelSignatairePersonnelFonctions;
    }

    public function addModelSignatairePersonnelFonction(ModelSignatairePersonnelFonction $modelSignatairePersonnelFonction): self
    {
        if (!$this->modelSignatairePersonnelFonctions->contains($modelSignatairePersonnelFonction)) {
            $this->modelSignatairePersonnelFonctions[] = $modelSignatairePersonnelFonction;
            $modelSignatairePersonnelFonction->setModelSignataire($this);
        }

        return $this;
    }

    public function removeModelSignatairePersonnelFonction(ModelSignatairePersonnelFonction $modelSignatairePersonnelFonction): self
    {
        if ($this->modelSignatairePersonnelFonctions->removeElement($modelSignatairePersonnelFonction)) {
            // set the owning side to null (unless already changed)
            if ($modelSignatairePersonnelFonction->getModelSignataire() === $this) {
                $modelSignatairePersonnelFonction->setModelSignataire(null);
            }
        }

        return $this;
    }

    public function getEstDefault(): ?bool
    {
        return $this->estDefault;
    }

    public function setEstDefault(bool $estDefault): self
    {
        $this->estDefault = $estDefault;

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
     * @return Collection<int, CommandeClient>
     */
    public function getCommandeClients(): Collection
    {
        return $this->commandeClients;
    }

    public function addCommandeClient(CommandeClient $commandeClient): self
    {
        if (!$this->commandeClients->contains($commandeClient)) {
            $this->commandeClients[] = $commandeClient;
            $commandeClient->setModelSignataire($this);
        }

        return $this;
    }

    public function removeCommandeClient(CommandeClient $commandeClient): self
    {
        if ($this->commandeClients->removeElement($commandeClient)) {
            // set the owning side to null (unless already changed)
            if ($commandeClient->getModelSignataire() === $this) {
                $commandeClient->setModelSignataire(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, FactureProforma>
     */
    public function getFactureProformas(): Collection
    {
        return $this->factureProformas;
    }

    public function addFactureProforma(FactureProforma $factureProforma): self
    {
        if (!$this->factureProformas->contains($factureProforma)) {
            $this->factureProformas[] = $factureProforma;
            $factureProforma->setModelSignataire($this);
        }

        return $this;
    }

    public function removeFactureProforma(FactureProforma $factureProforma): self
    {
        if ($this->factureProformas->removeElement($factureProforma)) {
            // set the owning side to null (unless already changed)
            if ($factureProforma->getModelSignataire() === $this) {
                $factureProforma->setModelSignataire(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Livraison>
     */
    public function getLivraisons(): Collection
    {
        return $this->livraisons;
    }

    public function addLivraison(Livraison $livraison): self
    {
        if (!$this->livraisons->contains($livraison)) {
            $this->livraisons[] = $livraison;
            $livraison->setModelSignataire($this);
        }

        return $this;
    }

    public function removeLivraison(Livraison $livraison): self
    {
        if ($this->livraisons->removeElement($livraison)) {
            // set the owning side to null (unless already changed)
            if ($livraison->getModelSignataire() === $this) {
                $livraison->setModelSignataire(null);
            }
        }

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
            $approvisionnement->setModelSignataire($this);
        }

        return $this;
    }

    public function removeApprovisionnement(Approvisionnement $approvisionnement): self
    {
        if ($this->approvisionnements->removeElement($approvisionnement)) {
            // set the owning side to null (unless already changed)
            if ($approvisionnement->getModelSignataire() === $this) {
                $approvisionnement->setModelSignataire(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Inventaire>
     */
    public function getInventaires(): Collection
    {
        return $this->inventaires;
    }

    public function addInventaire(Inventaire $inventaire): self
    {
        if (!$this->inventaires->contains($inventaire)) {
            $this->inventaires[] = $inventaire;
            $inventaire->setModelSignataire($this);
        }

        return $this;
    }

    public function removeInventaire(Inventaire $inventaire): self
    {
        if ($this->inventaires->removeElement($inventaire)) {
            // set the owning side to null (unless already changed)
            if ($inventaire->getModelSignataire() === $this) {
                $inventaire->setModelSignataire(null);
            }
        }

        return $this;
    }

}
