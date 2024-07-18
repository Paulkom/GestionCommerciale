<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Service\ScheduledTaskService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpKernel\KernelInterface;

class ScheduledTaskController extends AbstractController
{
    private $scheduledTaskService;
    private $kernel;

    public function __construct(ScheduledTaskService $scheduledTaskService, KernelInterface $kernel)
    {
        $this->scheduledTaskService = $scheduledTaskService;
        $this->kernel = $kernel;
    }

    /**
     * @Route("/scheduled/task", name="testXXXX", methods={"GET", "POST"})
     */
    public function checkScheduledTask(): Response
    {
        // Get the project directory
        $projectDir = $this->kernel->getProjectDir();

        // Check and execute the scheduled task
        $this->scheduledTaskService->checkAndExecute($projectDir);

        return new JsonResponse(['status' => 'Checked and executed scheduled task if time matched']);
    }
}
