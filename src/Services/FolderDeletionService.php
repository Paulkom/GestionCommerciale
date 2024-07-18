<?php

namespace App\Service;

use Psr\Log\LoggerInterface;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\Finder\Finder;

class FolderDeletionService
{
    private $filesystem;
    private $logger;

    public function __construct(Filesystem $filesystem, LoggerInterface $logger)
    {
        $this->filesystem = $filesystem;
        $this->logger = $logger;
    }

    public function deleteOldFolders(string $directory, int $minutes): void
    {
        $finder = new Finder();
        $finder->in($directory)->directories()->date("< now - $minutes minutes");

        foreach ($finder as $folder) {
            try {
                $this->filesystem->remove($folder->getRealPath());
                $this->logger->info("Deleted folder: " . $folder->getRealPath());
            } catch (\Exception $e) {
                $this->logger->error("Failed to delete folder: " . $folder->getRealPath() . ". Error: " . $e->getMessage());
            }
        }
    }
}
