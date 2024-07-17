<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\ProduitCondMagLivRepository;

/**
 * @ORM\Entity(repositoryClass=ProduitCondMagLivRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class ProduitCondMagLiv
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
    private $qteLiv;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $qteRALiv;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2,nullable=true)
     */
    private $montantCond;
   
    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $qteALiv;

    /**
     * @ORM\ManyToOne(targetEntity=LivraisonMagasin::class, inversedBy="produitCondMagLivs")
     */
    private $livraisonMag;

    /**
     * @ORM\ManyToOne(targetEntity=ProduitCondComClit::class, inversedBy="produitCondMagLivs")
     */
    private $produitComClit;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0,nullable=false)
     */
    private $prix;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $carton;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $piece;

   

    public function getId(): ?int
    {
        return $this->id;
    }


    public function getQteLiv(): ?string
    {
        return $this->qteLiv;
    }

    public function setQteLiv(string $qteLiv): self
    {
        $this->qteLiv = $qteLiv;

        return $this;
    }

    public function getQteRALiv(): ?string
    {
        return $this->qteRALiv;
    }

    public function setQteRALiv(string $qteRALiv): self
    {
        $this->qteRALiv = $qteRALiv;

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

   /* public function getProduit(): ?ProduitConditionnement
    {
        return $this->produit;
    }

    public function setProduit(?ProduitConditionnement $produit): self
    {
        $this->produit = $produit;

        return $this;
    }*/
    

    public function getLivraisonMag(): ?LivraisonMagasin
    {
        return $this->livraisonMag;
    }

    public function setLivraisonMag(?LivraisonMagasin $livraisonMag): self
    {
        $this->livraisonMag = $livraisonMag;

        return $this;
    }

    public function getProduitComClit(): ?ProduitCondComClit
    {
        return $this->produitComClit;
    }

    public function setProduitComClit(?ProduitCondComClit $produitComClit): self
    {
        $this->produitComClit = $produitComClit;
        return $this;
    }

    public function getPrix(): ?string
    {
        return $this->prix;
    }

    public function setPrix(string $prix): self
    {
        $this->prix = $prix;
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

    public function getQteALiv(): ?string
    {
        return $this->qteALiv;
    }

    public function setQteALiv(string $qteALiv): self
    {
        $this->qteALiv = $qteALiv;

        return $this;
    }


}
