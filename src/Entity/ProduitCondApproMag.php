<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\ProduitCondApproMagRepository;

/**
 * @ORM\Entity(repositoryClass=ProduitCondApproMagRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class ProduitCondApproMag
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
    private $qteCondAppro;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $carton;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $piece;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $prixAchat;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $montantCond;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitConditionnement::class, inversedBy="produitCondApproMags")
     * @ORM\JoinColumn(nullable=false)
     */
    private $produitConditionnement;

    /**
     * @ORM\ManyToOne(targetEntity=ApproMagasin::class, inversedBy="produitCondApproMags")
     * @ORM\JoinColumn(nullable=false)
     */
    private $approMagasin;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getProduitConditionnement(): ?ProduitConditionnement
    {
        return $this->produitConditionnement;
    }

    public function setProduitConditionnement(?ProduitConditionnement $produitConditionnement): self
    {
        $this->produitConditionnement = $produitConditionnement;

        return $this;
    }

    public function getApproMagasin(): ?ApproMagasin
    {
        return $this->approMagasin;
    }

    public function setApproMagasin(?ApproMagasin $approMagasin): self
    {
        $this->approMagasin = $approMagasin;

        return $this;
    }

    public function getQteCondAppro(): ?string
    {
        return $this->qteCondAppro;
    }

    public function setQteCondAppro(string $qteCondAppro): self
    {
        $this->qteCondAppro = $qteCondAppro;

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

    public function getPrixAchat(): ?string
    {
        return $this->prixAchat;
    }

    public function setPrixAchat(string $prixAchat): self
    {
        $this->prixAchat = $prixAchat;

        return $this;
    }

    public function getCarton(): ?string
    {
        return $this->carton;
    }

    public function setCarton(?string $carton): self
    {
        $this->carton = $carton;

        return $this;
    }

    public function getPiece(): ?string
    {
        return $this->piece;
    }

    public function setPiece(?string $piece): self
    {
        $this->piece = $piece;

        return $this;
    }
}
