<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\FonctionRepository;
use Doctrine\Common\Collections\Collection;
use ApiPlatform\Core\Annotation\ApiResource;
use Doctrine\Common\Collections\ArrayCollection;
use Symfony\Component\Serializer\Annotation\Groups;

/**
 * @ORM\Entity(repositoryClass=FonctionRepository::class)
 * @ORM\HasLifecycleCallbacks
 * @ApiResource
 */
class Fonction
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     * @Groups("fonction:read")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     * @Groups("fonction:read")
     */
    private $code;

    /**
     * @ORM\Column(type="string", length=255)
     * @Groups("fonction:read")
     */
    private $intitule;

    /**
     * @ORM\OneToMany(targetEntity=FonctionPersonnel::class, mappedBy="fonction", orphanRemoval=true)
     */
    private $fonctionPersonnels;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="fonctions",cascade={"persist"})
     */
    private $pointVente;

    /**
     * @ORM\OneToMany(targetEntity=ModelSignatairePersonnelFonction::class, mappedBy="fonction")
     */
    private $modelSignatairePersonnelFonctions;

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
        $this->fonctionPersonnels = new ArrayCollection();
        $this->modelSignatairePersonnelFonctions = new ArrayCollection();
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

    public function getIntitule(): ?string
    {
        return $this->intitule;
    }

    public function setIntitule(string $intitule): self
    {
        $this->intitule = $intitule;

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
            $fonctionPersonnel->setFonction($this);
        }

        return $this;
    }

    public function removeFonctionPersonnel(FonctionPersonnel $fonctionPersonnel): self
    {
        if ($this->fonctionPersonnels->removeElement($fonctionPersonnel)) {
            // set the owning side to null (unless already changed)
            if ($fonctionPersonnel->getFonction() === $this) {
                $fonctionPersonnel->setFonction(null);
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
            $modelSignatairePersonnelFonction->setFonction($this);
        }

        return $this;
    }

    public function removeModelSignatairePersonnelFonction(ModelSignatairePersonnelFonction $modelSignatairePersonnelFonction): self
    {
        if ($this->modelSignatairePersonnelFonctions->removeElement($modelSignatairePersonnelFonction)) {
            // set the owning side to null (unless already changed)
            if ($modelSignatairePersonnelFonction->getFonction() === $this) {
                $modelSignatairePersonnelFonction->setFonction(null);
            }
        }

        return $this;
    }
}
