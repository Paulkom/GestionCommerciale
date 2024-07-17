<?php

namespace App\Entity\Traits;

trait Timestampable
{

    /**
     * @ORM\Column(type="datetime", nullable=true, options={"default" : "CURRENT_TIMESTAMP"})
     */
    private $createdAt;

    /**
     * @ORM\Column(type="datetime", nullable=true )
     */
    private $updatedAt;

    /**
     * @ORM\Column(type="datetime", nullable=true )
     */
    private $deletedAt;
    
    
    public function getCreatedAt(): ?\DateTimeInterface
    {
        return $this->createdAt;
    }

    public function setCreatedAt(?\DateTimeInterface $created): self
    {
        $this->createdAt = $created;

        return $this;
    }

    public function getUpdatedAt(): ?\DateTimeInterface
    {
        return $this->updatedAt;
    }

    public function setUpdatedAt(?\DateTimeInterface $updated): self
    {
        $this->updatedAt = $updated;

        return $this;
    }

    public function getDeletedAt(): ?\DateTimeInterface
    {
        return $this->deletedAt;
    }

    public function setDeletedAt(?\DateTimeInterface $deleted): self
    {
        $this->deletedAt = $deleted;

        return $this;
    }

    /**
     * @ORM\PrePersist
     * @ORM\PreUpdate
     */
    public function updateTimestamps()
    {
        if( $this->getCreatedAt() === null){
            $this->setCreatedAt(new \DateTimeImmutable);
        }else{
            $this->setUpdatedAt(new \DateTimeImmutable);
        }
    }

}

?>