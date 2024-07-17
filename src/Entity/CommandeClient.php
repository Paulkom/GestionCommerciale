<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use Doctrine\Common\Collections\Collection;
use App\Repository\CommandeClientRepository;
use DateTime;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=CommandeClientRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class CommandeClient
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
    private $dateCom;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $statut;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantHt;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantTtc;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantTva;

    /**
     * @ORM\ManyToOne(targetEntity=Client::class, inversedBy="commandeClients")
     * @ORM\JoinColumn(nullable=false)
     */
    private $acheteur;

    /**
     * @ORM\OneToMany(targetEntity=Facture::class, mappedBy="commandeCli",cascade={"persist"})
     */
    private $factures;

    /**
     * @ORM\OneToMany(targetEntity=Livraison::class, mappedBy="commandeCli",cascade={"persist"})
     */
    private $livraisons;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondComClit::class, mappedBy="commandeClit",cascade={"persist"})
     */
    private $produitCondComClits;

    /**
     * @ORM\Column(type="string", length=100, nullable=true)
     */
    private $refCom;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true,options={"default":0})
     */
    private $montantRest;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $typeCommande;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $typeFacture;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $typeRemise;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2,nullable=true)
     */
    private $remise;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $valeurRemise;

    /**
     * @ORM\Column(type="date", nullable=true)
     */
    private $dateLivPrev;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantHtToAprRse;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantTS;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="commandeClients",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\ManyToOne(targetEntity=Utilisateur::class, inversedBy="commandeClients")
     */
    private $operateur;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estNormalisee;

    /**
     * @ORM\OneToMany(targetEntity=ElementSupplementaire::class, mappedBy="commandeClient",cascade={"persist"})
     */
    private $elementSupplementaires;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $statutLiv;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantAib = 0;

    /**
     * @ORM\Column(type="integer",nullable=true)
     */
    private $tauxAib;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $motifAnnulation;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $paysOrigine;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $paysDestination;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $lieuChargement;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $lieuDechargement;

    /**
     * @ORM\ManyToOne(targetEntity=ModelSignataire::class, inversedBy="commandeClients")
     */
    private $modelSignataire;

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
        $this->factures = new ArrayCollection();
        $this->livraisons = new ArrayCollection();
        $this->produitCondComClits = new ArrayCollection();
        $this->dateCom= new DateTime('now');
        $this->dateLivPrev= new DateTime('now');
        $this->typeCommande="Au comptoir";
        $this->typeFacture="Facture de vente";
        $this->statut="En attente";
        $this->elementSupplementaires = new ArrayCollection();
        $this->statutLiv = '-';
        $this->montantTS = 0;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateCom(): ?\DateTimeInterface
    {
        return $this->dateCom;
    }

    public function setDateCom(\DateTimeInterface $dateCom): self
    {
        $this->dateCom = $dateCom;
        return $this;
    }

    public function getStatut(): ?string
    {
        return $this->statut;
    }

    public function setStatut(string $statut): self
    {
        $this->statut = $statut;

        return $this;
    }

    public function getMontantHt(): ?string
    {
        return $this->montantHt;
    }

    public function setMontantHt(string $montantHt): self
    {
        $this->montantHt = $montantHt;

        return $this;
    }

    public function getMontantTtc(): ?string
    {
        return $this->montantTtc;
    }

    public function setMontantTtc(string $montantTtc): self
    {
        $this->montantTtc = $montantTtc;

        return $this;
    }

    public function getMontantTva(): ?string
    {
        return $this->montantTva;
    }

    public function setMontantTva(string $montantTva): self
    {
        $this->montantTva = $montantTva;
        return $this;
    }

    public function getAcheteur(): ?Client
    {
        return $this->acheteur;
    }

    public function setAcheteur(?Client $acheteur): self
    {
        $this->acheteur = $acheteur;

        return $this;
    }

    /**
     * @return Collection<int, Facture>
     */
    public function getFactures(): Collection
    {
        return $this->factures;
    }

    public function addFacture(Facture $facture): self
    {
        if (!$this->factures->contains($facture)) {
            $this->factures[] = $facture;
            $facture->setCommandeCli($this);
        }

        return $this;
    }

    public function removeFacture(Facture $facture): self
    {
        if ($this->factures->removeElement($facture)) {
            // set the owning side to null (unless already changed)
            if ($facture->getCommandeCli() === $this) {
                $facture->setCommandeCli(null);
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
            $livraison->setCommandeCli($this);
        }

        return $this;
    }

    public function removeLivraison(Livraison $livraison): self
    {
        if ($this->livraisons->removeElement($livraison)) {
            // set the owning side to null (unless already changed)
            if ($livraison->getCommandeCli() === $this) {
                $livraison->setCommandeCli(null);
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
            $produitCondComClit->setCommandeClit($this);
        }

        return $this;
    }

    public function removeProduitCondComClit(ProduitCondComClit $produitCondComClit): self
    {
        if ($this->produitCondComClits->removeElement($produitCondComClit)) {
            // set the owning side to null (unless already changed)
            if ($produitCondComClit->getCommandeClit() === $this) {
                $produitCondComClit->setCommandeClit(null);
            }
        }
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

    public function __toString()
    {
        $lib="";
        $lib = $this->getRefCom().' [ '.$this->getAcheteur() .' ]['.date_format($this->getDateCom(),'d-m-Y').']';
        return $lib;
    }

    public function getMontantRest(): ?string
    {
        return $this->montantRest;
    }

    public function setMontantRest(?string $montantRest): self
    {
        $this->montantRest = $montantRest;

        return $this;
    }

    public function getTypeCommande(): ?string
    {
        return $this->typeCommande;
    }

    public function setTypeCommande(string $typeCommande): self
    {
        $this->typeCommande = $typeCommande;

        return $this;
    }

    public function getTypeRemise(): ?string
    {
        return $this->typeRemise;
    }

    public function setTypeRemise(string $typeRemise): self
    {
        $this->typeRemise = $typeRemise;

        return $this;
    }

    public function getRemise(): ?string
    {
        return $this->remise;
    }

    public function setRemise(string $remise): self
    {
        $this->remise = $remise;

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

    public function getDateLivPrev(): ?\DateTimeInterface
    {
        return $this->dateLivPrev;
    }

    public function setDateLivPrev(?\DateTimeInterface $dateLivPrev): self
    {
        $this->dateLivPrev = $dateLivPrev;

        return $this;
    }

    public function getMontantHtToAprRse(): ?string
    {
        return $this->montantHtToAprRse;
    }

    public function setMontantHtToAprRse(string $montantHtToAprRse): self
    {
        $this->montantHtToAprRse = $montantHtToAprRse;

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

    public function getOperateur(): ?Utilisateur
    {
        return $this->operateur;
    }

    public function setOperateur(?Utilisateur $operateur): self
    {
        $this->operateur = $operateur;

        return $this;
    }

    public function getEstNormalisee(): ?bool
    {
        return $this->estNormalisee;
    }

    public function setEstNormalisee(?bool $estNormalisee): self
    {
        $this->estNormalisee = $estNormalisee;

        return $this;
    }
    
    public function getStatutLiv(): ?string
    {
        return $this->statutLiv;
    }

    public function setStatutLiv(string $statutLiv): self
    {
        $this->statutLiv = $statutLiv;

        return $this;
    }

    /**
     * @return Collection<int, ElementSupplementaire>
     */
    public function getElementSupplementaires(): Collection
    {
        return $this->elementSupplementaires;
    }

    public function addElementSupplementaire(ElementSupplementaire $elementSupplementaire): self
    {
        if (!$this->elementSupplementaires->contains($elementSupplementaire)) {
            $this->elementSupplementaires[] = $elementSupplementaire;
            $elementSupplementaire->setCommandeClient($this);
        }

        return $this;
    }

    public function removeElementSupplementaire(ElementSupplementaire $elementSupplementaire): self
    {
        if ($this->elementSupplementaires->removeElement($elementSupplementaire)) {
            // set the owning side to null (unless already changed)
            if ($elementSupplementaire->getCommandeClient() === $this) {
                $elementSupplementaire->setCommandeClient(null);
            }
        }

        return $this;
    }

    public function getMontantAib(): ?string
    {
        return $this->montantAib;
    }

    public function setMontantAib(string $montantAib): self
    {
        $this->montantAib = $montantAib;

        return $this;
    }

    public function getTauxAib(): ?int
    {
        return $this->tauxAib;
    }

    public function setTauxAib(int $tauxAib): self
    {
        $this->tauxAib = $tauxAib;

        return $this;
    }

    public function getMotifAnnulation(): ?string
    {
        return $this->motifAnnulation;
    }

    public function setMotifAnnulation(?string $motifAnnulation): self
    {
        $this->motifAnnulation = $motifAnnulation;

        return $this;
    }

    public function getMontantTS(): ?string
    {
        return $this->montantTS;
    }

    public function setMontantTS(string $montantTS): self
    {
        $this->montantTS = $montantTS;

        return $this;
    }

    public function getPaysOrigine(): ?string
    {
        return $this->paysOrigine;
    }

    public function setPaysOrigine(?string $paysOrigine): self
    {
        $this->paysOrigine = $paysOrigine;

        return $this;
    }

    public function getPaysDestination(): ?string
    {
        return $this->paysDestination;
    }

    public function setPaysDestination(?string $paysDestination): self
    {
        $this->paysDestination = $paysDestination;

        return $this;
    }

    public function getLieuChargement(): ?string
    {
        return $this->lieuChargement;
    }

    public function setLieuChargement(?string $lieuChargement): self
    {
        $this->lieuChargement = $lieuChargement;

        return $this;
    }

    public function getLieuDechargement(): ?string
    {
        return $this->lieuDechargement;
    }

    public function setLieuDechargement(?string $lieuDechargement): self
    {
        $this->lieuDechargement = $lieuDechargement;

        return $this;
    }

    public function getTypeFacture(): ?string
    {
        return $this->typeFacture;
    }

    public function setTypeFacture(string $typeFacture): self
    {
        $this->typeFacture = $typeFacture;

        return $this;
    }

    public function getModelSignataire(): ?ModelSignataire
    {
        return $this->modelSignataire;
    }

    public function setModelSignataire(?ModelSignataire $modelSignataire): self
    {
        $this->modelSignataire = $modelSignataire;

        return $this;
    }
}
