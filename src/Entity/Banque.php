<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\BanqueRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=BanqueRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Banque
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
    private $denominationBanque;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $sigle;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $adresse;

    /**
     * @ORM\OneToMany(targetEntity=CompteBanque::class, mappedBy="banque")
     */
    private $compteBanques;

    /**
     * @ORM\OneToMany(targetEntity=Paiement::class, mappedBy="banque")
     */
    private $paiements;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="banques",cascade={"persist"})
     */
    private $pointVente;

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
        $this->compteBanques = new ArrayCollection();
        $this->paiements = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getSigle(): ?string
    {
        return $this->sigle;
    }

    public function setSigle(string $sigle): self
    {
        $this->sigle = $sigle;

        return $this;
    }

    public function getAdresse(): ?string
    {
        return $this->adresse;
    }

    public function setAdresse(string $adresse): self
    {
        $this->adresse = $adresse;

        return $this;
    }

    public function getDenominationBanque(): ?string
    {
        return $this->denominationBanque;
    }

    public function setDenominationBanque(string $denominationBanque): self
    {
        $this->denominationBanque = $denominationBanque;

        return $this;
    }

    /**
     * @return Collection<int, CompteBanque>
     */
    public function getCompteBanques(): Collection
    {
        return $this->compteBanques;
    }

    public function addCompteBanque(CompteBanque $compteBanque): self
    {
        if (!$this->compteBanques->contains($compteBanque)) {
            $this->compteBanques[] = $compteBanque;
            $compteBanque->setBanque($this);
        }

        return $this;
    }

    public function removeCompteBanque(CompteBanque $compteBanque): self
    {
        if ($this->compteBanques->removeElement($compteBanque)) {
            // set the owning side to null (unless already changed)
            if ($compteBanque->getBanque() === $this) {
                $compteBanque->setBanque(null);
            }
        }

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
            $paiement->setBanque($this);
        }

        return $this;
    }

    public function removePaiement(Paiement $paiement): self
    {
        if ($this->paiements->removeElement($paiement)) {
            // set the owning side to null (unless already changed)
            if ($paiement->getBanque() === $this) {
                $paiement->setBanque(null);
            }
        }

        return $this;
    }

    public function __toString()
    {
        return $this->sigle;
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

}
