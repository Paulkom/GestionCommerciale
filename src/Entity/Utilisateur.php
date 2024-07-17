<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\UtilisateurRepository;
use Doctrine\Common\Collections\Collection;
use App\AjaxifySearch\Annotation\AjaxifySearch;
use Doctrine\Common\Collections\ArrayCollection;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;

/**
 * @ORM\Entity(repositoryClass=UtilisateurRepository::class)
 * @ORM\HasLifecycleCallbacks
 * @UniqueEntity(fields={"username"}, message="There is already an account with this username")
 * @AjaxifySearch(
 *     alias = "utilisateur",
 *     itemTemplate = "utilisateur/partials/item.html.twig",
 *     relations = { "personnel" },
 *     searchables = {
 *          "stock", "personnel.nom"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 * 
 */
class Utilisateur implements UserInterface
{

    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;
    
    /**
     * @ORM\Column(type="string", length=180, unique=true)
     */
    private $username;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $email;

    /**
     * @ORM\Column(type="json")
     */
    private $roles = [];

    /**
     * @ORM\Column(type="json")
     */
    private $profil = [];

    /**
     * @var string The hashed password
     * @ORM\Column(type="string")
     */
    private $password;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\OneToMany(targetEntity=Caisse::class, mappedBy="user")
     */
    private $caisses;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $securityCode;

    /**
     * @ORM\OneToMany(targetEntity=UtilisateurPointDeVente::class, mappedBy="utilisateur",cascade={"persist"})
     */
    private $utilisateurPointDeVentes;

    /**
     * @ORM\OneToMany(targetEntity=CommandeClient::class, mappedBy="operateur")
     */
    private $commandeClients;

    /**
     * @ORM\OneToMany(targetEntity=CommandeFrs::class, mappedBy="operateur")
     */
    private $commandeFrss;

    /**
     * @ORM\OneToMany(targetEntity=DemandeDePrix::class, mappedBy="operateur")
     */
    private $demandeDePrixs;

    /**
     * @ORM\OneToMany(targetEntity=Facture::class, mappedBy="operateur")
     */
    private $factures;

    /**
     * @ORM\OneToMany(targetEntity=FactureProforma::class, mappedBy="operateur")
     */
    private $factureProformas;

    /**
     * @ORM\OneToMany(targetEntity=Paiement::class, mappedBy="operateur")
     */
    private $paiements;

    /**
     * @ORM\OneToMany(targetEntity=Livraison::class, mappedBy="operateur")
     */
    private $livraisons;

    /**
     * @ORM\OneToMany(targetEntity=Depense::class, mappedBy="user")
     */
    private $depenses;

    /**
     * @ORM\OneToOne(targetEntity=Personnel::class, inversedBy="utilisateur", cascade={"persist", "remove"})
     * @ORM\JoinColumn(nullable=false)
     */
    private $personnel;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="utilisateurs",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\OneToMany(targetEntity=Detachement::class, mappedBy="userDet")
     */
    private $detachements;

