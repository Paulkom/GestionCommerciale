<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\CaisseRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=CaisseRepository::class)
 * @ORM\HasLifecycleCallbacks
 * 
 */
class Caisse
{
    use Timestampable;
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="datetime",nullable=true)
     */
    private $dateOuverture;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $dateFermeture;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0)
     */
    private $fondRoulement;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $soldeCloture;

    /**
     * @ORM\OneToMany(targetEntity=MonnaieCaisse::class, mappedBy="caisse",cascade={"persist"})
     */
    private $monnaieCaisses;

    /**
     * @ORM\OneToMany(targetEntity=PersonnelCaisse::class, mappedBy="caisse", orphanRemoval=true,cascade={"persist"})
     */
    private $personnelCaisses;

    /**
     * @ORM\Column(type="integer")
     */
    private $etat;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $ecart;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0,nullable=true)
     */
    private $chiffreAffaire;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=ListCaisse::class, inversedBy="caisses", cascade={"persist"})
     */
    private $lcaisse;

    /**
     * @ORM\ManyToOne(targetEntity=Caisse::class, inversedBy="caisses", cascade={"persist"})
     */
    private $etatCaisse;

    /**
     * @ORM\OneToMany(targetEntity=Caisse::class, mappedBy="etatCaisse")
     */
    private $caisses;

    /**
     * @ORM\ManyToOne(targetEntity=Utilisateur::class, inversedBy="caisses")
     */
    private $user;
    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="caisses",cascade={"persist"})
     */
    private $pointVente;

     /**
     * @ORM\OneToMany(targetEntity=Paiement::class, mappedBy="caisse")
     */
    private $paiements;

    /**
     * @ORM\OneToMany(targetEntity=Transaction::class, mappedBy="caisse",cascade={"persist"})
     */
    private $transactions;

    /**
     * @ORM\OneToMany(targetEntity=Depense::class, mappedBy="caisse")
     */
    private $depenses;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $depense;


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
        $this->monnaieCaisses = new ArrayCollection();
        $this->personnelCaisses = new ArrayCollection();
        $this->caisses = new ArrayCollection();
        $this->paiements = new ArrayCollection();
        $this->transactions = new ArrayCollection();
        $this->depenses = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateOuverture(): ?\DateTimeInterface
    {
        return $this->dateOuverture;
    }

    public function setDateOuverture(\DateTimeInterface $dateOuverture): self
    {
        $this->dateOuverture = $dateOuverture;

        return $this;
    }

    public function getDateFermeture(): ?\DateTimeInterface
    {
        return $this->dateFermeture;
    }

    public function setDateFermeture(?\DateTimeInterface $dateFermeture): self
    {
        $this->dateFermeture = $dateFermeture;

        return $this;
    }

    public function getFondRoulement(): ?string
    {
        return $this->fondRoulement;
    }

    public function setFondRoulement(string $fondRoulement): self
    {
        $this->fondRoulement = $fondRoulement;

        return $this;
    }

    public function getSoldeCloture(): ?string
    {
        return $this->soldeCloture;
    }

    public function setSoldeCloture(?string $soldeCloture): self
    {
        $this->soldeCloture = $soldeCloture;

        return $this;
    }

    /**
     * @return Collection<int, MonnaieCaisse>
     */
    public function getMonnaieCaisses(): Collection
    {
        return $this->monnaieCaisses;
    }

    public function addMonnaieCaiss(MonnaieCaisse $monnaieCaiss): self
    {
        ///$monnaieCaiss->setEtat($this->etat);
        if (!$this->monnaieCaisses->contains($monnaieCaiss)) {
            $this->monnaieCaisses[] = $monnaieCaiss;
            $monnaieCaiss->setCaisse($this);
        }

        return $this;
    }

    public function removeMonnaieCaiss(MonnaieCaisse $monnaieCaiss): self
    {
        if ($this->monnaieCaisses->removeElement($monnaieCaiss)) {
            // set the owning side to null (unless already changed)
            if ($monnaieCaiss->getCaisse() === $this) {
                $monnaieCaiss->setCaisse(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, PersonnelCaisse>
     */
    public function getPersonnelCaisses(): Collection
    {
        return $this->personnelCaisses;
    }

    public function addPersonnelCaiss(PersonnelCaisse $personnelCaiss): self
    {
        if (!$this->personnelCaisses->contains($personnelCaiss)) {
            $this->personnelCaisses[] = $personnelCaiss;
            $personnelCaiss->setCaisse($this);
        }

        return $this;
    }

    public function removePersonnelCaiss(PersonnelCaisse $personnelCaiss): self
    {
        if ($this->personnelCaisses->removeElement($personnelCaiss)) {
            // set the owning side to null (unless already changed)
            if ($personnelCaiss->getCaisse() === $this) {
                $personnelCaiss->setCaisse(null);
            }
        }

        return $this;
    }

    public function getEtat(): ?int
    {
        return $this->etat;
    }

    public function setEtat(int $etat): self
    {
        $this->etat = $etat;

        return $this;
    }

    public function getEcart(): ?string
    {
        return $this->ecart;
    }

    public function setEcart(?string $ecart): self
    {
        $this->ecart = $ecart;
        return $this;
    }

    public function getChiffreAffaire(): ?string
    {
        return $this->chiffreAffaire;
    }

    public function setChiffreAffaire(string $chiffreAffaire): self
    {
        $this->chiffreAffaire = $chiffreAffaire;
        return $this;
    }

    public function getLcaisse(): ?ListCaisse
    {
        return $this->lcaisse;
    }

    public function setLcaisse(?ListCaisse $lcaisse): self
    {
        $this->lcaisse = $lcaisse;

        return $this;
    }

    public function getEtatCaisse(): ?self
    {
        return $this->etatCaisse;
    }

    public function setEtatCaisse(?self $etatCaisse): self
    {
        $this->etatCaisse = $etatCaisse;

        return $this;
    }

    /**
     * @return Collection<int, self>
     */
    public function getCaisses(): Collection
    {
        return $this->caisses;
    }

    public function addCaiss(self $caiss): self
    {
        if (!$this->caisses->contains($caiss)) {
            $this->caisses[] = $caiss;
            $caiss->setEtatCaisse($this);
        }

        return $this;
    }

    public function removeCaiss(self $caiss): self
    {
        if ($this->caisses->removeElement($caiss)) {
            // set the owning side to null (unless already changed)
            if ($caiss->getEtatCaisse() === $this) {
                $caiss->setEtatCaisse(null);
            }
        }

        return $this;
    }

    public function getUser(): ?Utilisateur
    {
        return $this->user;
    }

    public function setUser(?Utilisateur $user):self
    {
        $this->user = $user;
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
            $paiement->setCaisse($this);
        }
        return $this;
    }

    public function removePaiement(Paiement $paiement): self
    {
        if ($this->paiements->removeElement($paiement)) {
            // set the owning side to null (unless already changed)
            if ($paiement->getCaisse() === $this) {
                $paiement->setCaisse(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Transaction>
     */
    public function getTransactions(): Collection
    {
        return $this->transactions;
    }

    public function addTransaction(Transaction $transaction): self
    {
        if (!$this->transactions->contains($transaction)) {
            $this->transactions[] = $transaction;
            $transaction->setCaisse($this);
        }

        return $this;
    }

    public function removeTransaction(Transaction $transaction): self
    {
        if ($this->transactions->removeElement($transaction)) {
            // set the owning side to null (unless already changed)
            if ($transaction->getCaisse() === $this) {
                $transaction->setCaisse(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Depense>
     */
    public function getDepenses(): Collection
    {
        return $this->depenses;
    }

    public function addDepense(Depense $depense): self
    {
        if (!$this->depenses->contains($depense)) {
            $this->depenses[] = $depense;
            $depense->setCaisse($this);
        }

        return $this;
    }

    public function removeDepense(Depense $depense): self
    {
        if ($this->depenses->removeElement($depense)) {
            // set the owning side to null (unless already changed)
            if ($depense->getCaisse() === $this) {
                $depense->setCaisse(null);
            }
        }

        return $this;
    }

    public function getDepense(): ?string
    {
        return $this->depense;
    }

    public function setDepense(string $depense): self
    {
        $this->depense = $depense;

        return $this;
    }
    
}
