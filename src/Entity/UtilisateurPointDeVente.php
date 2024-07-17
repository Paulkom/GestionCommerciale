<?php

namespace App\Entity;

use App\Repository\UtilisateurPointDeVenteRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=UtilisateurPointDeVenteRepository::class)
 */
class UtilisateurPointDeVente
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity=Utilisateur::class, inversedBy="utilisateurPointDeVentes")
     * @ORM\JoinColumn(nullable=false)
     */
    private $utilisateur;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="utilisateurPointDeVentes")
     * @ORM\JoinColumn(nullable=false)
     */
    private $pointDeVente;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estActif;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUtilisateur(): ?Utilisateur
    {
        return $this->utilisateur;
    }

    public function setUtilisateur(?Utilisateur $utilisateur): self
    {
        $this->utilisateur = $utilisateur;

        return $this;
    }

    public function getPointDeVente(): ?PointDeVente
    {
        return $this->pointDeVente;
    }

    public function setPointDeVente(?PointDeVente $pointDeVente): self
    {
        $this->pointDeVente = $pointDeVente;

        return $this;
    }

    public function getEstActif(): ?bool
    {
        return $this->estActif;
    }

    public function setEstActif(?bool $estActif): self
    {
        $this->estActif = $estActif;

        return $this;
    }
}
