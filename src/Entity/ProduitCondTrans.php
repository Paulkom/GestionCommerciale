<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\ProduitCondTransRepository;

/**
 * @ORM\Entity(repositoryClass=ProduitCondTransRepository::class)
 * @ORM\HasLifecycleCallbacks
 * @ORM\EntityListeners({"App\EventListener\ProduitCondTransListener"})
 */
class ProduitCondTrans
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=Transfert::class, inversedBy="produitCondTrans")
     * @ORM\JoinColumn(nullable=false)
     */
    private $transfert;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $qteCondTrans;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $prixUnitaire;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitConditionnement::class, inversedBy="produitCondTrans")
     * @ORM\JoinColumn(nullable=false)
     */
    private $produitCond;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTransfert(): ?Transfert
    {
        return $this->transfert;
    }

    public function setTransfert(?Transfert $transfert): self
    {
        $this->transfert = $transfert;

        return $this;
    }

    public function getQteCondTrans(): ?string
    {
        return $this->qteCondTrans;
    }

    public function setQteCondTrans(string $qteCondTrans): self
    {
        $this->qteCondTrans = $qteCondTrans;

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
