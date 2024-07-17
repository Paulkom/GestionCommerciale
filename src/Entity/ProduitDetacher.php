<?php

namespace App\Entity;

use App\Repository\ProduitDetacherRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ProduitDetacherRepository::class)
 */
class ProduitDetacher
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitConditionnement::class, inversedBy="produitDetachers")
     */
    private $cible;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $quantite;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitCondMag::class, inversedBy="produitDetachers",cascade={"persist"})
     */
    private $produitCondMag;

    /**
     * @ORM\ManyToOne(targetEntity=Detachement::class, inversedBy="produitDetachers",cascade={"persist"})
     */
    private $detachement;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $quantiteCible;

    public function __construct() {
        $this->quantite = 1;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCible(): ?ProduitConditionnement
    {
        return $this->cible;
    }

    public function setCible(?ProduitConditionnement $cible): self
    {
        $this->cible = $cible;

        return $this;
    }

    public function getQuantite(): ?string
    {
        return $this->quantite;
    }

    public function setQuantite(string $quantite): self
    {
        $this->quantite = $quantite;
        return $this;
    }

    public function getProduitCondMag(): ?ProduitCondMag
    {
        return $this->produitCondMag;
    }

    public function setProduitCondMag(?ProduitCondMag $produitCondMag): self
    {
        $this->produitCondMag = $produitCondMag;
        return $this;
    }

    public function getDetachement(): ?Detachement
    {
        return $this->detachement;
    }

    public function setDetachement(?Detachement $detachement): self
    {
        $this->detachement = $detachement;
        return $this;
    }

    public function getQuantiteCible(): ?string
    {
        return $this->quantiteCible;
    }

    public function setQuantiteCible(string $quantiteCible): self
    {
        $this->quantiteCible = $quantiteCible;
        return $this;
    }
}
