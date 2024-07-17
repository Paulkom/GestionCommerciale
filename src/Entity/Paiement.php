<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\PaiementRepository;
use DateTime;

/**
 * @ORM\Entity(repositoryClass=PaiementRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Paiement
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
    private $datePaie;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantPaye;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2)
     */
    private $montantRAPayer;

    /**
     * @ORM\ManyToOne(targetEntity=ModePaiement::class, inversedBy="paiements")
     * @ORM\JoinColumn(nullable=false)
     */
    private $modePaiement;

    /**
     * @ORM\ManyToOne(targetEntity=Facture::class, inversedBy="paiements")
     */
    private $facture;

    /**
     * @ORM\ManyToOne(targetEntity=Transaction::class, inversedBy="paiements")
     */
    private $transaction;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $refPaie;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $numeroMobileMoney;

    /**
     * @ORM\ManyToOne(targetEntity=Banque::class, inversedBy="paiements")
     */
    private $banque;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $refOperation;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, options={"default":0}, nullable=true)
     */
    private $montantRecu;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=0, options={"default":0}, nullable=true)
     */
    private $reliquat;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=Caisse::class, inversedBy="paiements",cascade={"persist"})
     */
    private $caisse;
    /** 
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="paiements",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\ManyToOne(targetEntity=Utilisateur::class, inversedBy="paiements")
     */
    private $operateur;

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
        $this->datePaie= new DateTime('now');
       
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDatePaie(): ?\DateTimeInterface
    {
        return $this->datePaie;
    }

    public function setDatePaie(\DateTimeInterface $datePaie): self
    {
        $this->datePaie = $datePaie;

        return $this;
    }

    public function getMontantPaye(): ?string
    {
        return $this->montantPaye;
    }

    public function setMontantPaye(string $montantPaye): self
    {
        $this->montantPaye = $montantPaye;

        return $this;
    }

    public function getMontantRAPayer(): ?string
    {
        return $this->montantRAPayer;
    }

    public function setMontantRAPayer(string $montantRAPayer): self
    {
        $this->montantRAPayer = $montantRAPayer;

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

    public function getFacture(): ?Facture
    {
        return $this->facture;
    }

    public function setFacture(?Facture $facture): self
    {
        $this->facture = $facture;

        return $this;
    }

    public function getTransaction(): ?Transaction
    {
        return $this->transaction;
    }

    public function setTransaction(?Transaction $transaction): self
    {
        $this->transaction = $transaction;

        return $this;
    }

    public function getRefPaie(): ?string
    {
        return $this->refPaie;
    }

    public function setRefPaie(string $refPaie): self
    {
        $this->refPaie = $refPaie;

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

    public function getBanque(): ?Banque
    {
        return $this->banque;
    }

    public function setBanque(?Banque $banque): self
    {
        $this->banque = $banque;

        return $this;
    }

    public function getRefOperation(): ?string
    {
        return $this->refOperation;
    }

    public function setRefOperation(?string $refOperation): self
    {
        $this->refOperation = $refOperation;

        return $this;
    }

    public function getMontantRecu(): ?string
    {
        return $this->montantRecu;
    }

    public function setMontantRecu(string $montantRecu): self
    {
        $this->montantRecu = $montantRecu;

        return $this;
    }

    public function getReliquat(): ?string
    {
        return $this->reliquat;
    }

    public function setReliquat(string $reliquat): self
    {
        $this->reliquat = $reliquat;

        return $this;
    }

   
    /**
     * ********************Test*************************************
     */

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

    

    public function getOperateur(): ?Utilisateur
    {
        return $this->operateur;
    }

    public function setOperateur(?Utilisateur $operateur): self
    {
        $this->operateur = $operateur;

        return $this;
    }
}
