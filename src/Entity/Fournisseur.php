<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\FournisseurRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;
use Gedmo\Timestampable\Traits\TimestampableEntity;

/**
 * @ORM\Entity(repositoryClass=FournisseurRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Fournisseur
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $nom;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $prenoms;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $adresse;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $email;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $tel1;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $tel2;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $dateNais;

    /**
     * @ORM\Column(type="string", length=255, nullable=true,options={"default":""})
     */
    private $denomination;

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
     * @ORM\Column(type="string", length=255)
     */
    private $statut;

    /**
     * @ORM\OneToMany(targetEntity=CommandeFrs::class, mappedBy="fournisseur")
     */
    private $commandeFrs;

    /**
     * @ORM\OneToMany(targetEntity=Compte::class, mappedBy="fournisseur")
     */
    private $comptes;

    /**
     * @ORM\OneToMany(targetEntity=DemandeDePrix::class, mappedBy="fournisseur", orphanRemoval=true)
     */
    private $demandeDePrixes;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="fournisseurs",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\OneToMany(targetEntity=Approvisionnement::class, mappedBy="fournisseur")
     */
    private $approvisionnements;

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
        $this->commandeFrs = new ArrayCollection();
        $this->comptes = new ArrayCollection();
        $this->demandeDePrixes = new ArrayCollection();
        $this->approvisionnements = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
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

    public function getPrenoms(): ?string
    {
        return $this->prenoms;
    }

    public function setPrenoms(string $prenoms): self
    {
        $this->prenoms = $prenoms;

        return $this;
    }

    public function getAdresse(): ?string
    {
        return $this->adresse;
    }

    public function setAdresse(string $adresse): self
    {
        $this->adresse = $adresse;

        return $this;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): self
    {
        $this->email = $email;

        return $this;
    }

    public function getTel1(): ?string
    {
        return $this->tel1;
    }

    public function setTel1(string $tel1): self
    {
        $this->tel1 = $tel1;

        return $this;
    }

    public function getTel2(): ?string
    {
        return $this->tel2;
    }

    public function setTel2(string $tel2): self
    {
        $this->tel2 = $tel2;

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

    public function getStatut(): ?string
    {
        return $this->statut;
    }

    public function setStatut(string $statut): self
    {
        $this->statut = $statut;

        return $this;
    }

    /**
     * @return Collection<int, CommandeFrs>
     */
    public function getCommandeFrs(): Collection
    {
        return $this->commandeFrs;
    }

    public function addCommandeFr(CommandeFrs $commandeFr): self
    {
        if (!$this->commandeFrs->contains($commandeFr)) {
            $this->commandeFrs[] = $commandeFr;
            $commandeFr->setFournisseur($this);
        }

        return $this;
    }

    public function removeCommandeFr(CommandeFrs $commandeFr): self
    {
        if ($this->commandeFrs->removeElement($commandeFr)) {
            // set the owning side to null (unless already changed)
            if ($commandeFr->getFournisseur() === $this) {
                $commandeFr->setFournisseur(null);
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
            $compte->setFournisseur($this);
        }

        return $this;
    }

    public function removeCompte(Compte $compte): self
    {
        if ($this->comptes->removeElement($compte)) {
            // set the owning side to null (unless already changed)
            if ($compte->getFournisseur() === $this) {
                $compte->setFournisseur(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, DemandeDePrix>
     */
    public function getDemandeDePrixes(): Collection
    {
        return $this->demandeDePrixes;
    }

    public function addDemandeDePrix(DemandeDePrix $demandeDePrix): self
    {
        if (!$this->demandeDePrixes->contains($demandeDePrix)) {
            $this->demandeDePrixes[] = $demandeDePrix;
            $demandeDePrix->setFournisseur($this);
        }

        return $this;
    }

    public function removeDemandeDePrix(DemandeDePrix $demandeDePrix): self
    {
        if ($this->demandeDePrixes->removeElement($demandeDePrix)) {
            // set the owning side to null (unless already changed)
            if ($demandeDePrix->getFournisseur() === $this) {
                $demandeDePrix->setFournisseur(null);
            }
        }

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
     * @return Collection<int, Approvisionnement>
     */
    public function getApprovisionnements(): Collection
    {
        return $this->approvisionnements;
    }

    public function addApprovisionnement(Approvisionnement $approvisionnement): self
    {
        if (!$this->approvisionnements->contains($approvisionnement)) {
            $this->approvisionnements[] = $approvisionnement;
            $approvisionnement->setFournisseur($this);
        }

        return $this;
    }

    public function removeApprovisionnement(Approvisionnement $approvisionnement): self
    {
        if ($this->approvisionnements->removeElement($approvisionnement)) {
            // set the owning side to null (unless already changed)
            if ($approvisionnement->getFournisseur() === $this) {
                $approvisionnement->setFournisseur(null);
            }
        }

        return $this;
    }
}
