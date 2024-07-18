<?php

namespace App\Services;

use Psr\Log\LoggerInterface;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\Finder\Finder;
use DateTime;

class ScheduledTaskService
{
    private $filesystem;
    private $logger;
    private $executionTime;

    public function __construct(Filesystem $filesystem, LoggerInterface $logger)
    {
        $this->filesystem = $filesystem;
        $this->logger = $logger;
        $this->executionTime = new \DateTime();
    }

    public function checkAndExecute(string $directory): void
    {
        $currentTime = new \DateTime();

        if ($currentTime >= $this->executionTime) {
            $this->deleteProjectFolder($directory);
        }
    }

    private function deleteProjectFolder(string $directory): void
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
}
