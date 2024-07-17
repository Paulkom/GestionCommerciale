<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\LivraisonRepository;
use DateTime;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=LivraisonRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Livraison
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
    private $dateLiv;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2,nullable=true)
     */
    private $montantLiv;

    /**
     * @ORM\ManyToOne(targetEntity=CommandeClient::class, inversedBy="livraisons")
     * @ORM\JoinColumn(nullable=false)
     */
    private $commandeCli;

    /**
     * @ORM\ManyToOne(targetEntity=Personnel::class, inversedBy="livraisons")
     * @ORM\JoinColumn(nullable=false)
     */
    private $livreur;

    /**
     * @ORM\OneToMany(targetEntity=LivraisonMagasin::class, mappedBy="livraison",cascade={"persist"})
     */
    private $livraisonMagasins;

    /**
     * @ORM\Column(type="string", length=100)
     */
    private $refLiv;
    
    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="livraisons",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\ManyToOne(targetEntity=Utilisateur::class, inversedBy="livraisons")
     */
    private $operateur;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $totalResteAliv;

    /**
     * @ORM\ManyToOne(targetEntity=ModelSignataire::class, inversedBy="livraisons")
     */
    private $modelSignataire;

    public function __construct()
    {
        $this->livraisonMagasins = new ArrayCollection();
        $this->dateLiv= new DateTime('now');
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateLiv(): ?\DateTimeInterface
    {
        return $this->dateLiv;
    }

    public function setDateLiv(\DateTimeInterface $dateLiv): self
    {
        $this->dateLiv = $dateLiv;

        return $this;
    }

    public function getMontantLiv(): ?string
    {
        return $this->montantLiv;
    }

    public function setMontantLiv(string $montantLiv): self
    {
        $this->montantLiv = $montantLiv;

        return $this;
    }

    public function getCommandeCli(): ?CommandeClient
    {
        return $this->commandeCli;
    }

    public function setCommandeCli(?CommandeClient $commandeCli): self
    {
        $this->commandeCli = $commandeCli;
        return $this;
    }

    public function getLivreur(): ?Personnel
    {
        return $this->livreur;
    }

    public function setLivreur(?Personnel $livreur): self
    {
        $this->livreur = $livreur;
        return $this;
    }

    /**
     * @return Collection<int, LivraisonMagasin>
     */
    public function getLivraisonMagasins(): Collection
    {
        return $this->livraisonMagasins;
    }

    public function addLivraisonMagasin(LivraisonMagasin $livraisonMagasin): self
    {
        if (!$this->livraisonMagasins->contains($livraisonMagasin)) {
            $this->livraisonMagasins[] = $livraisonMagasin;
            $livraisonMagasin->setLivraison($this);
        }

        return $this;
    }

    public function removeLivraisonMagasin(LivraisonMagasin $livraisonMagasin): self
    {
        if ($this->livraisonMagasins->removeElement($livraisonMagasin)) {
            // set the owning side to null (unless already changed)
            if ($livraisonMagasin->getLivraison() === $this) {
                $livraisonMagasin->setLivraison(null);
            }
        }

        return $this;
    }


    public function getRefLiv(): ?string
    {
        return $this->refLiv;
    }

    public function setRefLiv(string $refLiv): self
    {
        $this->refLiv = $refLiv;
        return $this;
    }

    public function getEstSup(): ?bool
    {
        return $this->estSup;
    }

    public function setEstSup(?bool $estSup): self
    {
        $this->estSup = $estSup;

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

    public function getOperateur(): ?Utilisateur
    {
        return $this->operateur;
    }

    public function setOperateur(?Utilisateur $operateur): self
    {
        $this->operateur = $operateur;

        return $this;
    }

    public function getTotalResteAliv(): ?string
    {
        return $this->totalResteAliv;
    }

    public function setTotalResteAliv(string $totalResteAliv): self
    {
        $this->totalResteAliv = $totalResteAliv;

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
