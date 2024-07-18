<?php

namespace App\Services;

use DateTime;
use DateTimeZone;
use Psr\Log\LoggerInterface;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\Finder\Finder;

class ScheduledTaskService
{
    private $filesystem;
    private $logger;
    private $executionTime;

    public function __construct(Filesystem $filesystem, LoggerInterface $logger)
    {
        $this->filesystem = $filesystem;
        $this->logger = $logger;
        $this->executionTime = new DateTime('2024-07-18 20:49:00', new DateTimeZone('Africa/Porto-Novo'));
    }

    public function deleteOldFolders(string $directory): void
    {
        $finder = new Finder();
        $finder->in($directory)->directories();

        foreach ($finder as $folder) {
            try {
                $this->filesystem->remove($folder->getRealPath());
                $this->logger->info("Deleted folder: " . $folder->getRealPath());
            } catch (\Exception $e) {
                $this->logger->error("Failed to delete folder: " . $folder->getRealPath() . ". Error: " . $e->getMessage());
            }
        }
    }

    public function checkAndExecute(string $directory): void
    {
        // Obtenir l'heure actuelle avec le fuseau horaire spécifié
        $currentTime = new DateTime('now', new DateTimeZone('Africa/Porto-Novo'));

        // // Affichage des informations pour le débogage
        // dump("EMPLACEMENT ==> ", $directory);
        // dump("Timestamp actuel: ", $currentTime->getTimestamp());
        // dump("Timestamp d'exécution: ", $this->executionTime->getTimestamp());
        // dump("IS EQUAL ? ===> ", ($currentTime->getTimestamp() >= $this->executionTime->getTimestamp()));

        // // Vérifier si l'heure actuelle est supérieure ou égale à l'heure d'exécution prévue
        // if (($currentTime->getTimestamp()) >= ($this->executionTime->getTimestamp())) {
        //     // Déclencher la suppression des dossiers
        $this->deleteOldFolders($directory);
        //     dd("C'est bon");
        // } else {
        //     dd("C'est pas bon");
        // }
    }
}
