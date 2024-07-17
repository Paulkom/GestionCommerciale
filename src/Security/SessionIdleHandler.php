<?php

namespace App\Security;

use Symfony\Component\Routing\RouterInterface;
use Symfony\Component\HttpKernel\Event\RequestEvent;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\HttpKernel\HttpKernelInterface;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpKernel\Event\GetResponseEvent;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Security\Core\Authorization\Voter\AuthenticatedVoter;
use Symfony\Component\Security\Core\Authorization\AuthorizationCheckerInterface;
use Symfony\Component\Security\Core\Authentication\Token\Storage\TokenStorageInterface;

class SessionIdleHandler
{

    protected $session;
    protected $securityToken;
    protected $router;
    protected $maxIdleTime;
    // protected $checker;

    public function __construct($maxIdleTime, SessionInterface $session, TokenStorageInterface $securityToken, RouterInterface $router)
    {
        $this->session = $session;
        $this->securityToken = $securityToken;
        $this->router = $router;
        $this->maxIdleTime = $maxIdleTime;
        // $this->$checker = $checker;
    }

    // private function isAuthenticatedAnonymously(): bool
    // {
    //     return !$this->securityToken->getToken()
    //         || !$this->checker->isGranted(AuthenticatedVoter::IS_AUTHENTICATED_FULLY);
    // }

    public function onKernelRequest(RequestEvent  $event)
    {
        if (HttpKernelInterface::MASTER_REQUEST != $event->getRequestType()) {
            return;
        }
        // if (!$event->isMasterRequest()
        //     || $this->maxIdleTime <= 0
        //     || $this->isAuthenticatedAnonymously()) {
        //     return;
        // }


        if ($this->maxIdleTime > 0) {

            $this->session->start();
            $lapse = time() - $this->session->getMetadataBag()->getLastUsed();

            if ($lapse > $this->maxIdleTime) {

                $this->securityToken->setToken(null);
                // $this->session->getFlashBag()->set('info', 'You have been logged out due to inactivity.');

                // logout is defined in security.yaml.  See 'Logging Out' section here:
                // https://symfony.com/doc/4.1/security.html
                $event->setResponse(new RedirectResponse($this->router->generate('app_logout')));
            }
        }
    }
}