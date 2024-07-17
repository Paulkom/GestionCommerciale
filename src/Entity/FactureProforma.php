<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use Doctrine\Common\Collections\Collection;
use App\Repository\FactureProformaRepository;
use DateTime;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=FactureProformaRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class FactureProforma
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="datetime")
     */
    private $dateFactpro;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantHt;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantTtc;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $montantTotal;

    /**
     * @ORM\ManyToOne(targetEntity=Client::class, inversedBy="factureProformas")
     * @ORM\JoinColumn(nullable=false)
     */
    private $acheteur;


    /**
     * @ORM\Column(type="string", length=100, nullable=true)
     */
    private $refFactpro;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true,options={"default":0})
     */
    private $montantRest;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $typeRemise;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $remise;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $valeurRemise;

     /**
     * @ORM\OneToMany(targetEntity=ProduitCondFacture::class, mappedBy="factureProforma",cascade={"persist"})
     */
    private $produitCondFactures;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0)
     */
    private $montantHtToAprRse;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="factureProformas",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, nullable=true)
     */
    private $montantTva;

    /**
     * @ORM\ManyToOne(targetEntity=Utilisateur::class, inversedBy="factureProformas")
     */
    private $operateur;

    /**
     * @ORM\ManyToOne(targetEntity=ModelSignataire::class, inversedBy="factureProformas")
     */
    private $modelSignataire;

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
        $this->produitCondFactures = new ArrayCollection();
        $this->dateFactpro= new DateTime('now');
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateFactpro(): ?\DateTimeInterface
    {
        return $this->dateFactpro;
    }

    public function setDateFactpro(\DateTimeInterface $dateFactpro): self
    {
        $this->dateFactpro = $dateFactpro;

        return $this;
    }

    public function getMontantHt(): ?string
    {
        return $this->montantHt;
    }

    public function setMontantHt(string $montantHt): self
    {
        $this->montantHt = $montantHt;

        return $this;
    }

    public function getMontantTtc(): ?string
    {
        return $this->montantTtc;
    }

    public function setMontantTtc(string $montantTtc): self
    {
        $this->montantTtc = $montantTtc;

        return $this;
    }

    public function getMontantTotal(): ?string
    {
        return $this->montantTotal;
    }

    public function setMontantTotal(string $montantTotal): self
    {
        $this->montantTotal = $montantTotal;
        return $this;
    }

    public function getAcheteur(): ?Client
    {
        return $this->acheteur;
    }

    public function setAcheteur(?Client $acheteur): self
    {
        $this->acheteur = $acheteur;

        return $this;
    }


    public function getRefFactpro(): ?string
    {
        return $this->refFactpro;
    }

    public function setRefFactpro(?string $refFactpro): self
    {
        $this->refFactpro = $refFactpro;

        return $this;
    }

    public function __toString()
    {
        $lib="";
        $lib = $this->getRefFactpro().' [ '.$this->getAcheteur() .' ]';
        return $lib;
    }

    public function getMontantRest(): ?string
    {
        return $this->montantRest;
    }

    public function setMontantRest(?string $montantRest): self
    {
        $this->montantRest = $montantRest;

        return $this;
    }

    public function getTypeRemise(): ?string
    {
        return $this->typeRemise;
    }

    public function setTypeRemise(string $typeRemise): self
    {
        $this->typeRemise = $typeRemise;

        return $this;
    }

    public function getRemise(): ?string
    {
        return $this->remise;
    }

    public function setRemise(string $remise): self
    {
        $this->remise = $remise;

        return $this;
    }

    public function getValeurRemise(): ?string
    {
        return $this->valeurRemise;
    }

    public function setValeurRemise(?string $valeurRemise): self
    {
        $this->valeurRemise = $valeurRemise;

        return $this;
    }

    public function getMontantHtToAprRse(): ?string
    {
        return $this->montantHtToAprRse;
    }

    public function setMontantHtToAprRse(string $montantHtToAprRse): self
    {
        $this->montantHtToAprRse = $montantHtToAprRse;

        return $this;
    }

     /**
     * @return Collection<int, ProduitCondFacture>
     */
    public function getProduitCondFactures(): Collection
    {
        return $this->produitCondFactures;
    }

    public function addProduitCondFacture(ProduitCondFacture $produitCondFacture): self
    {
        if (!$this->produitCondFactures->contains($produitCondFacture)) {
            $this->produitCondFactures[] = $produitCondFacture;
            $produitCondFacture->setFactureProforma($this);
        }
        return $this;
    }

    public function removeProduitCondFacture(ProduitCondFacture $produitCondFacture): self
    {
        if ($this->produitCondFactures->removeElement($produitCondFacture)) {
            // set the owning side to null (unless already changed)
            if ($produitCondFacture->getFactureProforma() === $this) {
                $produitCondFacture->setFactureProforma(null);
            }
        }

        return $this;
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

    public function getMontantTva(): ?string
    {
        return $this->montantTva;
    }

    public function setMontantTva(?string $montantTva): self
    {
        $this->montantTva = $montantTva;

        return $this;
    }

    public function getOperateur(): ?Utilisateur
    {
        return $this->operateur;
    }

    public function setOperateur(?Utilisateur $operateur): self
    {
        $this->operateur = $operateur;

        return $this;
    }

    public function getModelSignataire(): ?ModelSignataire
    {
        return $this->modelSignataire;
    }

    public function setModelSignataire(?ModelSignataire $modelSignataire): self
    {
        $this->modelSignataire = $modelSignataire;

        return $this;
    }

}
