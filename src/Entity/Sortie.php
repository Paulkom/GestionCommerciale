<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\SortieRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;
use App\AjaxifySearch\Annotation\AjaxifySearch;

/**
 * @ORM\Entity(repositoryClass=SortieRepository::class)
 * @ORM\EntityListeners({"App\EventListener\SortieListener"})
 * @ORM\HasLifecycleCallbacks
 * @AjaxifySearch(
 *     alias = "sortie",
 *     itemTemplate = "sortie/partials/item.html.twig",
 *     relations = { "auteur" },
 *     searchables = {
 *          "dateSortie", "montantTotal", "motif", "auteur.nom", "auteur.prenoms"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class Sortie
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
    private $dateSortie;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     */
    private $montantTotal;

    /**
     * @ORM\Column(type="text")
     */
    private $motif;

    /**
     * @ORM\ManyToOne(targetEntity=Personnel::class, inversedBy="sorties")
     */
    private $auteur;

    /**
     * @ORM\OneToMany(targetEntity=SortieMag::class, mappedBy="sortie", cascade={"persist", "remove"}, orphanRemoval=true)
     */
    private $sortieMags;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="sorties",cascade={"persist"})
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
        $this->dateSortie = new \DateTime();
        $this->sortieMags = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateSortie(): ?\DateTimeInterface
    {
        return $this->dateSortie;
    }

    public function setDateSortie(\DateTimeInterface $dateSortie): self
    {
        $this->dateSortie = $dateSortie;

        return $this;
    }

    public function getMontantTotal(): ?string
    {
        return $this->montantTotal;
    }

    public function setMontantTotal(string $montantTotal): self
    {
        $this->montantTotal = $montantTotal;

        return $this;
    }

    public function getMotif(): ?string
    {
        return $this->motif;
    }

    public function setMotif(string $motif): self
    {
        $this->motif = $motif;

        return $this;
    }

    public function getAuteur(): ?Personnel
    {
        return $this->auteur;
    }

    public function setAuteur(?Personnel $auteur): self
    {
        $this->auteur = $auteur;

        return $this;
    }

    /**
     * @return Collection<int, SortieMag>
     */
    public function getSortieMags(): Collection
    {
        return $this->sortieMags;
    }

    public function addSortieMag(SortieMag $sortieMag): self
    {
        if (!$this->sortieMags->contains($sortieMag)) {
            $this->sortieMags[] = $sortieMag;
            $sortieMag->setSortie($this);
        }

        return $this;
    }

    public function removeSortieMag(SortieMag $sortieMag): self
    {
        if ($this->sortieMags->removeElement($sortieMag)) {
            // set the owning side to null (unless already changed)
            if ($sortieMag->getSortie() === $this) {
                $sortieMag->setSortie(null);
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

   
}
