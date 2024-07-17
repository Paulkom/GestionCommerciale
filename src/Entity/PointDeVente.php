<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\PointDeVenteRepository;
use Doctrine\Common\Collections\Collection;
use App\AjaxifySearch\Annotation\AjaxifySearch;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=PointDeVenteRepository::class)
 * @ORM\HasLifecycleCallbacks
 *  * @AjaxifySearch(
 *     alias = "pointDeVente",
 *     itemTemplate = "point_de_vente/partials/item.html.twig",
 *     relations = { "famille" },
 *     searchables = {
 *          "stock", "code", "libelle", "adresse", "tel"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class PointDeVente
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
    private $code;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $libelle;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $adresse;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $tel;

    /**
     * @ORM\Column(type="boolean")
     */
    private $estPrincipal;

    /**
     * @ORM\OneToMany(targetEntity=Produit::class, mappedBy="pointVente")
     */
    private $produits;

    /**
     * @ORM\OneToMany(targetEntity=Profil::class, mappedBy="pointVente")
     */
    private $profils;

    /**
     * @ORM\OneToMany(targetEntity=ModelSignataire::class, mappedBy="pointVente")
     */
    private $modelSignataires;

     /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\OneToMany(targetEntity=AdresseLivraison::class, mappedBy="pointVente")
     */
    private $adresseLivraisons;

    /**
     * @ORM\OneToMany(targetEntity=Approvisionnement::class, mappedBy="pointVente")
     */
    private $approvisionnements;

    /**
     * @ORM\OneToMany(targetEntity=Banque::class, mappedBy="pointVente")
     */
    private $banques;

    /**
     * @ORM\OneToMany(targetEntity=Caisse::class, mappedBy="pointVente")
     */
    private $caisses;

    /**
     * @ORM\OneToMany(targetEntity=Client::class, mappedBy="pointVente")
     */
    private $clients;

    /**
     * @ORM\OneToMany(targetEntity=CommandeClient::class, mappedBy="pointVente")
     */
    private $commandeClients;

    /**
     * @ORM\OneToMany(targetEntity=CommandeFrs::class, mappedBy="pointVente")
     */
    private $commandeFrs;

    /**
     * @ORM\OneToMany(targetEntity=Compte::class, mappedBy="pointVente")
     */
    private $comptes;

    /**
     * @ORM\OneToMany(targetEntity=Conditionnement::class, mappedBy="pointVente")
     */
    private $conditionnements;

    /**
     * @ORM\OneToMany(targetEntity=DemandeDePrix::class, mappedBy="pointVente")
     */
    private $demandeDePrixes;

    /**
     * @ORM\OneToMany(targetEntity=Facture::class, mappedBy="pointVente")
     */
    private $factures;

    /**
     * @ORM\OneToMany(targetEntity=FactureProforma::class, mappedBy="pointVente")
     */
    private $factureProformas;

    /**
     * @ORM\OneToMany(targetEntity=Famille::class, mappedBy="pointVente")
     */
    private $familles;

    /**
     * @ORM\OneToMany(targetEntity=Fonction::class, mappedBy="pointVente")
     */
    private $fonctions;

    /**
     * @ORM\OneToMany(targetEntity=Fournisseur::class, mappedBy="pointVente")
     */
    private $fournisseurs;

    /**
     * @ORM\OneToMany(targetEntity=GroupeTaxe::class, mappedBy="pointVente")
     */
    private $groupeTaxes;

    /**
     * @ORM\OneToMany(targetEntity=Inventaire::class, mappedBy="pointVente")
     */
    private $inventaires;

    /**
     * @ORM\OneToMany(targetEntity=Livraison::class, mappedBy="pointVente")
     */
    private $livraisons;

    /**
     * @ORM\OneToMany(targetEntity=Magasin::class, mappedBy="pointVente")
     */
    private $magasins;

    /**
     * @ORM\OneToMany(targetEntity=Media::class, mappedBy="pointVente")
     */
    private $media;

    /**
     * @ORM\OneToMany(targetEntity=Menu::class, mappedBy="pointVente")
     */
    private $menus;

    /**
     * @ORM\OneToMany(targetEntity=ModePaiement::class, mappedBy="pointVente")
     */
    private $modePaiements;

    /**
     * @ORM\OneToMany(targetEntity=Monnaie::class, mappedBy="pointVente")
     */
    private $monnaies;

    /**
     * @ORM\OneToMany(targetEntity=Paiement::class, mappedBy="pointVente")
     */
    private $paiements;

    /**
     * @ORM\OneToMany(targetEntity=Personnel::class, mappedBy="pointVente")
     */
    private $personnels;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="pointDeVentes")
     */
    private $pointVente;

    /**
     * @ORM\OneToMany(targetEntity=PointDeVente::class, mappedBy="pointVente")
     */
    private $pointDeVentes;

    /**
     * @ORM\OneToMany(targetEntity=Role::class, mappedBy="pointVente")
     */
    private $roles;

    /**
     * @ORM\OneToMany(targetEntity=Societe::class, mappedBy="pointVente")
     */
    private $societes;

    /**
     * @ORM\OneToMany(targetEntity=Sortie::class, mappedBy="pointVente")
     */
    private $sorties;

    /**
     * @ORM\OneToMany(targetEntity=Taxe::class, mappedBy="pointVente")
     */
    private $taxes;

    /**
     * @ORM\OneToMany(targetEntity=Transaction::class, mappedBy="pointVente")
     */
    private $transactions;

    /**
     * @ORM\OneToMany(targetEntity=Transfert::class, mappedBy="pointVente")
     */
    private $transferts;

    /**
     * @ORM\OneToMany(targetEntity=TypeInventaire::class, mappedBy="pointVente")
     */
    private $typeInventaires;

    /**
     * @ORM\OneToMany(targetEntity=TypeOperation::class, mappedBy="pointVente")
     */
    private $typeOperations;

    /**
     * @ORM\OneToMany(targetEntity=TypeTaxe::class, mappedBy="pointVente")
     */
    private $typeTaxes;

    /**
     * @ORM\OneToMany(targetEntity=Utilisateur::class, mappedBy="pointVente")
     */
    private $utilisateurs;

    /**
     * @ORM\OneToMany(targetEntity=ProduitConditionnement::class, mappedBy="pointVente")
     */
    private $produitConditionnements;

    /**
     * @ORM\OneToMany(targetEntity=ListCaisse::class, mappedBy="pointVente")
     */
    private $listCaisses;

    /**
     * @ORM\OneToMany(targetEntity=UtilisateurPointDeVente::class, mappedBy="pointDeVente")
     */
    private $utilisateurPointDeVentes;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondMag::class, mappedBy="pointVente")
     */
    private $produitCondMags;

    /**
     * @ORM\OneToMany(targetEntity=Depense::class, mappedBy="pointVente")
     */
    private $depenses;

    /**
     * @ORM\OneToMany(targetEntity=TypeDepense::class, mappedBy="pointVente")
     */
    private $typeDepenses;

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
        $this->produits = new ArrayCollection();
        $this->adresseLivraisons = new ArrayCollection();
        $this->approvisionnements = new ArrayCollection();
        $this->banques = new ArrayCollection();
        $this->caisses = new ArrayCollection();
        $this->clients = new ArrayCollection();
        $this->commandeClients = new ArrayCollection();
        $this->commandeFrs = new ArrayCollection();
        $this->comptes = new ArrayCollection();
        $this->conditionnements = new ArrayCollection();
        $this->demandeDePrixes = new ArrayCollection();
        $this->factures = new ArrayCollection();
        $this->factureProformas = new ArrayCollection();
        $this->familles = new ArrayCollection();
        $this->fonctions = new ArrayCollection();
        $this->fournisseurs = new ArrayCollection();
        $this->groupeTaxes = new ArrayCollection();
        $this->inventaires = new ArrayCollection();
        $this->livraisons = new ArrayCollection();
        $this->magasins = new ArrayCollection();
        $this->media = new ArrayCollection();
        $this->menus = new ArrayCollection();
        $this->modePaiements = new ArrayCollection();
        $this->monnaies = new ArrayCollection();
        $this->paiements = new ArrayCollection();
        $this->personnels = new ArrayCollection();
        $this->pointDeVentes = new ArrayCollection();
        $this->roles = new ArrayCollection();
        $this->societes = new ArrayCollection();
        $this->sorties = new ArrayCollection();
        $this->taxes = new ArrayCollection();
        $this->transactions = new ArrayCollection();
        $this->transferts = new ArrayCollection();
        $this->typeInventaires = new ArrayCollection();
        $this->typeOperations = new ArrayCollection();
        $this->typeTaxes = new ArrayCollection();
        $this->utilisateurs = new ArrayCollection();
        $this->produitConditionnements = new ArrayCollection();
        $this->listCaisses = new ArrayCollection();
        $this->utilisateurPointDeVentes = new ArrayCollection();
        $this->produitCondMags = new ArrayCollection();
        $this->modelSignataires = new ArrayCollection();
        $this->depenses = new ArrayCollection();
        $this->typeDepenses = new ArrayCollection();
        $this->profils = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCode(): ?string
    {
        return $this->code;
    }

    public function setCode(string $code): self
    {
        $this->code = $code;

        return $this;
    }

    public function getLibelle(): ?string
    {
        return $this->libelle;
    }

    public function setLibelle(string $libelle): self
    {
        $this->libelle = $libelle;

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

    public function getTel(): ?string
    {
        return $this->tel;
    }

    public function setTel(string $tel): self
    {
        $this->tel = $tel;

        return $this;
    }

    public function getEstPrincipal(): ?bool
    {
        return $this->estPrincipal;
    }

    public function setEstPrincipal(bool $estPrincipal): self
    {
        $this->estPrincipal = $estPrincipal;

        return $this;
    }

    /**
     * @return Collection<int, Produit>
     */
    public function getProduits(): Collection
    {
        return $this->produits;
    }

    public function addProduit(Produit $produit): self
    {
        if (!$this->produits->contains($produit)) {
            $this->produits[] = $produit;
            $produit->setPointVente($this);
        }

        return $this;
    }

    public function removeProduit(Produit $produit): self
    {
        if ($this->produits->removeElement($produit)) {
            // set the owning side to null (unless already changed)
            if ($produit->getPointVente() === $this) {
                $produit->setPointVente(null);
            }
        }

        return $this;
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
            $adresseLivraison->setPointVente($this);
        }

        return $this;
    }

    public function removeAdresseLivraison(AdresseLivraison $adresseLivraison): self
    {
        if ($this->adresseLivraisons->removeElement($adresseLivraison)) {
            // set the owning side to null (unless already changed)
            if ($adresseLivraison->getPointVente() === $this) {
                $adresseLivraison->setPointVente(null);
            }
        }

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
            $approvisionnement->setPointVente($this);
        }

        return $this;
    }

    public function removeApprovisionnement(Approvisionnement $approvisionnement): self
    {
        if ($this->approvisionnements->removeElement($approvisionnement)) {
            // set the owning side to null (unless already changed)
            if ($approvisionnement->getPointVente() === $this) {
                $approvisionnement->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Banque>
     */
    public function getBanques(): Collection
    {
        return $this->banques;
    }

    public function addBanque(Banque $banque): self
    {
        if (!$this->banques->contains($banque)) {
            $this->banques[] = $banque;
            $banque->setPointVente($this);
        }

        return $this;
    }

    public function removeBanque(Banque $banque): self
    {
        if ($this->banques->removeElement($banque)) {
            // set the owning side to null (unless already changed)
            if ($banque->getPointVente() === $this) {
                $banque->setPointVente(null);
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
            $caiss->setPointVente($this);
        }

        return $this;
    }

    public function removeCaiss(Caisse $caiss): self
    {
        if ($this->caisses->removeElement($caiss)) {
            // set the owning side to null (unless already changed)
            if ($caiss->getPointVente() === $this) {
                $caiss->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Client>
     */
    public function getClients(): Collection
    {
        return $this->clients;
    }

    public function addClient(Client $client): self
    {
        if (!$this->clients->contains($client)) {
            $this->clients[] = $client;
            $client->setPointVente($this);
        }

        return $this;
    }

    public function removeClient(Client $client): self
    {
        if ($this->clients->removeElement($client)) {
            // set the owning side to null (unless already changed)
            if ($client->getPointVente() === $this) {
                $client->setPointVente(null);
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
            $commandeClient->setPointVente($this);
        }

        return $this;
    }

    public function removeCommandeClient(CommandeClient $commandeClient): self
    {
        if ($this->commandeClients->removeElement($commandeClient)) {
            // set the owning side to null (unless already changed)
            if ($commandeClient->getPointVente() === $this) {
                $commandeClient->setPointVente(null);
            }
        }

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
            $commandeFr->setPointVente($this);
        }

        return $this;
    }

    public function removeCommandeFr(CommandeFrs $commandeFr): self
    {
        if ($this->commandeFrs->removeElement($commandeFr)) {
            // set the owning side to null (unless already changed)
            if ($commandeFr->getPointVente() === $this) {
                $commandeFr->setPointVente(null);
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
            $compte->setPointVente($this);
        }

        return $this;
    }

    public function removeCompte(Compte $compte): self
    {
        if ($this->comptes->removeElement($compte)) {
            // set the owning side to null (unless already changed)
            if ($compte->getPointVente() === $this) {
                $compte->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Conditionnement>
     */
    public function getConditionnements(): Collection
    {
        return $this->conditionnements;
    }

    public function addConditionnement(Conditionnement $conditionnement): self
    {
        if (!$this->conditionnements->contains($conditionnement)) {
            $this->conditionnements[] = $conditionnement;
            $conditionnement->setPointVente($this);
        }

        return $this;
    }

    public function removeConditionnement(Conditionnement $conditionnement): self
    {
        if ($this->conditionnements->removeElement($conditionnement)) {
            // set the owning side to null (unless already changed)
            if ($conditionnement->getPointVente() === $this) {
                $conditionnement->setPointVente(null);
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
            $demandeDePrix->setPointVente($this);
        }

        return $this;
    }

    public function removeDemandeDePrix(DemandeDePrix $demandeDePrix): self
    {
        if ($this->demandeDePrixes->removeElement($demandeDePrix)) {
            // set the owning side to null (unless already changed)
            if ($demandeDePrix->getPointVente() === $this) {
                $demandeDePrix->setPointVente(null);
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
            $facture->setPointVente($this);
        }

        return $this;
    }

    public function removeFacture(Facture $facture): self
    {
        if ($this->factures->removeElement($facture)) {
            // set the owning side to null (unless already changed)
            if ($facture->getPointVente() === $this) {
                $facture->setPointVente(null);
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
            $factureProforma->setPointVente($this);
        }

        return $this;
    }

    public function removeFactureProforma(FactureProforma $factureProforma): self
    {
        if ($this->factureProformas->removeElement($factureProforma)) {
            // set the owning side to null (unless already changed)
            if ($factureProforma->getPointVente() === $this) {
                $factureProforma->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Famille>
     */
    public function getFamilles(): Collection
    {
        return $this->familles;
    }

    public function addFamille(Famille $famille): self
    {
        if (!$this->familles->contains($famille)) {
            $this->familles[] = $famille;
            $famille->setPointVente($this);
        }

        return $this;
    }

    public function removeFamille(Famille $famille): self
    {
        if ($this->familles->removeElement($famille)) {
            // set the owning side to null (unless already changed)
            if ($famille->getPointVente() === $this) {
                $famille->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Fonction>
     */
    public function getFonctions(): Collection
    {
        return $this->fonctions;
    }

    public function addFonction(Fonction $fonction): self
    {
        if (!$this->fonctions->contains($fonction)) {
            $this->fonctions[] = $fonction;
            $fonction->setPointVente($this);
        }

        return $this;
    }

    public function removeFonction(Fonction $fonction): self
    {
        if ($this->fonctions->removeElement($fonction)) {
            // set the owning side to null (unless already changed)
            if ($fonction->getPointVente() === $this) {
                $fonction->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Fournisseur>
     */
    public function getFournisseurs(): Collection
    {
        return $this->fournisseurs;
    }

    public function addFournisseur(Fournisseur $fournisseur): self
    {
        if (!$this->fournisseurs->contains($fournisseur)) {
            $this->fournisseurs[] = $fournisseur;
            $fournisseur->setPointVente($this);
        }

        return $this;
    }

    public function removeFournisseur(Fournisseur $fournisseur): self
    {
        if ($this->fournisseurs->removeElement($fournisseur)) {
            // set the owning side to null (unless already changed)
            if ($fournisseur->getPointVente() === $this) {
                $fournisseur->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, GroupeTaxe>
     */
    public function getGroupeTaxes(): Collection
    {
        return $this->groupeTaxes;
    }

    public function addGroupeTax(GroupeTaxe $groupeTax): self
    {
        if (!$this->groupeTaxes->contains($groupeTax)) {
            $this->groupeTaxes[] = $groupeTax;
            $groupeTax->setPointVente($this);
        }

        return $this;
    }

    public function removeGroupeTax(GroupeTaxe $groupeTax): self
    {
        if ($this->groupeTaxes->removeElement($groupeTax)) {
            // set the owning side to null (unless already changed)
            if ($groupeTax->getPointVente() === $this) {
                $groupeTax->setPointVente(null);
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
            $inventaire->setPointVente($this);
        }

        return $this;
    }

    public function removeInventaire(Inventaire $inventaire): self
    {
        if ($this->inventaires->removeElement($inventaire)) {
            // set the owning side to null (unless already changed)
            if ($inventaire->getPointVente() === $this) {
                $inventaire->setPointVente(null);
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
            $livraison->setPointVente($this);
        }

        return $this;
    }

    public function removeLivraison(Livraison $livraison): self
    {
        if ($this->livraisons->removeElement($livraison)) {
            // set the owning side to null (unless already changed)
            if ($livraison->getPointVente() === $this) {
                $livraison->setPointVente(null);
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
            $magasin->setPointVente($this);
        }

        return $this;
    }

    public function removeMagasin(Magasin $magasin): self
    {
        if ($this->magasins->removeElement($magasin)) {
            // set the owning side to null (unless already changed)
            if ($magasin->getPointVente() === $this) {
                $magasin->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Media>
     */
    public function getMedia(): Collection
    {
        return $this->media;
    }

    public function addMedium(Media $medium): self
    {
        if (!$this->media->contains($medium)) {
            $this->media[] = $medium;
            $medium->setPointVente($this);
        }

        return $this;
    }

    public function removeMedium(Media $medium): self
    {
        if ($this->media->removeElement($medium)) {
            // set the owning side to null (unless already changed)
            if ($medium->getPointVente() === $this) {
                $medium->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Menu>
     */
    public function getMenus(): Collection
    {
        return $this->menus;
    }

    public function addMenu(Menu $menu): self
    {
        if (!$this->menus->contains($menu)) {
            $this->menus[] = $menu;
            $menu->setPointVente($this);
        }

        return $this;
    }

    public function removeMenu(Menu $menu): self
    {
        if ($this->menus->removeElement($menu)) {
            // set the owning side to null (unless already changed)
            if ($menu->getPointVente() === $this) {
                $menu->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, ModePaiement>
     */
    public function getModePaiements(): Collection
    {
        return $this->modePaiements;
    }

    public function addModePaiement(ModePaiement $modePaiement): self
    {
        if (!$this->modePaiements->contains($modePaiement)) {
            $this->modePaiements[] = $modePaiement;
            $modePaiement->setPointVente($this);
        }

        return $this;
    }

    public function removeModePaiement(ModePaiement $modePaiement): self
    {
        if ($this->modePaiements->removeElement($modePaiement)) {
            // set the owning side to null (unless already changed)
            if ($modePaiement->getPointVente() === $this) {
                $modePaiement->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Monnaie>
     */
    public function getMonnaies(): Collection
    {
        return $this->monnaies;
    }

    public function addMonnaie(Monnaie $monnaie): self
    {
        if (!$this->monnaies->contains($monnaie)) {
            $this->monnaies[] = $monnaie;
            $monnaie->setPointVente($this);
        }

        return $this;
    }

    public function removeMonnaie(Monnaie $monnaie): self
    {
        if ($this->monnaies->removeElement($monnaie)) {
            // set the owning side to null (unless already changed)
            if ($monnaie->getPointVente() === $this) {
                $monnaie->setPointVente(null);
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
            $paiement->setPointVente($this);
        }

        return $this;
    }

    public function removePaiement(Paiement $paiement): self
    {
        if ($this->paiements->removeElement($paiement)) {
            // set the owning side to null (unless already changed)
            if ($paiement->getPointVente() === $this) {
                $paiement->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Personnel>
     */
    public function getPersonnels(): Collection
    {
        return $this->personnels;
    }

    public function addPersonnel(Personnel $personnel): self
    {
        if (!$this->personnels->contains($personnel)) {
            $this->personnels[] = $personnel;
            $personnel->setPointVente($this);
        }

        return $this;
    }

    public function removePersonnel(Personnel $personnel): self
    {
        if ($this->personnels->removeElement($personnel)) {
            // set the owning side to null (unless already changed)
            if ($personnel->getPointVente() === $this) {
                $personnel->setPointVente(null);
            }
        }

        return $this;
    }

    public function getPointVente(): ?self
    {
        return $this->pointVente;
    }

    public function setPointVente(?self $pointVente): self
    {
        $this->pointVente = $pointVente;

        return $this;
    }

    /**
     * @return Collection<int, self>
     */
    public function getPointDeVentes(): Collection
    {
        return $this->pointDeVentes;
    }

    public function addPointDeVente(self $pointDeVente): self
    {
        if (!$this->pointDeVentes->contains($pointDeVente)) {
            $this->pointDeVentes[] = $pointDeVente;
            $pointDeVente->setPointVente($this);
        }

        return $this;
    }

    public function removePointDeVente(self $pointDeVente): self
    {
        if ($this->pointDeVentes->removeElement($pointDeVente)) {
            // set the owning side to null (unless already changed)
            if ($pointDeVente->getPointVente() === $this) {
                $pointDeVente->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Role>
     */
    public function getRoles(): Collection
    {
        return $this->roles;
    }

    public function addRole(Role $role): self
    {
        if (!$this->roles->contains($role)) {
            $this->roles[] = $role;
            $role->setPointVente($this);
        }

        return $this;
    }

    public function removeRole(Role $role): self
    {
        if ($this->roles->removeElement($role)) {
            // set the owning side to null (unless already changed)
            if ($role->getPointVente() === $this) {
                $role->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Societe>
     */
    public function getSocietes(): Collection
    {
        return $this->societes;
    }

    public function addSociete(Societe $societe): self
    {
        if (!$this->societes->contains($societe)) {
            $this->societes[] = $societe;
            $societe->setPointVente($this);
        }

        return $this;
    }

    public function removeSociete(Societe $societe): self
    {
        if ($this->societes->removeElement($societe)) {
            // set the owning side to null (unless already changed)
            if ($societe->getPointVente() === $this) {
                $societe->setPointVente(null);
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
            $sorty->setPointVente($this);
        }

        return $this;
    }

    public function removeSorty(Sortie $sorty): self
    {
        if ($this->sorties->removeElement($sorty)) {
            // set the owning side to null (unless already changed)
            if ($sorty->getPointVente() === $this) {
                $sorty->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Taxe>
     */
    public function getTaxes(): Collection
    {
        return $this->taxes;
    }

    public function addTax(Taxe $tax): self
    {
        if (!$this->taxes->contains($tax)) {
            $this->taxes[] = $tax;
            $tax->setPointVente($this);
        }

        return $this;
    }

    public function removeTax(Taxe $tax): self
    {
        if ($this->taxes->removeElement($tax)) {
            // set the owning side to null (unless already changed)
            if ($tax->getPointVente() === $this) {
                $tax->setPointVente(null);
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
            $transaction->setPointVente($this);
        }

        return $this;
    }

    public function removeTransaction(Transaction $transaction): self
    {
        if ($this->transactions->removeElement($transaction)) {
            // set the owning side to null (unless already changed)
            if ($transaction->getPointVente() === $this) {
                $transaction->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Transfert>
     */
    public function getTransferts(): Collection
    {
        return $this->transferts;
    }

    public function addTransfert(Transfert $transfert): self
    {
        if (!$this->transferts->contains($transfert)) {
            $this->transferts[] = $transfert;
            $transfert->setPointVente($this);
        }

        return $this;
    }

    public function removeTransfert(Transfert $transfert): self
    {
        if ($this->transferts->removeElement($transfert)) {
            // set the owning side to null (unless already changed)
            if ($transfert->getPointVente() === $this) {
                $transfert->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, TypeInventaire>
     */
    public function getTypeInventaires(): Collection
    {
        return $this->typeInventaires;
    }

    public function addTypeInventaire(TypeInventaire $typeInventaire): self
    {
        if (!$this->typeInventaires->contains($typeInventaire)) {
            $this->typeInventaires[] = $typeInventaire;
            $typeInventaire->setPointVente($this);
        }

        return $this;
    }

    public function removeTypeInventaire(TypeInventaire $typeInventaire): self
    {
        if ($this->typeInventaires->removeElement($typeInventaire)) {
            // set the owning side to null (unless already changed)
            if ($typeInventaire->getPointVente() === $this) {
                $typeInventaire->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, TypeOperation>
     */
    public function getTypeOperations(): Collection
    {
        return $this->typeOperations;
    }

    public function addTypeOperation(TypeOperation $typeOperation): self
    {
        if (!$this->typeOperations->contains($typeOperation)) {
            $this->typeOperations[] = $typeOperation;
            $typeOperation->setPointVente($this);
        }

        return $this;
    }

    public function removeTypeOperation(TypeOperation $typeOperation): self
    {
        if ($this->typeOperations->removeElement($typeOperation)) {
            // set the owning side to null (unless already changed)
            if ($typeOperation->getPointVente() === $this) {
                $typeOperation->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, TypeTaxe>
     */
    public function getTypeTaxes(): Collection
    {
        return $this->typeTaxes;
    }

    public function addTypeTax(TypeTaxe $typeTax): self
    {
        if (!$this->typeTaxes->contains($typeTax)) {
            $this->typeTaxes[] = $typeTax;
            $typeTax->setPointVente($this);
        }

        return $this;
    }

    public function removeTypeTax(TypeTaxe $typeTax): self
    {
        if ($this->typeTaxes->removeElement($typeTax)) {
            // set the owning side to null (unless already changed)
            if ($typeTax->getPointVente() === $this) {
                $typeTax->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Utilisateur>
     */
    public function getUtilisateurs(): Collection
    {
        return $this->utilisateurs;
    }

    public function addUtilisateur(Utilisateur $utilisateur): self
    {
        if (!$this->utilisateurs->contains($utilisateur)) {
            $this->utilisateurs[] = $utilisateur;
            $utilisateur->setPointVente($this);
        }

        return $this;
    }

    public function removeUtilisateur(Utilisateur $utilisateur): self
    {
        if ($this->utilisateurs->removeElement($utilisateur)) {
            // set the owning side to null (unless already changed)
            if ($utilisateur->getPointVente() === $this) {
                $utilisateur->setPointVente(null);
            }
        }

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
            $produitConditionnement->setPointVente($this);
        }

        return $this;
    }

    public function removeProduitConditionnement(ProduitConditionnement $produitConditionnement): self
    {
        if ($this->produitConditionnements->removeElement($produitConditionnement)) {
            // set the owning side to null (unless already changed)
            if ($produitConditionnement->getPointVente() === $this) {
                $produitConditionnement->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, ListCaisse>
     */
    public function getListCaisses(): Collection
    {
        return $this->listCaisses;
    }

    public function addListCaiss(ListCaisse $listCaiss): self
    {
        if (!$this->listCaisses->contains($listCaiss)) {
            $this->listCaisses[] = $listCaiss;
            $listCaiss->setPointVente($this);
        }

        return $this;
    }

    public function removeListCaiss(ListCaisse $listCaiss): self
    {
        if ($this->listCaisses->removeElement($listCaiss)) {
            // set the owning side to null (unless already changed)
            if ($listCaiss->getPointVente() === $this) {
                $listCaiss->setPointVente(null);
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
            $utilisateurPointDeVente->setPointDeVente($this);
        }

        return $this;
    }

    public function removeUtilisateurPointDeVente(UtilisateurPointDeVente $utilisateurPointDeVente): self
    {
        if ($this->utilisateurPointDeVentes->removeElement($utilisateurPointDeVente)) {
            // set the owning side to null (unless already changed)
            if ($utilisateurPointDeVente->getPointDeVente() === $this) {
                $utilisateurPointDeVente->setPointDeVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, ProduitCondMag>
     */
    public function getProduitCondMags(): Collection
    {
        return $this->produitCondMags;
    }

    public function addProduitCondMag(ProduitCondMag $produitCondMag): self
    {
        if (!$this->produitCondMags->contains($produitCondMag)) {
            $this->produitCondMags[] = $produitCondMag;
            $produitCondMag->setPointVente($this);
        }

        return $this;
    }

    public function removeProduitCondMag(ProduitCondMag $produitCondMag): self
    {
        if ($this->produitCondMags->removeElement($produitCondMag)) {
            // set the owning side to null (unless already changed)
            if ($produitCondMag->getPointVente() === $this) {
                $produitCondMag->setPointVente(null);
            }
        }

        return $this;
    }

    

    /**
     * @return Collection<int, ModelSignataire>
     */
    public function getModelSignataires(): Collection
    {
        return $this->modelSignataires;
    }

    public function addModelSignataire(ModelSignataire $modelSignataire): self
    {
        if (!$this->modelSignataires->contains($modelSignataire)) {
            $this->modelSignataires[] = $modelSignataire;
            $modelSignataire->setPointVente($this);
        }

        return $this;
    }

    public function removeModelSignataire(ModelSignataire $modelSignataire): self
    {
        if ($this->modelSignataires->removeElement($modelSignataire)) {
            // set the owning side to null (unless already changed)
            if ($modelSignataire->getPointVente() === $this) {
                $modelSignataire->setPointVente(null);
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
            $depense->setPointVente($this);
        }

        return $this;
    }

    public function removeDepense(Depense $depense): self
    {
        if ($this->depenses->removeElement($depense)) {
            // set the owning side to null (unless already changed)
            if ($depense->getPointVente() === $this) {
                $depense->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, TypeDepense>
     */
    public function getTypeDepenses(): Collection
    {
        return $this->typeDepenses;
    }

    public function addTypeDepense(TypeDepense $typeDepense): self
    {
        if (!$this->typeDepenses->contains($typeDepense)) {
            $this->typeDepenses[] = $typeDepense;
            $typeDepense->setPointVente($this);
        }

        return $this;
    }

    public function removeTypeDepense(TypeDepense $typeDepense): self
    {
        if ($this->typeDepenses->removeElement($typeDepense)) {
            // set the owning side to null (unless already changed)
            if ($typeDepense->getPointVente() === $this) {
                $typeDepense->setPointVente(null);
            }
        }

        return $this;
    }

    /**
     * @return Collection<int, Profil>
     */
    public function getProfils(): Collection
    {
        return $this->profils;
    }

    public function addProfil(Profil $profil): self
    {
        if (!$this->profils->contains($profil)) {
            $this->profils[] = $profil;
            $profil->setPointVente($this);
        }

        return $this;
    }

    public function removeProfil(Profil $profil): self
    {
        if ($this->profils->removeElement($profil)) {
            // set the owning side to null (unless already changed)
            if ($profil->getPointVente() === $this) {
                $profil->setPointVente(null);
            }
        }

        return $this;
    }
}
