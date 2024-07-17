<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\PersonnelRepository;
use Doctrine\Common\Collections\Collection;
use App\AjaxifySearch\Annotation\AjaxifySearch;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=PersonnelRepository::class)
 * @ORM\HasLifecycleCallbacks
 * @AjaxifySearch(
 *     alias = "personnel",
 *     itemTemplate = "personnel/partials/item.html.twig",
 *     searchables = {
 *          "nom", "prenoms", "tel", "email","adresse","sexe"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class Personnel
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
    private $nom;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $prenoms;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $tel;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $email;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $adresse;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $dateNais;

    /**
     * @ORM\OneToMany(targetEntity=FonctionPersonnel::class, mappedBy="personnel", orphanRemoval=true, cascade={"persist"})
     */
    private $fonctionPersonnels;

    /**
     * @ORM\OneToMany(targetEntity=Magasin::class, mappedBy="superviseur", orphanRemoval=true)
     */
    private $magasins;

    /**
     * @ORM\OneToMany(targetEntity=Livraison::class, mappedBy="livreur")
     */
    private $livraisons;

    /**
     * @ORM\OneToMany(targetEntity=Sortie::class, mappedBy="auteur")
     */
    private $sorties;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $sexe;

    /**
     * @ORM\Column(type="string", length=255,nullable=true)
     */
    private $civilite;

    /**
     * @ORM\OneToMany(targetEntity=PersonnelCaisse::class, mappedBy="personnel",cascade={"persist"})
     */
    private $personnelCaisses;

    /**
     * @ORM\ManyToMany(targetEntity=Inventaire::class, mappedBy="personnesConcernees",cascade={"persist"})
     */
    private $inventaires;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="personnels")
     */
    private $pointVente;

    /**
     * @ORM\OneToMany(targetEntity=ModelSignatairePersonnelFonction::class, mappedBy="personnel")
     */
    private $modelSignatairePersonnelFonctions;

    /**
     * @ORM\OneToOne(targetEntity=Utilisateur::class, mappedBy="personnel", cascade={"persist", "remove"})
     */
    private $utilisateur;

    public function __construct()
    {
        $this->fonctionPersonnels = new ArrayCollection();
        $this->magasins = new ArrayCollection();
        $this->livraisons = new ArrayCollection();
        $this->sorties = new ArrayCollection();
        $this->personnelCaisses = new ArrayCollection();
        $this->inventaires = new ArrayCollection();
        $this->modelSignatairePersonnelFonctions = new ArrayCollection();
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

    public function getTel(): ?string
    {
        return $this->tel;
    }

    public function setTel(?string $tel): self
    {
        $this->tel = $tel;

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

    public function getAdresse(): ?string
    {
        return $this->adresse;
    }

    public function setAdresse(?string $adresse): self
    {
        $this->adresse = $adresse;

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

    public function getSexe(): ?string
    {
        return $this->sexe;
    }

    public function setSexe(string $sexe): self
    {
        $this->sexe = $sexe;

        return $this;
    }

    public function getCivilite(): ?string
    {
        return $this->civilite;
    }

    public function setCivilite(?string $civilite): self
    {
        $this->civilite = $civilite;

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

    /**
     * @return Collection<int, FonctionPersonnel>
     */
    public function getFonctionPersonnels(): Collection
    {
        return $this->fonctionPersonnels;
    }

    public function addFonctionPersonnel(FonctionPersonnel $fonctionPersonnel): self
    {
        if (!$this->fonctionPersonnels->contains($fonctionPersonnel)) {
            $this->fonctionPersonnels[] = $fonctionPersonnel;
            $fonctionPersonnel->setPersonnel($this);
        }

        return $this;
    }

    public function removeFonctionPersonnel(FonctionPersonnel $fonctionPersonnel): self
    {
        if ($this->fonctionPersonnels->removeElement($fonctionPersonnel)) {
            // set the owning side to null (unless already changed)
            if ($fonctionPersonnel->getPersonnel() === $this) {
                $fonctionPersonnel->setPersonnel(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Magasin>
     */
    public function getMagasins(): Collection
    {
        return $this->magasins;
    }

    public function addMagasin(Magasin $magasin): self
    {
        if (!$this->magasins->contains($magasin)) {
            $this->magasins[] = $magasin;
            $magasin->setSuperviseur($this);
        }

        return $this;
    }

    public function removeMagasin(Magasin $magasin): self
    {
        if ($this->magasins->removeElement($magasin)) {
            // set the owning side to null (unless already changed)
            if ($magasin->getSuperviseur() === $this) {
                $magasin->setSuperviseur(null);
            }
        }

        return $this;
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
     * @return Collection<int, Sortie>
     */
    public function getSorties(): Collection
    {
        return $this->sorties;
    }

    public function addSorty(Sortie $sorty): self
    {
        if (!$this->sorties->contains($sorty)) {
            $this->sorties[] = $sorty;
            $sorty->setAuteur($this);
        }

        return $this;
    }

    public function removeSorty(Sortie $sorty): self
    {
        if ($this->sorties->removeElement($sorty)) {
            // set the owning side to null (unless already changed)
            if ($sorty->getAuteur() === $this) {
                $sorty->setAuteur(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, PersonnelCaisse>
     */
    public function getPersonnelCaisses(): Collection
    {
        return $this->personnelCaisses;
    }

    public function addPersonnelCaiss(PersonnelCaisse $personnelCaiss): self
    {
        if (!$this->personnelCaisses->contains($personnelCaiss)) {
            $this->personnelCaisses[] = $personnelCaiss;
            $personnelCaiss->setPersonnel($this);
        }

        return $this;
    }

    public function removePersonnelCaiss(PersonnelCaisse $personnelCaiss): self
    {
        if ($this->personnelCaisses->removeElement($personnelCaiss)) {
            // set the owning side to null (unless already changed)
            if ($personnelCaiss->getPersonnel() === $this) {
                $personnelCaiss->setPersonnel(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Inventaire>
     */
    public function getInventaires(): Collection
    {
        return $this->inventaires;
    }

    public function addInventaire(Inventaire $inventaire): self
    {
        if (!$this->inventaires->contains($inventaire)) {
            $this->inventaires[] = $inventaire;
            $inventaire->addPersonnesConcernee($this);
        }

        return $this;
    }

    public function removeInventaire(Inventaire $inventaire): self
    {
        if ($this->inventaires->removeElement($inventaire)) {
            $inventaire->removePersonnesConcernee($this);
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
     * @return Collection<int, ModelSignatairePersonnelFonction>
     */
    public function getModelSignatairePersonnelFonctions(): Collection
    {
        return $this->modelSignatairePersonnelFonctions;
    }

    public function addModelSignatairePersonnelFonction(ModelSignatairePersonnelFonction $modelSignatairePersonnelFonction): self
    {
        if (!$this->modelSignatairePersonnelFonctions->contains($modelSignatairePersonnelFonction)) {
            $this->modelSignatairePersonnelFonctions[] = $modelSignatairePersonnelFonction;
            $modelSignatairePersonnelFonction->setPersonnel($this);
        }

        return $this;
    }

    public function removeModelSignatairePersonnelFonction(ModelSignatairePersonnelFonction $modelSignatairePersonnelFonction): self
    {
        if ($this->modelSignatairePersonnelFonctions->removeElement($modelSignatairePersonnelFonction)) {
            // set the owning side to null (unless already changed)
            if ($modelSignatairePersonnelFonction->getPersonnel() === $this) {
                $modelSignatairePersonnelFonction->setPersonnel(null);
            }
        }

        return $this;
    }

    public function getUtilisateur(): ?Utilisateur
    {
        return $this->utilisateur;
    }

    public function setUtilisateur(?Utilisateur $utilisateur): self
    {
        // unset the owning side of the relation if necessary
        if ($utilisateur === null && $this->utilisateur !== null) {
            $this->utilisateur->setPersonnel(null);
        }

        // set the owning side of the relation if necessary
        if ($utilisateur !== null && $utilisateur->getPersonnel() !== $this) {
            $utilisateur->setPersonnel($this);
        }

        $this->utilisateur = $utilisateur;
        return $this;
    }

    public function __toString()
    {
        return $this->nom.' '. $this->prenoms;
    }


}
