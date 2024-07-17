<?php

namespace App\Security;

use App\Entity\Caisse;
use App\Entity\PointDeVente;
use App\Repository\SocieteRepository;
use App\Entity\UtilisateurPointDeVente;
use Doctrine\ORM\EntityManagerInterface;
use App\Repository\UtilisateurRepository;
use App\Repository\PointDeVenteRepository;
use App\Repository\ConfigurationRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Security;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Validator\Constraints\Length;
use App\Repository\UtilisateurPointDeVenteRepository;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\Security\Http\Authenticator\Passport\Passport;
use Symfony\Component\Security\Core\Exception\AuthenticationException;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Http\Authenticator\AbstractAuthenticator;
use Symfony\Component\Security\Http\Authenticator\Passport\Badge\UserBadge;
use Symfony\Component\Security\Http\Authenticator\Passport\PassportInterface;
use Symfony\Component\Security\Http\Authenticator\Passport\Badge\CsrfTokenBadge;
use Symfony\Component\Security\Core\Exception\CustomUserMessageAuthenticationException;
use Symfony\Component\Security\Http\Authenticator\Passport\Credentials\PasswordCredentials;

class LoginFormAuthenticator extends AbstractAuthenticator
{
    private CONST LOGIN_ROUTE = 'app_login';
    private UtilisateurRepository $userRepository;
    private UrlGeneratorInterface $urlGenerator;
    private SessionInterface $session;
    private SocieteRepository $societeRepository;
    private ConfigurationRepository $configurationRepository;
    private PointDeVenteRepository $pointDeVenteRepository;
    private  $upvRepo;
    private EntityManagerInterface $em;
   
    public function __construct(UtilisateurRepository $userRepository, UrlGeneratorInterface $urlGenerator, SessionInterface $session,
    SocieteRepository $societeRepository,ConfigurationRepository $configurationRepository,EntityManagerInterface $em, UtilisateurPointDeVenteRepository $upvrepo, PointDeVenteRepository $pvr)
    {
        $this->userRepository = $userRepository;
        $this->urlGenerator = $urlGenerator;
        $this->session = $session;
        $this->em = $em;
        $this->societeRepository = $societeRepository;
        $this->configurationRepository = $configurationRepository;
        $this->pointDeVenteRepository = $pvr;
        $this->upvRepo = $upvrepo;
    }

    /**
     * Does the authenticator support the given Request?
     *
     * If this returns false, the authenticator will be skipped.
     *
     * Returning null means authenticate() can be called lazily when accessing the token storage.
     */
    public function supports(Request $request): ?bool
    {
        return self::LOGIN_ROUTE === $request->attributes->get('_route')
            && $request->isMethod('POST');
    }

    /**
     * Create a passport for the current request.
     *
     * The passport contains the user, credentials and any additional information
     * that has to be checked by the Symfony Security system. For example, a login
     * form authenticator will probably return a passport containing the user, the
     * presented password and the CSRF token value.
     *
     * You may throw any AuthenticationException in this method in case of error (e.g.
     * a UserNotFoundException when the user cannot be found).
     *
     * @throws AuthenticationException
     */
    public function authenticate(Request $request): PassportInterface
    {
        $username = $request->request->get('_username');
        $user = $this->userRepository->findOneBy(['username' => $username]);
        if($user) {
            $pointDeVente = $this->em->getRepository(PointDeVente::class)->find($request->request->get('poiunt_de_vente'));
            $checkPointDeVente = $this->upvRepo->findBy(['utilisateur' => $user,'pointDeVente' => $pointDeVente, 'estActif' => true]);
            if(!$checkPointDeVente){
                throw new CustomUserMessageAuthenticationException('Point de vente non autorisé !!');
            }
        }
        
        return new Passport(
            new UserBadge($username, function (string $userIdentifier) {
                $user = $this->userRepository->findOneBy(['username' => $userIdentifier]);
                if (!$user) {
                    throw new CustomUserMessageAuthenticationException('Informations d\'identification non valides !!');
                }
                return $this->userRepository->findOneBy(['username' => $userIdentifier]);
            }),
            
            new PasswordCredentials($request->request->get('_password')),
            [
                new CsrfTokenBadge('authenticate', $request->request->get('_csrf_token'))
            ]
        );
    }

    /**
     * Called when authentication executed and was successful!
     *
     * This should return the Response sent back to the user, like a
     * RedirectResponse to the last page they visited.
     *
     * If you return null, the current request will continue, and the user
     * will be authenticated. This makes sense, for example, with an API.
     */
    public function onAuthenticationSuccess(Request $request, TokenInterface $token, string $firewallName): ?Response
    {
        // $pointDeVente = $this->pointDeVenteRepository->find($request->request->get('poiunt_de_vente'));
        $pointDeVente = $this->pointDeVenteRepository->findOneBy(['id' => $request->request->get('poiunt_de_vente') ]);
        
        $request->getSession()->remove('pointVente');
        $request->getSession()->set('pointVente',$pointDeVente);

        $username = $request->request->get('_username');
        $user = $this->userRepository->findOneBy(['username' => $username]);
        
        $caisseOuvert =  $this->em->getRepository(Caisse::class)->findOneBy(['user' => $user,'etatCaisse'=>null,'etat'=>0]);
        if ($caisseOuvert) {
            $request->getSession()->remove('caisse');
            $request->getSession()->set('caisse',$caisseOuvert);
        }
        
        $societe = $this->societeRepository->findAll();
        if(sizeof($societe)> 0){
            $soc = [
                'id'                => $societe[0]->getId(),
                'estRegimeTPS'      => $societe[0]->getEstRegimeTPS(),
                'estModeMecef'   => $societe[0]->getEstModeMecef(),
                'nim'               => $societe[0]->getApiNim(),
                'ifu'               => $societe[0]->getIfu(),
                'host'              => $societe[0]->getApiLink(),
                'messageCommercial' => $societe[0]->getMessageCommercial(),
                'token'             => $societe[0]->getApiToken() ];
            $this->session->set('societe', $soc);
        }

        $configuration = $this->configurationRepository->find(1);
        if($configuration){
            $this->session->set('configuration', $configuration);
        }

       
        return new RedirectResponse($this->urlGenerator->generate('app_admin_session_identity'));
    }

    /**
     * Called when authentication executed, but failed (e.g. wrong username password).
     *
     * This should return the Response sent back to the user, like a
     * RedirectResponse to the login page or a 403 response.
     *
     * If you return null, the request will continue, but the user will
     * not be authenticated. This is probably not what you want to do.
     */
    public function onAuthenticationFailure(Request $request, AuthenticationException $exception): ?Response
    {
        // dd($exception);
        $request->getSession()->set(Security::AUTHENTICATION_ERROR, $exception);
        return new RedirectResponse(
            $this->urlGenerator->generate('app_login')
        );
    }
}