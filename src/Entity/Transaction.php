<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\TransactionRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;
use Gedmo\Timestampable\Traits\TimestampableEntity;
use App\AjaxifySearch\Annotation\AjaxifySearch;

/**
 * @ORM\Entity(repositoryClass=TransactionRepository::class)
 * @ORM\HasLifecycleCallbacks
 * @AjaxifySearch(
 *     alias = "transac",
 *     itemTemplate = "transaction/partials/item.html.twig",
 *     relations = { "client", "typeOperation", "compteBanque", "modePaiement" },
 *     searchables = {
 *          "refTransac", "montantTransac", "typeOperation.libelle", "client.nom", "client.prenom",
 *          "modePaiement.libelle", "banque.sigle", "banque.denominationBanque", "compteBanque.numeroCompteBQ"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class Transaction
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
    private $dateTransac;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $refTransac;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantTransac;

    /**
     * @ORM\ManyToOne(targetEntity=TypeOperation::class, inversedBy="transactions")
     * @ORM\JoinColumn(nullable=false)
     */
    private $typeOperation;

    /**
     * @ORM\ManyToOne(targetEntity=Client::class, inversedBy="transactions",cascade={"persist"})
     */
    private $client;

    /**
     * @ORM\ManyToOne(targetEntity=Compte::class, inversedBy="transactions")
     * @ORM\JoinColumn(nullable=true)
     */
    private $compte;

    /**
     * @ORM\OneToMany(targetEntity=Paiement::class, mappedBy="transaction")
     */
    private $paiements;

    /**
     * @ORM\ManyToOne(targetEntity=ModePaiement::class, inversedBy="transactions")
     * @ORM\JoinColumn(nullable=true)
     */
    private $modePaiement;

    /**
     * @ORM\Column(type="string", length=100, nullable=true)
     */
    private $numeroMobileMoney;

    /**
     * @ORM\ManyToOne(targetEntity=CompteBanque::class, inversedBy="transactions")
     */
    private $compteBanque;
    
    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=Caisse::class, inversedBy="transactions",cascade={"persist"})
     */
    private $caisse;

    /** 
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="transactions",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $motif;

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
        $this->dateTransac = new \DateTime();
        $this->paiements = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateTransac(): ?\DateTimeInterface
    {
        return $this->dateTransac;
    }

    public function setDateTransac(\DateTimeInterface $dateTransac): self
    {
        $this->dateTransac = $dateTransac;

        return $this;
    }

    public function getRefTransac(): ?string
    {
        return $this->refTransac;
    }

    public function setRefTransac(?string $refTransac): self
    {
        $this->refTransac = $refTransac;

        return $this;
    }

    public function getMontantTransac(): ?string
    {
        return $this->montantTransac;
    }

    public function setMontantTransac(string $montantTransac): self
    {
        $this->montantTransac = $montantTransac;

        return $this;
    }

    public function getTypeOperation(): ?TypeOperation
    {
        return $this->typeOperation;
    }

    public function setTypeOperation(?TypeOperation $typeOperation): self
    {
        $this->typeOperation = $typeOperation;

        return $this;
    }

    public function getClient(): ?Client
    {
        return $this->client;
    }

    public function setClient(?Client $client): self
    {
        $this->client = $client;

        return $this;
    }

    public function getCompte(): ?Compte
    {
        return $this->compte;
    }

    public function setCompte(?Compte $compte): self
    {
        $this->compte = $compte;

        return $this;
    }

    /**
     * @return Collection<int, Paiement>
     */
    public function getPaiements(): Collection
    {
        return $this->paiements;
    }

    public function addPaiement(Paiement $paiement): self
    {
        if (!$this->paiements->contains($paiement)) {
            $this->paiements[] = $paiement;
            $paiement->setTransaction($this);
        }

        return $this;
    }

    public function removePaiement(Paiement $paiement): self
    {
        if ($this->paiements->removeElement($paiement)) {
            // set the owning side to null (unless already changed)
            if ($paiement->getTransaction() === $this) {
                $paiement->setTransaction(null);
            }
        }

        return $this;
    }

    public function getModePaiement(): ?ModePaiement
    {
        return $this->modePaiement;
    }

    public function setModePaiement(?ModePaiement $modePaiement): self
    {
        $this->modePaiement = $modePaiement;

        return $this;
    }

    public function getNumeroMobileMoney(): ?string
    {
        return $this->numeroMobileMoney;
    }

    public function setNumeroMobileMoney(?string $numeroMobileMoney): self
    {
        $this->numeroMobileMoney = $numeroMobileMoney;

        return $this;
    }

    public function getCompteBanque(): ?CompteBanque
    {
        return $this->compteBanque;
    }

    public function setCompteBanque(?CompteBanque $compteBanque): self
    {
        $this->compteBanque = $compteBanque;

        return $this;
    }

    public function getCaisse(): ?Caisse
    {
        return $this->caisse;
    }

    public function setCaisse(?Caisse $caisse): self
    {
        $this->caisse = $caisse;
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

    public function getMotif(): ?string
    {
        return $this->motif;
    }

    public function setMotif(?string $motif): self
    {
        $this->motif = $motif;

        return $this;
    }

}
