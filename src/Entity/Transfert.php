<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\TransfertRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;
use Symfony\Component\Validator\Constraints as Assert;
use App\AjaxifySearch\Annotation\AjaxifySearch;

/**
 * @ORM\Entity(repositoryClass=TransfertRepository::class)
 * @ORM\HasLifecycleCallbacks
 * @AjaxifySearch(
 *     alias = "transfert",
 *     itemTemplate = "transfert/partials/item.html.twig",
 *     relations = { "magasinTrans1", "magasinTrans2" },
 *     searchables = {
 *          "dateTrans", "motif", "montantTotal", "magasinTrans1.codeMag", "magasinTrans1.nomMag",
 *          "magasinTrans2.codeMag", "magasinTrans2.nomMag"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class Transfert
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
    private $dateTrans;

    /**
     * @ORM\Column(type="text")
     * @Assert\NotBlank(message="Le motif est obligatoire")
     */
    private $motif;

    /**
     * @ORM\Column(type="decimal", precision=10, scale=2, nullable=true)
     * @Assert\NotBlank(message="Le montant total n'est pas défini")
     */
    private $montantTotal;

    /**
     * @ORM\ManyToOne(targetEntity=Magasin::class, inversedBy="transfertsMag1")
     * @ORM\JoinColumn(nullable=false)
     */
    private $magasinTrans1;

    /**
     * @ORM\ManyToOne(targetEntity=Magasin::class, inversedBy="transfertsMag2")
     * @ORM\JoinColumn(nullable=false)
     */
    private $magasinTrans2;

    /**
     * @ORM\OneToMany(targetEntity=ProduitCondTrans::class, mappedBy="transfert", cascade={"persist", "remove"}, orphanRemoval=true)
     */
    private $produitCondTrans;
   
    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="transferts",cascade={"persist"})
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
        $this->dateTrans = new \DateTime();
        $this->produitCondTrans = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateTrans(): ?\DateTimeInterface
    {
        return $this->dateTrans;
    }

    public function setDateTrans(\DateTimeInterface $dateTrans): self
    {
        $this->dateTrans = $dateTrans;

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

    public function getMontantTotal(): ?string
    {
        return $this->montantTotal;
    }

    public function setMontantTotal(string $montantTotal): self
    {
        $this->montantTotal = $montantTotal;

        return $this;
    }

    public function getMagasinTrans1(): ?Magasin
    {
        return $this->magasinTrans1;
    }

    public function setMagasinTrans1(?Magasin $magasinTrans1): self
    {
        $this->magasinTrans1 = $magasinTrans1;

        return $this;
    }

    public function getMagasinTrans2(): ?Magasin
    {
        return $this->magasinTrans2;
    }

    public function setMagasinTrans2(?Magasin $magasinTrans2): self
    {
        $this->magasinTrans2 = $magasinTrans2;

        return $this;
    }

    /**
     * @return Collection<int, ProduitCondTrans>
     */
    public function getProduitCondTrans(): Collection
    {
        return $this->produitCondTrans;
    }

    public function addProduitCondTran(ProduitCondTrans $produitCondTran): self
    {
        if (!$this->produitCondTrans->contains($produitCondTran)) {
            $this->produitCondTrans[] = $produitCondTran;
            $produitCondTran->setTransfert($this);
        }

        return $this;
    }

    public function removeProduitCondTran(ProduitCondTrans $produitCondTran): self
    {
        if ($this->produitCondTrans->removeElement($produitCondTran)) {
            // set the owning side to null (unless already changed)
            if ($produitCondTran->getTransfert() === $this) {
                $produitCondTran->setTransfert(null);
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
