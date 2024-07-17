<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\ClientRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;
use phpDocumentor\Reflection\Types\This;

/**
 * @ORM\Entity(repositoryClass=ClientRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Client
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255, nullable=true,options={"default":""})
     */
    private $nom;

    /**
     * @ORM\Column(type="string", length=255, nullable=true,options={"default":""})
     */
    private $prenom;

    /**
     * @ORM\Column(type="string", length=255, nullable=true,options={"default":""})
     */
    private $adresse;

    /**
     * @ORM\Column(type="string", length=255, nullable=true,options={"default":""})
     */
    private $email;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $telephone1;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $telephone2;

    /**
     * @ORM\Column(type="string", length=255, nullable=true,options={"default":""})
     */
    private $raisonSociale;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $ifu;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $rccm;

    /**
     * @ORM\Column(type="string", length=255, nullable=true,options={"default":""})
     */
    private $sigle;

    /**
     * @ORM\Column(type="string", length=255, nullable=true,options={"default":""})
     */
    private $denomination;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $statut;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $dateNais;

    /**
     * @ORM\OneToMany(targetEntity=CommandeClient::class, mappedBy="acheteur", orphanRemoval=true)
     */
    private $commandeClients;

    /**
     * @ORM\OneToMany(targetEntity=Transaction::class, mappedBy="client")
     */
    private $transactions;

    /**
     * @ORM\OneToMany(targetEntity=Compte::class, mappedBy="client")
     */
    private $comptes;

    /**
     * @ORM\OneToMany(targetEntity=AdresseLivraison::class, mappedBy="client", cascade={"persist"})
     */
    private $adresseLivraisons;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="clients")
     */
    private $pointVente;


     /**
     * @ORM\OneToMany(targetEntity=FactureProforma::class, mappedBy="acheteur")
     */
    private $factureProformas;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $nomClient;

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
        $this->commandeClients = new ArrayCollection();
        $this->transactions = new ArrayCollection();
        $this->comptes = new ArrayCollection();
        $this->adresseLivraisons = new ArrayCollection();
        $this->factureProformas = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTelephone1(): ?string
    {
        return $this->telephone1;
    }

    public function setTelephone1(?string $telephone1): self
    {
        $this->telephone1 = $telephone1;

        return $this;
    }

    public function getTelephone2(): ?string
    {
        return $this->telephone2;
    }

    public function setTelephone2(?string $telephone2): self
    {
        $this->telephone2 = $telephone2;

        return $this;
    }

    public function getRaisonSociale(): ?string
    {
        return $this->raisonSociale;
    }

    public function setRaisonSociale(?string $raisonSociale): self
    {
        $this->raisonSociale = $raisonSociale;
        return $this;
    }

    public function getIfu(): ?string
    {
        return $this->ifu;
    }

    public function setIfu(?string $ifu): self
    {
        $this->ifu = $ifu;

        return $this;
    }

    public function getRccm(): ?string
    {
        return $this->rccm;
    }

    public function setRccm(?string $rccm): self
    {
        $this->rccm = $rccm;

        return $this;
    }

    public function getSigle(): ?string
    {
        return $this->sigle;
    }

    public function setSigle(?string $sigle): self
    {
        $this->sigle = $sigle;

        return $this;
    }

    public function getDenomination(): ?string
    {
        return $this->denomination;
    }

    public function setDenomination(?string $denomination): self
    {
        $this->denomination = $denomination;

        return $this;
    }

    public function getStatut(): ?string
    {
        return $this->statut;
    }

    public function setStatut(?string $statut): self
    {
        $this->statut = $statut;

        return $this;
    }

    public function getNom(): ?string
    {
        return $this->nom;
    }

    public function setNom(string $nom): self
    {
        $this->nom = $nom;

        return $this;
    }

    public function getPrenom(): ?string
    {
        return $this->prenom;
    }

    public function setPrenom(string $prenom): self
    {
        $this->prenom = $prenom;

        return $this;
    }

    public function getAdresse(): ?string
    {
        return $this->adresse;
    }

    public function setAdresse(?string $adresse): self
    {
        $this->adresse = $adresse;

        return $this;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(?string $email): self
    {
        $this->email = $email;

        return $this;
    }

    public function getDateNais(): ?\DateTimeInterface
    {
        return $this->dateNais;
    }

    public function setDateNais(?\DateTimeInterface $dateNais): self
    {
        $this->dateNais = $dateNais;

        return $this;
    }

    /**
     * @return Collection<int, CommandeClient>
     */
    public function getCommandeClients(): Collection
    {
        return $this->commandeClients;
    }

    public function addCommandeClient(CommandeClient $commandeClient): self
    {
        if (!$this->commandeClients->contains($commandeClient)) {
            $this->commandeClients[] = $commandeClient;
            $commandeClient->setAcheteur($this);
        }

        return $this;
    }

    public function removeCommandeClient(CommandeClient $commandeClient): self
    {
        if ($this->commandeClients->removeElement($commandeClient)) {
            // set the owning side to null (unless already changed)
            if ($commandeClient->getAcheteur() === $this) {
                $commandeClient->setAcheteur(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Transaction>
     */
    public function getTransactions(): Collection
    {
        return $this->transactions;
    }

    public function addTransaction(Transaction $transaction): self
    {
        if (!$this->transactions->contains($transaction)) {
            $this->transactions[] = $transaction;
            $transaction->setClient($this);
        }

        return $this;
    }

    public function removeTransaction(Transaction $transaction): self
    {
        if ($this->transactions->removeElement($transaction)) {
            // set the owning side to null (unless already changed)
            if ($transaction->getClient() === $this) {
                $transaction->setClient(null);
            }
        }
        return $this;
    }

    /**
     * @return Collection<int, Compte>
     */
    public function getComptes(): Collection
    {
        return $this->comptes;
    }

    public function addCompte(Compte $compte): self
    {
        if (!$this->comptes->contains($compte)) {
            $this->comptes[] = $compte;
            $compte->setClient($this);
        }

        return $this;
    }

    public function removeCompte(Compte $compte): self
    {
        if ($this->comptes->removeElement($compte)) {
            // set the owning side to null (unless already changed)
            if ($compte->getClient() === $this) {
                $compte->setClient(null);
            }
        }

        return $this;
    }

    public function __toString()
    {
        $lib="";
        if($this->statut=="Physique"){
            $lib = $this->nom . " " . $this->prenom;
        }else{
            $lib = $this->denomination.' [' . $this->sigle .']';
        }
        return $lib;
    }

    /**
     * @return Collection<int, AdresseLivraison>
     */
    public function getAdresseLivraisons(): Collection
    {
        return $this->adresseLivraisons;
    }

    public function addAdresseLivraison(AdresseLivraison $adresseLivraison): self
    {
        if (!$this->adresseLivraisons->contains($adresseLivraison)) {
            $this->adresseLivraisons[] = $adresseLivraison;
            $adresseLivraison->setClient($this);
        }

        return $this;
    }

    public function removeAdresseLivraison(AdresseLivraison $adresseLivraison): self
    {
        if ($this->adresseLivraisons->removeElement($adresseLivraison)) {
            // set the owning side to null (unless already changed)
            if ($adresseLivraison->getClient() === $this) {
                $adresseLivraison->setClient(null);
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

    /**
     * @return Collection<int, FactureProforma>
     */
    public function getFactureProformas(): Collection
    {
        return $this->factureProformas;
    }

    public function addFactureProforma(FactureProforma $factureProforma): self
    {
        if (!$this->factureProformas->contains($factureProforma)) {
            $this->factureProformas[] = $factureProforma;
            $factureProforma->setAcheteur($this);
        }

        return $this;
    }

    public function removeFactureProforma(FactureProforma $factureProforma): self
    {
        if ($this->factureProformas->removeElement($factureProforma)) {
            // set the owning side to null (unless already changed)
            if ($factureProforma->getAcheteur() === $this) {
                $factureProforma->setAcheteur(null);
            }
        }

        return $this;
    }

    public function getNomClient(): ?string
    {
        return $this->nomClient;
    }

    public function setNomClient(?string $nomClient): self
    {
        $this->nomClient = $nomClient;

        return $this;
    }
}