    public function __construct()
    {
        $this->caisses = new ArrayCollection();
        $this->utilisateurPointDeVentes = new ArrayCollection();
        $this->commandeClients = new ArrayCollection();
        $this->factures = new ArrayCollection();
        $this->factureProformas = new ArrayCollection();
        $this->paiements = new ArrayCollection();
        $this->livraisons = new ArrayCollection();
        $this->depenses = new ArrayCollection();
        $this->commandeFrss = new ArrayCollection();
        $this->demandeDePrixs = new ArrayCollection();
        $this->detachements = new ArrayCollection();
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

    /**
     * @deprecated since Symfony 5.3, use getUserIdentifier instead
     */
    public function getUsername(): string
    {
        return (string) $this->username;
    }

    public function setUsername(string $username): self
    {
        $this->username = $username;

        return $this;
    }

    /**
     * A visual identifier that represents this user.
     *
     * @see UserInterface
     */
    public function getUserIdentifier(): string
    {
        return (string) $this->username;
    }

    /**
     * @see UserInterface
     */
    public function getRoles(): array
    {
        $roles = $this->roles;
        // guarantee every user at least has ROLE_USER
        $roles[] = 'ROLE_USER';

        return array_unique($roles);
    }

    public function setRoles(array $roles): self
    {
        $this->roles = $roles;

        return $this;
    }

    /**
     * @see PasswordAuthenticatedUserInterface
     */
    public function getPassword(): string
    {
        return $this->password;
    }

    public function setPassword(string $password): self
    {
        $this->password = $password;

        return $this;
    }

    /**
     * Returning a salt is only needed, if you are not using a modern
     * hashing algorithm (e.g. bcrypt or sodium) in your security.yaml.
     *
     * @see UserInterface
     */
    public function getSalt(): ?string
    {
        return null;
    }

    /**
     * @see UserInterface
     */
    public function eraseCredentials()
    {
        // If you store any temporary, sensitive data on the user, clear it here
        // $this->plainPassword = null;
    }

    /**
     * @return Collection<int, Livraison>
     */
    public function getLivraisons(): Collection
    {
        return $this->livraisons;
    }

    public function addLivraison(Livraison $livraison): self
    {
        if (!$this->livraisons->contains($livraison)) {
            $this->livraisons[] = $livraison;
            $livraison->setLivreur($this);
        }

        return $this;
    }

    public function removeLivraison(Livraison $livraison): self
    {
        if ($this->livraisons->removeElement($livraison)) {
            // set the owning side to null (unless already changed)
            if ($livraison->getLivreur() === $this) {
                $livraison->setLivreur(null);
            }
        }

        return $this;
    }

  

    /**
     * @return Collection<int, Caisse>
     */
    public function getCaisses(): Collection
    {
        return $this->caisses;
    }

    public function addCaiss(Caisse $caiss): self
    {
        if (!$this->caisses->contains($caiss)) {
            $this->caisses[] = $caiss;
            $caiss->setUser($this);
        }

        return $this;
    }

    public function removeCaiss(Caisse $caiss): self
    {
        if ($this->caisses->removeElement($caiss)) {
            // set the owning side to null (unless already changed)
            if ($caiss->getUser() === $this) {
                $caiss->setUser(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, UtilisateurPointDeVente>
     */
    public function getUtilisateurPointDeVentes(): Collection
    {
        return $this->utilisateurPointDeVentes;
    }

    public function addUtilisateurPointDeVente(UtilisateurPointDeVente $utilisateurPointDeVente): self
    {
        if (!$this->utilisateurPointDeVentes->contains($utilisateurPointDeVente)) {
            $this->utilisateurPointDeVentes[] = $utilisateurPointDeVente;
            $utilisateurPointDeVente->setUtilisateur($this);
        }

        return $this;
    }

    public function removeUtilisateurPointDeVente(UtilisateurPointDeVente $utilisateurPointDeVente): self
    {
        if ($this->utilisateurPointDeVentes->removeElement($utilisateurPointDeVente)) {
            // set the owning side to null (unless already changed)
            if ($utilisateurPointDeVente->getUtilisateur() === $this) {
                $utilisateurPointDeVente->setUtilisateur(null);
            }
        }

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
            $commandeClient->setOperateur($this);
        }

        return $this;
    }

    public function removeCommandeClient(CommandeClient $commandeClient): self
    {
        if ($this->commandeClients->removeElement($commandeClient)) {
            // set the owning side to null (unless already changed)
            if ($commandeClient->getOperateur() === $this) {
                $commandeClient->setOperateur(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Facture>
     */
    public function getFactures(): Collection
    {
        return $this->factures;
    }

    public function addFacture(Facture $facture): self
    {
        if (!$this->factures->contains($facture)) {
            $this->factures[] = $facture;
            $facture->setOperateur($this);
        }

        return $this;
    }

    public function removeFacture(Facture $facture): self
    {
        if ($this->factures->removeElement($facture)) {
            // set the owning side to null (unless already changed)
            if ($facture->getOperateur() === $this) {
                $facture->setOperateur(null);
            }
        }

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
            $factureProforma->setOperateur($this);
        }

        return $this;
    }

    public function removeFactureProforma(FactureProforma $factureProforma): self
    {
        if ($this->factureProformas->removeElement($factureProforma)) {
            // set the owning side to null (unless already changed)
            if ($factureProforma->getOperateur() === $this) {
                $factureProforma->setOperateur(null);
            }
        }

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
            $paiement->setOperateur($this);
        }

        return $this;
    }

    public function removePaiement(Paiement $paiement): self
    {
        if ($this->paiements->removeElement($paiement)) {
            // set the owning side to null (unless already changed)
            if ($paiement->getOperateur() === $this) {
                $paiement->setOperateur(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Depense>
     */
    public function getDepenses(): Collection
    {
        return $this->depenses;
    }

    public function addDepense(Depense $depense): self
    {
        if (!$this->depenses->contains($depense)) {
            $this->depenses[] = $depense;
            $depense->setUser($this);
        }

        return $this;
    }

    public function removeDepense(Depense $depense): self
    {
        if ($this->depenses->removeElement($depense)) {
            // set the owning side to null (unless already changed)
            if ($depense->getUser() === $this) {
                $depense->setUser(null);
            }
        }

        return $this;
    }

    public function getPersonnel(): ?Personnel
    {
        return $this->personnel;
    }

    public function setPersonnel(Personnel $personnel): self
    {
        $this->personnel = $personnel;

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

    public function getId(): ?int
    {
        return $this->id;
    }

    /**
     * @return Collection<int, CommandeFrs>
     */
    public function getCommandeFrss(): Collection
    {
        return $this->commandeFrss;
    }

    public function addCommandeFrss(CommandeFrs $commandeFrss): self
    {
        if (!$this->commandeFrss->contains($commandeFrss)) {
            $this->commandeFrss[] = $commandeFrss;
            $commandeFrss->setOperateur($this);
        }

        return $this;
    }

    public function removeCommandeFrss(CommandeFrs $commandeFrss): self
    {
        if ($this->commandeFrss->removeElement($commandeFrss)) {
            // set the owning side to null (unless already changed)
            if ($commandeFrss->getOperateur() === $this) {
                $commandeFrss->setOperateur(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, DemandeDePrix>
     */
    public function getDemandeDePrixs(): Collection
    {
        return $this->demandeDePrixs;
    }

    public function addDemandeDePrix(DemandeDePrix $demandeDePrix): self
    {
        if (!$this->demandeDePrixs->contains($demandeDePrix)) {
            $this->demandeDePrixs[] = $demandeDePrix;
            $demandeDePrix->setOperateur($this);
        }

        return $this;
    }

    public function removeDemandeDePrix(DemandeDePrix $demandeDePrix): self
    {
        if ($this->demandeDePrixs->removeElement($demandeDePrix)) {
            // set the owning side to null (unless already changed)
            if ($demandeDePrix->getOperateur() === $this) {
                $demandeDePrix->setOperateur(null);
            }
        }

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

    public function getProfil(): ?array
    {
        return $this->profil;
    }

    public function setProfil(array $profil): self
    {
        $this->profil = $profil;

        return $this;
    }

    public function getSecurityCode(): ?string
    {
        return $this->securityCode;
    }

    public function setSecurityCode(?string $securityCode): self
    {
        $this->securityCode = $securityCode;

        return $this;
    }

    /**
     * @return Collection<int, Detachement>
     */
    public function getDetachements(): Collection
    {
        return $this->detachements;
    }

    public function addDetachement(Detachement $detachement): self
    {
        if (!$this->detachements->contains($detachement)) {
            $this->detachements[] = $detachement;
            $detachement->setUserDet($this);
        }

        return $this;
    }

    public function removeDetachement(Detachement $detachement): self
    {
        if ($this->detachements->removeElement($detachement)) {
            // set the owning side to null (unless already changed)
            if ($detachement->getUserDet() === $this) {
                $detachement->setUserDet(null);
            }
        }

        return $this;
    }


    
}
