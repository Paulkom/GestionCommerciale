<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\ProduitCondMagInvRepository;

/**
 * @ORM\Entity(repositoryClass=ProduitCondMagInvRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class ProduitCondMagInv
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $qteCondStockLog;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $qteCondStockPhy;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $ecart;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $debit;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $credit;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $prixUnitaire;

    /**
     * @ORM\ManyToOne(targetEntity=InventaireMag::class, inversedBy="produitCondMagInvs")
     * @ORM\JoinColumn(nullable=false)
     */
    private $inventaireMag;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitConditionnement::class, inversedBy="produitCondMagInvs")
     * @ORM\JoinColumn(nullable=false)
     */
    private $produitCondInv;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estCloturer;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getQteCondStockLog(): ?string
    {
        return $this->qteCondStockLog;
    }

    public function setQteCondStockLog(string $qteCondStockLog): self
    {
        $this->qteCondStockLog = $qteCondStockLog;

        return $this;
    }

    public function getQteCondStockPhy(): ?string
    {
        return $this->qteCondStockPhy;
    }

    public function setQteCondStockPhy(string $qteCondStockPhy): self
    {
        $this->qteCondStockPhy = $qteCondStockPhy;

        return $this;
    }

    public function getEcart(): ?string
    {
        return $this->ecart;
    }

    public function setEcart(string $ecart): self
    {
        $this->ecart = $ecart;

        return $this;
    }

    public function getDebit(): ?string
    {
        return $this->debit;
    }

    public function setDebit(string $debit): self
    {
        $this->debit = $debit;

        return $this;
    }

    public function getCredit(): ?string
    {
        return $this->credit;
    }

    public function setCredit(string $credit): self
    {
        $this->credit = $credit;

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

    public function getInventaireMag(): ?InventaireMag
    {
        return $this->inventaireMag;
    }

    public function setInventaireMag(?InventaireMag $inventaireMag): self
    {
        $this->inventaireMag = $inventaireMag;

        return $this;
    }

    public function getProduitCondInv(): ?ProduitConditionnement
    {
        return $this->produitCondInv;
    }

    public function setProduitCondInv(?ProduitConditionnement $produitCondInv): self
    {
        $this->produitCondInv = $produitCondInv;

        return $this;
    }

    public function getEstCloturer(): ?bool
    {
        return $this->estCloturer;
    }

    public function setEstCloturer(?bool $estCloturer): self
    {
        $this->estCloturer = $estCloturer;

        return $this;
    }


}
