<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\MonnaieCaisseRepository;
use phpDocumentor\Reflection\Types\This;

/**
 * @ORM\Entity(repositoryClass=MonnaieCaisseRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class MonnaieCaisse
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=Caisse::class, inversedBy="monnaieCaisses",cascade={"persist"})
     * @ORM\JoinColumn(nullable=false)
     */
    private $caisse;

    /**
     * @ORM\ManyToOne(targetEntity=Monnaie::class, inversedBy="monnaieCaisses",cascade={"persist"})
     * @ORM\JoinColumn(nullable=false)
     */
    private $monnaie;

    /**
     * @ORM\Column(type="integer",nullable=false, options={"default":0})
     */
    private $nbr;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, options={"default":0})
     */
    private $montant;

    /**
     * @ORM\Column(type="integer",nullable=false)
     */
    private $etat;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCaisse(): ?Caisse
    {
        return $this->caisse;
    }

    public function setCaisse(?Caisse $caisse): self
    {
        $this->caisse = $caisse;

        return $this;
    }

    public function getMonnaie(): ?Monnaie
    {
        return $this->monnaie;
    }

    public function setMonnaie(?Monnaie $monnaie): self
    {
        $this->monnaie = $monnaie;

        return $this;
    }

    public function getNbr(): ?int
    {
        return $this->nbr;
    }

    public function setNbr(int $nbr): self
    {
        $this->nbr = $nbr;

        return $this;
    }

    public function getMontant(): ?string
    {
        return $this->montant;
    }

    public function setMontant(string $montant): self
    {
        $this->montant = $montant;

        return $this;
    }

    public function getEtat(): ?int
    {
        return $this->etat;
    }

    public function setEtat(int $etat): self
    {
        $this->etat = $etat;
       /* if($this->monnaie != null){
            $this->etat = $this->monnaie->getEtat();
        }*/
        return $this;
    }

    
}
