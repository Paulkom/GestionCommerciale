<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\DetachementRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;

/**
 * @ORM\Entity(repositoryClass=DetachementRepository::class)
 */
class Detachement
{
    use Timestampable;
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="datetime", nullable=true)
     */
    private $dateDet;

    /**
     * @ORM\ManyToOne(targetEntity=Utilisateur::class, inversedBy="detachements")
     */
    private $userDet;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=Magasin::class, inversedBy="detachements")
     */
    private $magasin;

    /**
     * @ORM\OneToMany(targetEntity=ProduitDetacher::class, mappedBy="detachement",cascade={"persist"})
     */
    private $produitDetachers;

    public function __construct()
    {
        $this->produitDetachers = new ArrayCollection();
        $this->dateDet = new \DateTime();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDateDet(): ?\DateTimeInterface
    {
        return $this->dateDet;
    }

    public function setDateDet(?\DateTimeInterface $dateDet): self
    {
        $this->dateDet = $dateDet;
        return $this;
    }

    public function getUserDet(): ?Utilisateur
    {
        return $this->userDet;
    }

    public function setUserDet(?Utilisateur $userDet): self
    {
        $this->userDet = $userDet;
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

    public function getMagasin(): ?Magasin
    {
        return $this->magasin;
    }

    public function setMagasin(?Magasin $magasin): self
    {
        $this->magasin = $magasin;
        return $this;
    }

    /**
     * @return Collection<int, ProduitDetacher>
     */
    public function getProduitDetachers(): Collection
    {
        return $this->produitDetachers;
    }

    public function addProduitDetacher(ProduitDetacher $produitDetacher): self
    {
        if (!$this->produitDetachers->contains($produitDetacher)) {
            $this->produitDetachers[] = $produitDetacher;
            $produitDetacher->setDetachement($this);
        }

        return $this;
    }

    public function removeProduitDetacher(ProduitDetacher $produitDetacher): self
    {
        if ($this->produitDetachers->removeElement($produitDetacher)) {
            // set the owning side to null (unless already changed)
            if ($produitDetacher->getDetachement() === $this) {
                $produitDetacher->setDetachement(null);
            }
        }
        return $this;
    }

    
}
