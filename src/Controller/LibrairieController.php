<?php

namespace App\Controller;

use App\Entity\UtilisateurPointDeVente;
use App\Repository\PointDeVenteRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Security;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use App\Repository\UtilisateurPointDeVenteRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Session\SessionInterface;

class LibrairieController extends AbstractController
{
    /**
     * @var Security
     */
    private $security;

    public function __construct(Security $security)
    {
       $this->security = $security;
    }

    /**
     * @Route("/afficher/point-de-vente", name="app_afficher_point_de_vente", methods={"GET", "POST"})
     */
    public function afficherPointDeVente(Request $request, PointDeVenteRepository $pvr, UtilisateurPointDeVenteRepository $upvr): Response
    {
        $user = $this->security->getUser();
        $pvs = null;
        if($user){  
            $pvs =  $upvr->findBy(['utilisateur' => $user, 'estActif' => true]); 
            
        }
        // dd($pvr->findOneBy(['id' => 2]));
        
        
        if ($request->isMethod('POST')) {
            $pointventeId = $request->request->get('mPointDeVente');
            if($pointventeId){
                $pointvente = $pvr->findOneBy(['id' => $pointventeId]);
                // dd($pointvente);
                if($pointvente){
                    $request->getSession()->remove('pointVente');
                    $request->getSession()->set('pointVente',$pointvente);
                    return $this->redirectToRoute('app_admin_dashboard');
                }
            }
        }

        return $this->renderForm('default/modal.point.de.vente.html.twig', [
            'pointDeVentes' => $pvs,
        ]);
    }
}
