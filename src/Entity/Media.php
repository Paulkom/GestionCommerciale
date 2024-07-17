<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Repository\MediaRepository;
use App\Entity\Traits\Timestampable;
use Symfony\Component\HttpFoundation\File\UploadedFile;

/**
 * @ORM\Entity(repositoryClass=MediaRepository::class)
 * @ORM\HasLifecycleCallbacks
 * @ORM\EntityListeners({"App\EventListener\MediaListener"})
 */
class Media
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
    private $nomMedia;

    /**
     * @ORM\Column(type="string", length=80, nullable=true)
     */
    private $cheminMedia;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $numMedia;

    /**
     * @ORM\Column(name="extension", type="string", length=255)
     */
    private $extension;

    /**
     * @ORM\ManyToOne(targetEntity=Produit::class, inversedBy="medias",cascade={"persist"})
     */
    private $produit;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNomMedia(): ?string
    {
        return $this->nomMedia;
    }

    public function setNomMedia(string $nomMedia): self
    {
        $this->nomMedia = $nomMedia;

        return $this;
    }

    public function getCheminMedia(): ?string
    {
        return $this->cheminMedia;
    }

    public function setCheminMedia(string $cheminMedia): self
    {
        $this->cheminMedia = $cheminMedia;

        return $this;
    }

    public function getProduit(): ?Produit
    {
        return $this->produit;
    }

    public function setProduit(?Produit $produit): self
    {
        $this->produit = $produit;

        return $this;
    }

    public function getNumMedia(): ?string
    {
        return $this->numMedia;
    }

    public function setNumMedia(?string $numMedia): self
    {
        $this->numMedia = $numMedia;

        return $this;
    }

    /**
     * ce 06/03/2023 à 15:45
     * @author Romaric B. TOHOUNKPIN
     * Dynamisation de l'enregistrement des médias
     */

    /** @var UploadedFile $file */
    private $file;

    // Temporary store the file name
    private $tempFilename;

    /**
     * @ORM\OneToOne(targetEntity=Societe::class, mappedBy="logo", cascade={"persist", "remove"})
     */
    private $logoSociete;

    /**
     * @ORM\OneToOne(targetEntity=Societe::class, mappedBy="entete", cascade={"persist", "remove"})
     */
    private $enteteSociete;

    /**
     * @ORM\OneToOne(targetEntity=Societe::class, mappedBy="piedDePage", cascade={"persist", "remove"})
     */
    private $piedDePageSociete;

    /**
     * @ORM\Column(type="boolean", nullable=true)
     */
    private $estSup;

    /**
     * @ORM\ManyToOne(targetEntity=PointDeVente::class, inversedBy="media")
     */
    private $pointVente;

    public function getEstSup(): ?bool
    {
        return $this->estSup;
    }

    public function setEstSup(?bool $estSup): self
    {
        $this->estSup = $estSup;

        return $this;
    }    

    /**
     * @param ?UploadedFile $file - Uploaded File
     */
    public function setFile(?UploadedFile $file)
    {
        $this->file = $file;

        // Remplacement d'un fichier ? Vérifiez si nous avons déjà un fichier pour cette entité
        if (null !== $this->extension)
        {
            // Enregistrez l'extension de fichier afin que nous puissions la supprimer plus tard
            $this->tempFilename = $this->extension;

            // Réinitialiser les valeurs
            $this->extension = null;
            $this->nomMedia = null;
        }
    }

    /**
     * @return ?UploadedFile
     */
    public function getFile(): ?UploadedFile
    {
        return $this->file;
    }

    public function preUpload()
    {
        // Si aucun fichier n'est défini, ne rien faire
        if (null === $this->file)
        {
            return;
        }

        // Le nom du fichier est l'identifiant de l'entité
        // Nous devons également stocker l'extension de fichier
        $this->extension = $this->file->guessExtension();

        // Et nous gardons le nom d'origine
        $this->nomMedia = $this->file->getClientOriginalName();
    }

    public function upload()
    {
        // Si aucun fichier n'est défini, ne rien faire
        if (null === $this->file)
        {
            return;
        }

        // Un fichier est présent, supprimez-le
        if (null !== $this->tempFilename)
        {
            $oldFile = $this->getUploadRootDir().'/'.$this->id.'.'.$this->tempFilename;
            if (file_exists($oldFile))
            {
                unlink($oldFile);
            }
        }

        // Déplacez le fichier vers le dossier de téléchargement
        $this->file->move(
            $this->getUploadRootDir(),
            $this->id.'.'.$this->extension
        );
    }

    public function preRemoveUpload()
    {
        // Enregistrez le nom du fichier que nous voudrions supprimer
        $this->tempFilename = $this->getUploadRootDir().'/'.$this->id.'.'.$this->extension;
    }

    public function removeUpload()
    {
        // PostRemove => Nous n'avons plus l'identifiant de l'entité => Utilisez le nom que nous avons enregistré
        if (file_exists($this->tempFilename))
        {
            // Remove file
            unlink($this->tempFilename);
        }
    }

    public function getUploadDir()
    {
        // Répertoire de téléchargement
        if($this->getProduit()) {
            return 'uploads/medias/produit/' . $this->getProduit()->getId() . '/';
            // Ça signifie /public/uploads/medias/produit/
        }else{
            return 'uploads/medias/societe/';
        }
        // if($this->getLogoSociete() or $this->getEnteteSociete() or $this->getPiedDePageSociete()) {
        //     return 'uploads/medias/societe/';
        // }
        
    }

    protected function getUploadRootDir()
    {
        // On retourne le chemin relatif vers l'image pour notre code PHP
        // Emplacement de l'image (PHP)
        return __DIR__.'/../../public/'.$this->getUploadDir();
    }

    public function getUrl()
    {
        return $this->id.'.'.$this->extension;
    }
    /**
     * Fin de la dynamisation
     */

    public function getExtension(): ?string
    {
        return $this->extension;
    }

    public function setExtension(string $extension): self
    {
        $this->extension = $extension;

        return $this;
    }

    public function getLogoSociete(): ?Societe
    {
        return $this->logoSociete;
    }

    public function setLogoSociete(?Societe $logoSociete): self
    {
        // unset the owning side of the relation if necessary
        if ($logoSociete === null && $this->logoSociete !== null) {
            $this->logoSociete->setLogo(null);
        }

        // set the owning side of the relation if necessary
        if ($logoSociete !== null && $logoSociete->getLogo() !== $this) {
            $logoSociete->setLogo($this);
        }

        $this->logoSociete = $logoSociete;

        return $this;
    }

    public function getEnteteSociete(): ?Societe
    {
        return $this->enteteSociete;
    }

    public function setEnteteSociete(?Societe $enteteSociete): self
    {
        // unset the owning side of the relation if necessary
        if ($enteteSociete === null && $this->enteteSociete !== null) {
            $this->enteteSociete->setEntete(null);
        }

        // set the owning side of the relation if necessary
        if ($enteteSociete !== null && $enteteSociete->getEntete() !== $this) {
            $enteteSociete->setEntete($this);
        }

        $this->enteteSociete = $enteteSociete;

        return $this;
    }

    public function getPiedDePageSociete(): ?Societe
    {
        return $this->piedDePageSociete;
    }

    public function setPiedDePageSociete(?Societe $piedDePageSociete): self
    {
        // unset the owning side of the relation if necessary
        if ($piedDePageSociete === null && $this->piedDePageSociete !== null) {
            $this->piedDePageSociete->setPiedDePage(null);
        }

        // set the owning side of the relation if necessary
        if ($piedDePageSociete !== null && $piedDePageSociete->getPiedDePage() !== $this) {
            $piedDePageSociete->setPiedDePage($this);
        }

        $this->piedDePageSociete = $piedDePageSociete;

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
