<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\ProduitCondDdpRepository;

/**
 * @ORM\Entity(repositoryClass=ProduitCondDdpRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class ProduitCondDdp
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=DemandeDePrix::class, inversedBy="produitCondDdps")
     * @ORM\JoinColumn(nullable=false)
     */
    private $demandeDePrix;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $qteDdp;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $montant;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitConditionnement::class, inversedBy="produitCondDdps")
     * @ORM\JoinColumn(nullable=false)
     */
    private $produitCond;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDemandeDePrix(): ?DemandeDePrix
    {
        return $this->demandeDePrix;
    }

    public function setDemandeDePrix(?DemandeDePrix $demandeDePrix): self
    {
        $this->demandeDePrix = $demandeDePrix;

        return $this;
    }

    public function getQteDdp(): ?string
    {
        return $this->qteDdp;
    }

    public function setQteDdp(string $qteDdp): self
    {
        $this->qteDdp = $qteDdp;

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

    public function getProduitCond(): ?ProduitConditionnement
    {
        return $this->produitCond;
    }

    public function setProduitCond(?ProduitConditionnement $produitCond): self
    {
        $this->produitCond = $produitCond;

        return $this;
    }

    
}
