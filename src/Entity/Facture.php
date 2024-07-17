<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\FactureRepository;
use DateTime;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=FactureRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Facture
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
    private $dateFac;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantTotal;

    /**
     * @ORM\ManyToOne(targetEntity=CommandeClient::class, inversedBy="factures",cascade={"persist"})
     */
    private $commandeCli;

    /**
     * @ORM\OneToMany(targetEntity=Paiement::class, mappedBy="facture")
     */
    private $paiements;

    /**
     * @ORM\Column(type="string", length=100)
     */
    private $refFac;

    /**
     * @ORM\Column(type="string", length=100)
     */
    private $statut;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $montantTotalCmd;

    /**
     * @ORM\OneToMany(targetEntity=ProdCondFact::class, mappedBy="facture",cascade={"persist"})
     */
    private $prodCondFacts;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $montantRest;


    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="factures",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\ManyToOne(targetEntity=Utilisateur::class, inversedBy="factures")
     */
    private $operateur;

     /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $mecefDate;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $mecefQrCode;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $mecefCode;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $mecefCompteur;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $mecefNim;

     /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estNormalisee;

    /**
     * @ORM\Column(type="string", length=255,options={"default" : "FV"})
     */
    private $typeFacture = "FV";
    

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
        $this->paiements = new ArrayCollection();
        $this->dateFac= new DateTime('now');
        $this->statut="En attente";
        $this->prodCondFacts = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateFac(): ?\DateTimeInterface
    {
        return $this->dateFac;
    }

    public function setDateFac(\DateTimeInterface $dateFac): self
    {
        $this->dateFac = $dateFac;
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

    public function getCommandeCli(): ?CommandeClient
    {
        return $this->commandeCli;
    }

    public function setCommandeCli(?CommandeClient $commandeCli): self
    {
        $this->commandeCli = $commandeCli;
        return $this;
    }

    /**
     * @return Collection<int, Paiement>
     */
    public function getPaiements(): Collection
    {
        return $this->paiements;
    }

    public function addPaiement(Paiement $paiement): self
    {
        if (!$this->paiements->contains($paiement)) {
            $this->paiements[] = $paiement;
            $paiement->setFacture($this);
        }

        return $this;
    }

    public function removePaiement(Paiement $paiement): self
    {
        if ($this->paiements->removeElement($paiement)) {
            // set the owning side to null (unless already changed)
            if ($paiement->getFacture() === $this) {
                $paiement->setFacture(null);
            }
        }

        return $this;
    }

    public function getRefFac(): ?string
    {
        return $this->refFac;
    }

    public function setRefFac(string $refFac): self
    {
        $this->refFac = $refFac;

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

    public function getMontantTotalCmd(): ?string
    {
        return $this->montantTotalCmd;
    }

    public function setMontantTotalCmd(?string $montantTotalCmd): self
    {
        $this->montantTotalCmd = $montantTotalCmd;

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
            $prodCondFact->setFacture($this);
        }

        return $this;
    }

    public function removeProdCondFact(ProdCondFact $prodCondFact): self
    {
        if ($this->prodCondFacts->removeElement($prodCondFact)) {
            // set the owning side to null (unless already changed)
            if ($prodCondFact->getFacture() === $this) {
                $prodCondFact->setFacture(null);
            }
        }

        return $this;
    }

    public function __toString()
    {
        $lib="";
        $lib = $this->getRefFac().' -- '.$this->getCommandeCli()->getAcheteur() .' [ '. $this->getMontantTotal() .' ] ';
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



    public function getMecefQrCode(): ?string
    {
        return $this->mecefQrCode;
    }

    public function setMecefQrCode(?string $mecefQrCode): self
    {
        $this->mecefQrCode = $mecefQrCode;

        return $this;
    }

    public function getMecefCode(): ?string
    {
        return $this->mecefCode;
    }

    public function setMecefCode(?string $mecefCode): self
    {
        $this->mecefCode = $mecefCode;

        return $this;
    }

    public function getMecefCompteur(): ?string
    {
        return $this->mecefCompteur;
    }

    public function setMecefCompteur(?string $mecefCompteur): self
    {
        $this->mecefCompteur = $mecefCompteur;

        return $this;
    }

    public function getMecefNim(): ?string
    {
        return $this->mecefNim;
    }

    public function setMecefNim(?string $mecefNim): self
    {
        $this->mecefNim = $mecefNim;

        return $this;
    }

    public function getMecefDate(): ?string
    {
        return $this->mecefDate;
    }

    public function setMecefDate(?string $mecefDate): self
    {
        $this->mecefDate = $mecefDate;

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

    public function getTypeFacture(): ?string
    {
        return $this->typeFacture;
    }

    public function setTypeFacture(string $typeFacture): self
    {
        $this->typeFacture = $typeFacture;

        return $this;
    }
}
