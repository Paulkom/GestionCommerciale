<?php

namespace App\Entity;

use App\Repository\ObjectifRepository;
use App\Entity\Traits\Timestampable;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ObjectifRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Objectif
{

    use Timestampable;

    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="decimal", precision=30, scale=2, nullable=true)
     */
    private $montantObjectif;

    /**
     * @ORM\Column(type="datetime")
     */
    private $dateMois;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

        /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estActif;

    public function __construct()
    {
        $this->estSup = false;
        $this->estActif = true;
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getMontantObjectif(): ?string
    {
        return $this->montantObjectif;
    }

    public function setMontantObjectif(?string $montantObjectif): self
    {
        $this->montantObjectif = $montantObjectif;

        return $this;
    }

    public function getDateMois(): ?\DateTimeInterface
    {
        return $this->dateMois;
    }

    public function setDateMois(\DateTimeInterface $dateMois): self
    {
        $this->dateMois = $dateMois;

        return $this;
    }

    public function getEstSup(): ?bool
    {
        return $this->estSup;
        //estActif
    }
    public function setEstSup(?bool $estSup): self
    {
        $this->estSup = $estSup;

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
