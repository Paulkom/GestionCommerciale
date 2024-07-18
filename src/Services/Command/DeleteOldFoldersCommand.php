<?php

namespace App\Command;

use App\Service\FolderDeletionService;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class DeleteOldFoldersCommand extends Command
{
    protected static $defaultName = 'app:delete-old-folders';

    private $folderDeletionService;

    public function __construct(FolderDeletionService $folderDeletionService)
    {
        parent::__construct();
        $this->folderDeletionService = $folderDeletionService;
    }

    protected function configure()
    {
        $this
            ->setDescription('Deletes folders older than a specified number of minutes')
            ->setHelp('This command allows you to delete folders older than a specified number of minutes...');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);

        // Path to the directory and the number of minutes
        $directory = '/path/to/your/folder';
        $minutes = 5;

        $this->folderDeletionService->deleteOldFolders($directory, $minutes);

        $io->success('Old folders have been deleted.');

        return Command::SUCCESS;
    }
}
