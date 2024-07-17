<?php

namespace App\Entity;

use App\Repository\CompteBanqueRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=CompteBanqueRepository::class)
 */
class CompteBanque
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $numeroCompteBQ;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $soldeCompteBQ;

    /**
     * @ORM\ManyToOne(targetEntity=Societe::class, inversedBy="comptesBQ")
     * @ORM\JoinColumn(nullable=false)
     */
    private $societe;

    /**
     * @ORM\ManyToOne(targetEntity=Banque::class, inversedBy="compteBanques")
     * @ORM\JoinColumn(nullable=false)
     */
    private $banque;

    /**
     * @ORM\OneToMany(targetEntity=Transaction::class, mappedBy="compteBanque")
     */
    private $transactions;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

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
        $this->transactions = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNumeroCompteBQ(): ?string
    {
        return $this->numeroCompteBQ;
    }

    public function setNumeroCompteBQ(string $numeroCompteBQ): self
    {
        $this->numeroCompteBQ = $numeroCompteBQ;

        return $this;
    }

    public function getSoldeCompteBQ(): ?string
    {
        return $this->soldeCompteBQ;
    }

    public function setSoldeCompteBQ(?string $soldeCompteBQ): self
    {
        $this->soldeCompteBQ = $soldeCompteBQ;

        return $this;
    }

    public function getSociete(): ?Societe
    {
        return $this->societe;
    }

    public function setSociete(?Societe $societe): self
    {
        $this->societe = $societe;

        return $this;
    }

    public function getBanque(): ?Banque
    {
        return $this->banque;
    }

    public function setBanque(?Banque $banque): self
    {
        $this->banque = $banque;

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
            $transaction->setCompteBanque($this);
        }

        return $this;
    }

    public function removeTransaction(Transaction $transaction): self
    {
        if ($this->transactions->removeElement($transaction)) {
            // set the owning side to null (unless already changed)
            if ($transaction->getCompteBanque() === $this) {
                $transaction->setCompteBanque(null);
            }
        }

        return $this;
    }

    public function __toString()
    {
        return $this->getBanque()->getSigle() . ' [' . $this->getNumeroCompteBQ() . ']';
    }
}
