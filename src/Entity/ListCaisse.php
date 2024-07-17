<?php

namespace App\Entity;

use App\Repository\ListCaisseRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use App\Entity\Traits\Timestampable;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ListCaisseRepository::class)
 */
class ListCaisse
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
    private $libelle;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $code;

    /**
     * @ORM\OneToMany(targetEntity=Caisse::class, mappedBy="lcaisse")
     */
    private $caisses;


    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    // /**
    //  * @ORM\OneToMany(targetEntity=Paiement::class, mappedBy="caisse")
    //  */
    // private $paiements;

    // /**
    //  * @ORM\OneToMany(targetEntity=Transaction::class, mappedBy="caisse",cascade={"persist"})
    //  */
    // private $transactions;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="listCaisses")
     */
    private $pointVente;

    /**
     * @ORM\Column(type="boolean",options={"default":false})
     */
    private $etat;

    
    public function __construct()
    {
        $this->caisses = new ArrayCollection();
        $this->etat = false;
        // $this->paiements = new ArrayCollection();
        // $this->transactions = new ArrayCollection();
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

    public function getCode(): ?string
    {
        return $this->code;
    }

    public function setCode(string $code): self
    {
        $this->code = $code;

        return $this;
    }

    /**
     * @return Collection<int, Caisse>
     */
    public function getCaisses(): Collection
    {
        return $this->caisses;
    }

    public function addCaiss(Caisse $caiss): self
    {
        if (!$this->caisses->contains($caiss)) {
            $this->caisses[] = $caiss;
            $caiss->setLcaisse($this);
        }

        return $this;
    }

    public function removeCaiss(Caisse $caiss): self
    {
        if ($this->caisses->removeElement($caiss)) {
            // set the owning side to null (unless already changed)
            if ($caiss->getLcaisse() === $this) {
                $caiss->setLcaisse(null);
            }
        }

        return $this;
    }

    // /**
    //  * @return Collection<int, Paiement>
    //  */
    // public function getPaiements(): Collection
    // {
    //     return $this->paiements;
    // }

    // public function addPaiement(Paiement $paiement): self
    // {
    //     if (!$this->paiements->contains($paiement)) {
    //         $this->paiements[] = $paiement;
    //         $paiement->setCaisse($this);
    //     }
    //     return $this;
    // }

    // public function removePaiement(Paiement $paiement): self
    // {
    //     if ($this->paiements->removeElement($paiement)) {
    //         // set the owning side to null (unless already changed)
    //         if ($paiement->getCaisse() === $this) {
    //             $paiement->setCaisse(null);
    //         }
    //     }

    //     return $this;
    // }

    // /**
    //  * @return Collection<int, Transaction>
    //  */
    // public function getTransactions(): Collection
    // {
    //     return $this->transactions;
    // }

    // public function addTransaction(Transaction $transaction): self
    // {
    //     if (!$this->transactions->contains($transaction)) {
    //         $this->transactions[] = $transaction;
    //         $transaction->setCaisse($this);
    //     }

    //     return $this;
    // }

    // public function removeTransaction(Transaction $transaction): self
    // {
    //     if ($this->transactions->removeElement($transaction)) {
    //         // set the owning side to null (unless already changed)
    //         if ($transaction->getCaisse() === $this) {
    //             $transaction->setCaisse(null);
    //         }
    //     }

    //     return $this;
    // }

    public function __toString()
    {
        return $this->libelle;
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

    public function getPointVente(): ?PointDeVente
    {
        return $this->pointVente;
    }

    public function setPointVente(?PointDeVente $pointVente): self
    {
        $this->pointVente = $pointVente;

        return $this;
    }

    public function getEtat(): ?bool
    {
        return $this->etat;
    }

    public function setEtat(bool $etat): self
    {
        $this->etat = $etat;

        return $this;
    }

}
