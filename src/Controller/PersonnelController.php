<?php

namespace App\Controller;

use App\Entity\Personnel;
use App\Entity\Utilisateur;
use App\Form\PersonnelType;
use App\Form\UtilisateurType;
use App\Form\RegistrationFormType;
use App\Repository\PersonnelRepository;
use App\Repository\UtilisateurRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

/**
 * @Route("/admin/personnel")
 */
class PersonnelController extends AbstractController
{
    private $session;
    public function __construct(SessionInterface $session)
    {
        $this->session = $session;
    }
    /**
     * @Route("/", name="app_personnel_index", methods={"GET","POST"})
     */
    public function index(Request $request,PersonnelRepository $personnelRepository, UtilisateurRepository $utilisateurRepository): Response
    {
        $personnel = new Personnel();
        $form = $this->createForm(PersonnelType::class, $personnel);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $personnelRepository->add($personnel);
            if($personnel->getId() != null)
                return new JsonResponse("Enregistrement effectué avec succès.");
        }

        return $this->renderForm('personnel/index.html.twig', [
            'personnels' => $personnelRepository->findBy(array(),array(),null,1),
            'form' => $form,
            // 'formCompte' => $formCompte,
        ]);
    }
    

   

    // /**
    //  * @Route("/{id}", name="app_personnel_show", methods={"GET"})
    //  */
    // public function show(Personnel $personnel): Response
    // {
    //     return $this->render('personnel/show.html.twig', [
    //         'personnel' => $personnel,
    //     ]);
    // }

    /**
     * @Route("/modal-show/{id}", name="app_personnel_show", methods={"GET", "POST"})
     */
    public function show(Personnel $personnel): Response
    {
        $view = $this->renderView('personnel/partials/_card_show.html.twig', compact('personnel'));
        return new JsonResponse($view);
    }

    /**
     * @Route("/{id}/edit", name="app_personnel_edit", methods={"GET", "POST"})
     */
    public function edit(Request $request, Personnel $personnel, PersonnelRepository $personnelRepository): Response
    {
        $form = $this->createForm(PersonnelType::class, $personnel);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $personnelRepository->add($personnel);
            return $this->redirectToRoute('app_personnel_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('personnel/edit.html.twig', [
            'personnel' => $personnel,
            'form' => $form,
        ]);
    }

    /**
     * @Route("/{id}", name="app_personnel_delete", methods={"POST"})
     */
    public function delete(Request $request, Personnel $personnel, PersonnelRepository $personnelRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$personnel->getId(), $request->request->get('_token'))) {
            $personnelRepository->remove($personnel);
        }

        return $this->redirectToRoute('app_personnel_index', [], Response::HTTP_SEE_OTHER);
    }
}
