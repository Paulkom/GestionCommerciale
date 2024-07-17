<?php

namespace App\Entity;

use App\Repository\PaysRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=PaysRepository::class)
 */
class Pays
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
    private $code;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $libelleFR;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $libelleEN;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getCode(): ?string
    {
        return $this->code;
    }

    public function setCode(?string $code): self
    {
        $this->code = $code;

        return $this;
    }

    public function getLibelleFR(): ?string
    {
        return $this->libelleFR;
    }

    public function setLibelleFR(string $libelleFR): self
    {
        $this->libelleFR = $libelleFR;

        return $this;
    }

    public function getLibelleEN(): ?string
    {
        return $this->libelleEN;
    }

    public function setLibelleEN(?string $libelleEN): self
    {
        $this->libelleEN = $libelleEN;

        return $this;
    }

    public function __toString()
    {
        return $this->libelleFR.' [ '. $this->getCode().' ] ';
    }
}
