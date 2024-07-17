<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\MonnaieRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=MonnaieRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Monnaie
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
     * @ORM\Column(type="integer")
     */
    private $valeur;

    /**
     * @ORM\OneToMany(targetEntity=MonnaieCaisse::class, mappedBy="monnaie")
     */
    private $monnaieCaisses;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="monnaies",cascade={"persist"})
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
        $this->monnaieCaisses = new ArrayCollection();
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

    public function getValeur(): ?int
    {
        return $this->valeur;
    }

    public function setValeur(int $valeur): self
    {
        $this->valeur = $valeur;

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
        if (!$this->monnaieCaisses->contains($monnaieCaiss)) {
            $this->monnaieCaisses[] = $monnaieCaiss;
            $monnaieCaiss->setMonnaie($this);
        }

        return $this;
    }

    public function removeMonnaieCaiss(MonnaieCaisse $monnaieCaiss): self
    {
        if ($this->monnaieCaisses->removeElement($monnaieCaiss)) {
            // set the owning side to null (unless already changed)
            if ($monnaieCaiss->getMonnaie() === $this) {
                $monnaieCaiss->setMonnaie(null);
            }
        }

        return $this;
    }

    public function __toString()
    {
        return $this->libelle;
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
