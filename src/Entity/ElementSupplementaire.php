<?php

namespace App\Entity;

use App\Repository\ElementSupplementaireRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ElementSupplementaireRepository::class)
 */
class ElementSupplementaire
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $titre;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $description;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $taillePolice;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $position;

    /**
     * @ORM\ManyToOne(targetEntity=CommandeClient::class, inversedBy="elementSupplementaires")
     * @ORM\JoinColumn(nullable=false)
     */
    private $commandeClient;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitre(): ?string
    {
        return $this->titre;
    }

    public function setTitre(string $titre): self
    {
        $this->titre = $titre;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(string $description): self
    {
        $this->description = $description;

        return $this;
    }

    public function getPosition(): ?string
    {
        return $this->position;
    }

    public function setPosition(?string $position): self
    {
        $this->position = $position;

        return $this;
    }

    public function getCommandeClient(): ?CommandeClient
    {
        return $this->commandeClient;
    }

    public function setCommandeClient(?CommandeClient $commandeClient): self
    {
        $this->commandeClient = $commandeClient;

        return $this;
    }

    public function getTaillePolice(): ?string
    {
        return $this->taillePolice;
    }

    public function setTaillePolice(?string $taillePolice): self
    {
        $this->taillePolice = $taillePolice;

        return $this;
    }


}
