<?php

namespace App\Services;

use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\String\Slugger\SluggerInterface;

class FileUploader
{
    private $targetDirectory;
    private $slugger;

    public function __construct($targetDirectory, SluggerInterface $slugger)
    {
        $this->targetDirectory = $targetDirectory;
        $this->slugger = $slugger;
    }

    public function delete(UploadedFile $file, $newpath = null)
    {
        $path = $this->getTargetDirectory();
        if($newpath !== null)
        {
            if(!is_dir($newpath))
            {
                mkdir($newpath, 0777, true);
            }
            $path = $newpath;
        }
        $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $safeFilename = $this->slugger->slug($originalFilename);
        $fileName = $safeFilename.'.'.$file->guessExtension();
        $completefilepath = $path . '/' .$fileName;
        if(file_exists($completefilepath))
            unlink($completefilepath);
    }

    public function upload(UploadedFile $file, $newpath = null)
    {
        $path = $this->getTargetDirectory();
        if($newpath !== null)
        {
            if(!is_dir($newpath))
            {
                mkdir($newpath, 0777, true);
            }
            $path = $newpath;
        }
        $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $safeFilename = $this->slugger->slug($originalFilename);
        $fileName = $safeFilename.'.'.$file->guessExtension();
        $completefilepath = $path . '/' .$fileName;
        if(file_exists($completefilepath))
            unlink($completefilepath);
        try {
            $file->move($path, $fileName);
        } catch (FileException $e) {

        }

        return [$safeFilename.'', $fileName];
    }

    public function getTargetDirectory()
    {
        return $this->targetDirectory;
    }
}