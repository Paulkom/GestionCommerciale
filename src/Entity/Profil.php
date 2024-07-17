<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Entity\Traits\Timestampable;
use App\Repository\ProfilRepository;
use App\AjaxifySearch\Annotation\AjaxifySearch;

/**
 * @ORM\Entity(repositoryClass=ProfilRepository::class)
 * @ORM\HasLifecycleCallbacks
 * @AjaxifySearch(
 *     alias = "profil",
 *     itemTemplate = "profil/partials/item.html.twig",
 *     searchables = {
 *          "titre", "roles"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class Profil
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
    private $titre;

    /**
     * @ORM\Column(type="json", nullable=true)
     */
    private $roles = [];

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="profils")
     * @ORM\JoinColumn(nullable=true)
     */
    private $pointVente;

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

    public function getRoles(): ?array
    {
        return $this->roles;
    }

    public function setRoles(?array $roles): self
    {
        $this->roles = $roles;

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
