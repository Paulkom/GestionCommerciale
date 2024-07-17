<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\SocieteRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=SocieteRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Societe
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="boolean")
     */
    private $estRegimeTPS;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $denomination;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $sigle;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $raisonSociale;

    /**
     * @ORM\Column(type="string", length=255, nullable=false)
     */
    private $ifu;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $rccm;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $adresse;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $telephone;

    /**
     * @ORM\OneToMany(targetEntity=CompteBanque::class, mappedBy="societe", cascade={"persist", "remove"}, orphanRemoval=true)
     */
    private $comptesBQ;

    /**
     * @ORM\OneToOne(targetEntity=Media::class, inversedBy="logoSociete", cascade={"persist", "remove"})
     * @ORM\JoinColumn(nullable=true)
     */
    private $logo;

    /**
     * @ORM\OneToOne(targetEntity=Media::class, inversedBy="enteteSociete", cascade={"persist", "remove"})
     * @ORM\JoinColumn(nullable=true)
     */
    private $entete;

    /**
     * @ORM\OneToOne(targetEntity=Media::class, inversedBy="piedDePageSociete", cascade={"persist", "remove"})
     * @ORM\JoinColumn(nullable=true)
     */
    private $piedDePage;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="societes",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $apiLink;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $apiNim;

    /**
     * @ORM\Column(type="text", nullable=true)
     */
    private $apiToken;

    /**
     * @ORM\Column(type="boolean")
     */
    private $estModeMecef;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $lieuImpression;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $messageCommercial;


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
        $this->comptesBQ = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDenomination(): ?string
    {
        return $this->denomination;
    }

    public function setDenomination(string $denomination): self
    {
        $this->denomination = $denomination;

        return $this;
    }

    public function getSigle(): ?string
    {
        return $this->sigle;
    }

    public function setSigle(string $sigle): self
    {
        $this->sigle = $sigle;

        return $this;
    }

    public function getRaisonSociale(): ?string
    {
        return $this->raisonSociale;
    }

    public function setRaisonSociale(string $raisonSociale): self
    {
        $this->raisonSociale = $raisonSociale;

        return $this;
    }


    public function getRccm(): ?string
    {
        return $this->rccm;
    }

    public function setRccm(string $rccm): self
    {
        $this->rccm = $rccm;

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

    public function __toString()
    {
        return $this->denomination;
    }

    /**
     * @return Collection<int, CompteBanque>
     */
    public function getComptesBQ(): Collection
    {
        return $this->comptesBQ;
    }

    public function addComptesBQ(CompteBanque $comptesBQ): self
    {
        if (!$this->comptesBQ->contains($comptesBQ)) {
            $this->comptesBQ[] = $comptesBQ;
            $comptesBQ->setSociete($this);
        }

        return $this;
    }

    public function removeComptesBQ(CompteBanque $comptesBQ): self
    {
        if ($this->comptesBQ->removeElement($comptesBQ)) {
            // set the owning side to null (unless already changed)
            if ($comptesBQ->getSociete() === $this) {
                $comptesBQ->setSociete(null);
            }
        }

        return $this;
    }

    public function getLogo(): ?Media
    {
        return $this->logo;
    }

    public function setLogo(?Media $logo): self
    {
        $this->logo = $logo;

        return $this;
    }

    public function getEntete(): ?Media
    {
        return $this->entete;
    }

    public function setEntete(?Media $entete): self
    {
        $this->entete = $entete;

        return $this;
    }

    public function getPiedDePage(): ?Media
    {
        return $this->piedDePage;
    }

    public function setPiedDePage(?Media $piedDePage): self
    {
        $this->piedDePage = $piedDePage;

        return $this;
    }

    public function getTelephone(): ?string
    {
        return $this->telephone;
    }

    public function setTelephone(string $telephone): self
    {
        $this->telephone = $telephone;

        return $this;
    }

    public function getEstRegimeTPS(): ?bool
    {
        return $this->estRegimeTPS;
    }

    public function setEstRegimeTPS(bool $estRegimeTPS): self
    {
        $this->estRegimeTPS = $estRegimeTPS;

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

    public function getIfu(): ?string
    {
        return $this->ifu;
    }

    public function setIfu(string $ifu): self
    {
        $this->ifu = $ifu;

        return $this;
    }

    public function getApiLink(): ?string
    {
        return $this->apiLink;
    }

    public function setApiLink(?string $apiLink): self
    {
        $this->apiLink = $apiLink;

        return $this;
    }

    public function getApiNim(): ?string
    {
        return $this->apiNim;
    }

    public function setApiNim(?string $apiNim): self
    {
        $this->apiNim = $apiNim;

        return $this;
    }

    public function getApiToken(): ?string
    {
        return $this->apiToken;
    }

    public function setApiToken(?string $apiToken): self
    {
        $this->apiToken = $apiToken;

        return $this;
    }

    public function getEstModeMecef(): ?bool
    {
        return $this->estModeMecef;
    }

    public function setEstModeMecef(bool $estModeMecef): self
    {
        $this->estModeMecef = $estModeMecef;

        return $this;
    }

    public function getLieuImpression(): ?string
    {
        return $this->lieuImpression;
    }

    public function setLieuImpression(?string $lieuImpression): self
    {
        $this->lieuImpression = $lieuImpression;

        return $this;
    }

    

    public function getMessageCommercial(): ?string
    {
        return $this->messageCommercial;
    }

    public function setMessageCommercial(?string $messageCommercial): self
    {
        $this->messageCommercial = $messageCommercial;

        return $this;
    }


}
