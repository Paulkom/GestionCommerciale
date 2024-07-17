<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\ProduitCondComFrsRepository;

/**
 * @ORM\Entity(repositoryClass=ProduitCondComFrsRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class ProduitCondComFrs
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=CommandeFrs::class, inversedBy="produitCondComFrs")
     */
    private $commandeFrs;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $qteComfrs;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantCond;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $prixUnitaire;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitConditionnement::class, inversedBy="produitCondComFrs")
     * @ORM\JoinColumn(nullable=false)
     */
    private $produitCond;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCommandeFrs(): ?CommandeFrs
    {
        return $this->commandeFrs;
    }

    public function setCommandeFrs(?CommandeFrs $commandeFrs): self
    {
        $this->commandeFrs = $commandeFrs;

        return $this;
    }

    public function getQteComfrs(): ?string
    {
        return $this->qteComfrs;
    }

    public function setQteComfrs(string $qteComfrs): self
    {
        $this->qteComfrs = $qteComfrs;

        return $this;
    }

    public function getMontantCond(): ?string
    {
        return $this->montantCond;
    }

    public function setMontantCond(string $montantCond): self
    {
        $this->montantCond = $montantCond;

        return $this;
    }

    public function getPrixUnitaire(): ?string
    {
        return $this->prixUnitaire;
    }

    public function setPrixUnitaire(string $prixUnitaire): self
    {
        $this->prixUnitaire = $prixUnitaire;

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
