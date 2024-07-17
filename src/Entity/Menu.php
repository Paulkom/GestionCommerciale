<?php

namespace App\Entity;

use App\Entity\Traits\Timestampable;
use App\Repository\MenuRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use App\AjaxifySearch\Annotation\AjaxifySearch;

/**
 * @ORM\Entity(repositoryClass=MenuRepository::class)
 * @AjaxifySearch(
 *     alias = "menu",
 *     itemTemplate = "menu/partials/item.html.twig",
 *     relations = { "menuSuperieur" },
 *     searchables = {
 *          "menuSuperieur.sousTitre", "menuSuperieur.titre", "menuSuperieur.url",
 *          "sousTitre", "titre", "url"
 *      },
 *     orderBy = {"id": "DESC" }
 * )
 */
class Menu
{
    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $sousTitre;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $titre;

    /**
     * @ORM\Column(type="string", length=4000, nullable=true)
     */
    private $url;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $active;

    /**
     * @ORM\ManyToOne(targetEntity=Menu::class, inversedBy="sousMenus")
     * @ORM\JoinColumn(nullable=true)
     */
    private $menuSuperieur;

    /**
     * @ORM\OneToMany(targetEntity=Menu::class, mappedBy="menuSuperieur", cascade={"persist", "remove"})
     */
    private $sousMenus;

    /**
     * @ORM\Column(type="text", nullable=true)
     */
    private $icon;

    /**
     * @ORM\Column(type="string", length=2, nullable=true)
     */
    private $typeMenu;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="menus")
     */
    private $pointVente;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $roles;

    
    public function __construct()
    {
        $this->sousMenus = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getSousTitre(): ?string
    {
        return $this->sousTitre;
    }

    public function setSousTitre(?string $sousTitre): self
    {
        $this->sousTitre = $sousTitre;

        return $this;
    }

    public function getTitre(): ?string
    {
        return $this->titre;
    }

    public function setTitre(?string $titre): self
    {
        $this->titre = $titre;

        return $this;
    }

    public function getUrl(): ?string
    {
        return $this->url;
    }

    public function setUrl(?string $url): self
    {
        $this->url = $url;

        return $this;
    }

    public function getActive(): ?bool
    {
        return $this->active;
    }

    public function setActive(?bool $active): self
    {
        $this->active = $active;

        return $this;
    }

    public function getMenuSuperieur(): ?self
    {
        return $this->menuSuperieur;
    }

    public function setMenuSuperieur(?self $menuSuperieur): self
    {
        $this->menuSuperieur = $menuSuperieur;

        return $this;
    }

    /**
     * @return Collection<int, self>
     */
    public function getSousMenus(): Collection
    {
        return $this->sousMenus;
    }

    public function addSousMenu(self $sousMenu): self
    {
        if (!$this->sousMenus->contains($sousMenu)) {
            $this->sousMenus[] = $sousMenu;
            $sousMenu->setMenuSuperieur($this);
        }

        return $this;
    }

    public function removeSousMenu(self $sousMenu): self
    {
        if ($this->sousMenus->removeElement($sousMenu)) {
            // set the owning side to null (unless already changed)
            if ($sousMenu->getMenuSuperieur() === $this) {
                $sousMenu->setMenuSuperieur(null);
            }
        }

        return $this;
    }

    public function getIcon(): ?string
    {
        return $this->icon;
    }

    public function setIcon(?string $icon): self
    {
        $this->icon = $icon;

        return $this;
    }

    public function getTypeMenu(): ?string
    {
        return $this->typeMenu;
    }

    public function setTypeMenu(?string $typeMenu): self
    {
        $this->typeMenu = $typeMenu;

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

    public function getRoles(): ?string
    {
        return $this->roles;
    }

    public function setRoles(?string $roles): self
    {
        $this->roles = $roles;

        return $this;
    }

}
