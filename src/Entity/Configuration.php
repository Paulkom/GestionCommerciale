<?php

namespace App\Entity;

use App\Entity\Traits\Timestampable;
use App\Repository\ConfigurationRepository;
use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass=ConfigurationRepository::class)
 * @ORM\HasLifecycleCallbacks
 */
class Configuration
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
    private $formatImpression;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $impressionPersonnaliseElements;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $impressionSansEntete;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estModeCarreau;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getFormatImpression(): ?string
    {
        return $this->formatImpression;
    }

    public function setFormatImpression(?string $formatImpression): self
    {
        $this->formatImpression = $formatImpression;

        return $this;
    }

    public function getImpressionPersonnaliseElements(): ?bool
    {
        return $this->impressionPersonnaliseElements;
    }

    public function setImpressionPersonnaliseElements(?bool $impressionPersonnaliseElements): self
    {
        $this->impressionPersonnaliseElements = $impressionPersonnaliseElements;

        return $this;
    }

    public function getImpressionSansEntete(): ?bool
    {
        return $this->impressionSansEntete;
    }

    public function setImpressionSansEntete(?bool $impressionSansEntete): self
    {
        $this->impressionSansEntete = $impressionSansEntete;

        return $this;
    }

    public function getEstModeCarreau(): ?bool
    {
        return $this->estModeCarreau;
    }

    public function setEstModeCarreau(?bool $estModeCarreau): self
    {
        $this->estModeCarreau = $estModeCarreau;

        return $this;
    }

   
}
