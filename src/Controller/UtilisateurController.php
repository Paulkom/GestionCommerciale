<?php

namespace App\Controller;

use App\Entity\Utilisateur;
use App\Form\PersonnelType;
use App\Form\UtilisateurType;
use App\Form\UtilisateurMotPasseType;
use App\Repository\PersonnelRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Repository\UtilisateurRepository;
use App\Repository\PointDeVenteRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Security;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

/**
 * @Route("/admin/utilisateur")
 */
class UtilisateurController extends AbstractController
{
    private $passwordHasher;
    private $em;
    private $security;
    public function __construct(UserPasswordHasherInterface $passwordHasher, EntityManagerInterface $em, Security $security) {
        $this->passwordHasher = $passwordHasher;
        $this->security = $security;
        $this->em = $em;
    }
    
    /**
     * @Route("/{personnelId}", name="app_utilisateur_index", methods={"GET","POST"})
     */
    public function index(Request $request, UtilisateurRepository $utilisateurRepository,PersonnelRepository $personnelRepo, 
    PointDeVenteRepository $pvRepo,PointDeVenteRepository $pvre,$personnelId = null): Response
    {
        $pointDeVente = $pvre->find(1);
        $request->getSession()->set('pointVente',$pointDeVente);
        

        $utilisateur = new Utilisateur();
        if( $personnelId != ''){
            $personnel = $personnelRepo->find($personnelId);
            $utilisateur->setPersonnel($personnel);
        }

        $form = $this->createForm(UtilisateurType::class, $utilisateur, [
            'action' => $this->generateUrl('app_entity_callandsave', ['class'=>'utilisateur', 'action'=>'save']),
        ]);
        // $form->add('personnel', PersonnelType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
           
            $utilisateur->setPassword(
                $this->passwordHasher->hashPassword(
                    $utilisateur,
                    $form->get('password')->getData()
                )
            );
            $utilisateurRepository->add($utilisateur);
            return $this->redirectToRoute('app_utilisateur_index', [], Response::HTTP_SEE_OTHER);
        }
        return $this->renderForm('utilisateur/index.html.twig', [
            'utilisateurs' => $utilisateurRepository->findAll(),
            'form'         => $form,
            'personnelId'  => $personnelId,
        ]);
    }

    /**
     * @Route("/{id}", name="app_utilisateur_show", methods={"GET"})
     */
    public function show(Utilisateur $utilisateur): Response
    {
        return $this->render('utilisateur/show.html.twig', [
            'utilisateur' => $utilisateur,
        ]);
    }

    /**
     * @Route("/Update/Password", name="app_utilisateur_update_password", methods={"GET","POST"})
     */
    public function updatePassword(Request $request): Response
    {
        // $user = new Utilisateur();
        $user = $this->security->getUser();
        $changePasswordForm = $this->createForm(UtilisateurMotPasseType::class, $user);
        $changePasswordForm->handleRequest($request);

        if ($changePasswordForm->isSubmitted() && $changePasswordForm->isValid()) {

            $oldpassword = $changePasswordForm->get('oldPassword')->getData();
            //conformité de l'ancien mot de passe
            if( $this->passwordHasher->isPasswordValid($user, $oldpassword)){
               
                $user->setPassword($this->passwordHasher->hashPassword($user,$changePasswordForm->get('password')->getData()));
                $this->em->flush();
                return $this->redirectToRoute('app_logout');
                
            }else{
                return new JsonResponse("Ancien mot de passe incorrecte");
            }
        }

        return $this->render('utilisateur/change-password.html.twig', [
            'form' => $changePasswordForm->createView(),
        ]);
    }

    /**
     * @Route("/{id}/edit", name="app_utilisateur_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Utilisateur $utilisateur, UtilisateurRepository $utilisateurRepository): Response
    {
        $form = $this->createForm(UtilisateurType::class, $utilisateur);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $utilisateurRepository->add($utilisateur);
            return $this->redirectToRoute('app_utilisateur_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('utilisateur/edit.html.twig', [
            'utilisateur' => $utilisateur,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_utilisateur_delete", methods={"POST"})
     */
    public function delete(Request $request, Utilisateur $utilisateur, UtilisateurRepository $utilisateurRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$utilisateur->getId(), $request->request->get('_token'))) {
            $utilisateurRepository->remove($utilisateur);
        }
        return $this->redirectToRoute('app_utilisateur_index', [], Response::HTTP_SEE_OTHER);
    }
}
