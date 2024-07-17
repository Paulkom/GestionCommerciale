<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use Doctrine\Common\Collections\Collection;
use App\Repository\ConditionnementRepository;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=ConditionnementRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Conditionnement
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
    private $codeCond;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $libelleCond;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $valeur;

    /**
     * @ORM\OneToMany(targetEntity=ProduitConditionnement::class, mappedBy="conditionnement", orphanRemoval=true)
     */
    private $produitConditionnements;

    // /**
    //  * @ORM\OneToMany(targetEntity=ProduitCondDdp::class, mappedBy="conditionnement")
    //  */
    // private $produitCondDdps;

    // /**
    //  * @ORM\OneToMany(targetEntity=ProduitCondComFrs::class, mappedBy="conditionnement")
    //  */
    // private $produitCondComFrs;

    // /**
    //  * @ORM\OneToMany(targetEntity=ProduitCondFacture::class, mappedBy="conditionnement")
    //  */
    // private $produitCondFactures;

    // /**
    //  * @ORM\OneToMany(targetEntity=ProduitCondMagLiv::class, mappedBy="conditionnement")
    //  */
    // private $produitCondMagLivs;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="conditionnements",cascade={"persist"})
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
        $this->produitConditionnements = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCodeCond(): ?string
    {
        return $this->codeCond;
    }

    public function setCodeCond(string $codeCond): self
    {
        $this->codeCond = $codeCond;

        return $this;
    }

    public function getLibelleCond(): ?string
    {
        return $this->libelleCond;
    }

    public function setLibelleCond(string $libelleCond): self
    {
        $this->libelleCond = $libelleCond;

        return $this;
    }

    /**
     * @return Collection<int, ProduitConditionnement>
     */
    public function getProduitConditionnements(): Collection
    {
        return $this->produitConditionnements;
    }

    public function addProduitConditionnement(ProduitConditionnement $produitConditionnement): self
    {
        if (!$this->produitConditionnements->contains($produitConditionnement)) {
            $this->produitConditionnements[] = $produitConditionnement;
            $produitConditionnement->setConditionnement($this);
        }

        return $this;
    }

    public function removeProduitConditionnement(ProduitConditionnement $produitConditionnement): self
    {
        if ($this->produitConditionnements->removeElement($produitConditionnement)) {
            // set the owning side to null (unless already changed)
            if ($produitConditionnement->getConditionnement() === $this) {
                $produitConditionnement->setConditionnement(null);
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

    public function getValeur(): ?string
    {
        return $this->valeur;
    }

    public function setValeur(string $valeur): self
    {
        $this->valeur = $valeur;

        return $this;
    }

    
}
