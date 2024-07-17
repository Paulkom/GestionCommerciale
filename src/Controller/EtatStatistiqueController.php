<?php

namespace App\Controller;

use App\Entity\Inventaire;
use App\Entity\Magasin;
use App\Entity\ProduitCondApproMag;
use App\Entity\ProduitCondMagInv;
use App\Entity\ProduitCondMagLiv;
use App\Entity\Societe;
use App\Form\FiltrePeriodeType;
use App\Repository\CaisseRepository;
use App\Repository\ClientRepository;
use App\Repository\CommandeClientRepository;
use App\Repository\DepenseRepository;
use App\Repository\InventaireMagRepository;
use App\Repository\InventaireRepository;
use App\Repository\MagasinRepository;
use App\Repository\ModelSignataireRepository;
use App\Repository\PaiementRepository;
use App\Repository\ProduitCondApproMagRepository;
use App\Repository\ProduitCondApproRepository;
use App\Repository\ProduitCondComClitRepository;
use App\Repository\ProduitConditionnementRepository;
use App\Repository\ProduitCondMagInvRepository;
use App\Repository\ProduitCondMagLivRepository;
use App\Repository\ProduitCondMagRepository;
use App\Repository\ProduitCondSortieMagRepository;
use App\Repository\ProduitRepository;
use App\Repository\SocieteRepository;
use App\Repository\TransactionRepository;
use App\Services\LibrairieService;
use DateTime;
use Doctrine\ORM\EntityManager;
use Doctrine\ORM\EntityManagerInterface;
use Oro\ORM\Query\AST\Platform\Functions\Mysql\Date;
use SessionIdInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/etat")
 */
class EtatStatistiqueController extends AbstractController
{

    
    /**
     * @Route("/print_product-{type}", name="romassigcom_print_product_stock", methods={"GET","POST"})
     */
    public function imprime(Request $request,  ProduitCondMagLivRepository $produitCondMagLivRepository,ProduitConditionnementRepository $produitConditionnementRepository,DepenseRepository $depenseRepository, CaisseRepository $caisseRepository,  MagasinRepository $magasinRepository,ProduitCondMagInvRepository $produitCondMagInvRepository,  ProduitCondComClitRepository $produitCondComClitRepository, CommandeClientRepository $commandeClientRepository,  ProduitCondSortieMagRepository $produitCondSortieMagRepository, ProduitCondApproMagRepository $produitCondApproMagRepository, PaiementRepository $paieRep,SocieteRepository $sociRep, TransactionRepository $transactionRepository, LibrairieService $librairieService,ProduitRepository $produitRepository,ProduitCondMagRepository $prodConMagRep, InventaireMagRepository $inventaireRep,  $type =null){
        //dd($request);
        $ent = null;
        if($sociRep->findAll()){
            $ent = ($sociRep->findAll())[0];
        }
        $view=null;
        set_time_limit(-1);
        $point =  $request->getSession()->get('pointVente')->getId();
        $type = $request->query->get("type");
        $date1 = $request->query->get("date1");
        $date2 = $request->query->get("date2");
        $recherche = $request->query->get("recherche");
        $client = $request->query->get("client");
        $magasin = $request->query->get("magasin");
        $produit = $request->query->get("produit");
        $donnes = $request->query->get("donnees");
        $typeCommande = $request->query->get("typeCommande");
        $statut = $request->query->get("statut") == "undefined" ? "": $request->query->get("statut");
        $statutLiv = $request->query->get("statutLiv") == "undefined" ? "": $request->query->get("statutLiv");
        $date1 = $date1 == "undefined" ? "": $date1;
        $date2 = $date2 == "undefined" ? "": $date2;
        $date2 = $date2 == "undefined" ? "": $date2;
        $recherche = $recherche == "undefined" ? "": $recherche;
        $typeCommande = $typeCommande == "undefined" ? "": $typeCommande;
        $format = "A4-P";

        if($date1 != "undefined" && $date1 != ""){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2 && $date2 != "undefined" && $date2 != ""){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        $title="Imprimer";
        if ($type == "Liste des produits disponibles en stock"){
            $view = $this->prodDispoPrint('etat_statistique/stock/imprime/produit_dispo.html.twig','donnees',$produitRepository->proddisposImp($recherche,$point));
            $title =  "Liste des produits disponibles en stock";
        }
        if ($type == "Liste des produits retournées"){
            $view = $this->prodDispoPrint('etat_statistique/stat_produits/imprime/produit_retourne.html.twig','donnees',$produitCondComClitRepository->prodretourneImp($point,$recherche,$date1, $date2,$produit,$client));
            $title =  "Liste des produits disponibles en stock";
        }
        if ($type == "Produit conditionnement"){
            $view = $this->prodDispoPrint('etat_statistique/stat_produits/imprime/produit_conditionnement.html.twig','donnees',$produitConditionnementRepository->prodconditionnementImp($point,$recherche));
            $title =  "Liste des produits disponibles en stock";
        }
        if ($type == "Mouvement global du stock"){
            $view = $this->prodDispoPrint('etat_statistique/stock/imprime/stock_global.html.twig','magasins',json_decode($donnes));
            $title =  $type;
        }
        if($type == "Liste des produits en rupture de stock"){
            $view =  $this->prodDispoPrint('etat_statistique/stock/imprime/produit_rupture.html.twig','donnees',$produitRepository->prodRuptImp($recherche,$point));
            $title="Liste des produits en rupture de stock";
        }
        if($type == "Client Activités"){
            $view = $this->prodDispoPrint("etat_statistique/stat_produits/imprime/client_activites.html.twig",'donnees',$paieRep->activiteClientImp($point,$date1,$recherche, $date2,$client));
            $title = $type;
        }
        if($type == "Chiffre d’affaires par client"){
            //dd($paieRep->clientImp($point, $recherche,$date1, $date2,$client));
            $view = $this->prodDispoPrint("etat_statistique/stat_clients/imprime/nos_clients.html.twig","donnees",$paieRep->clientImp($point, $recherche,$date1, $date2,$client));
            $title = $type;
        }
        if($type == "Opérations clients"){
            $view = $this->prodDispoPrint("etat_statistique/stat_clients/imprime/operation.html.twig",'donnees',$transactionRepository->operationImpr($point,$recherche,$date1, $date2,$client));
            $title = $type;
        }
        if($type == "Liste des sorties d'une période"){
            $view = $this->prodDispoPrint("etat_statistique/stock/imprime/produit_sortie.html.twig",'donnees',$produitCondSortieMagRepository->prodSortiesImp($recherche,$point,$date1,$date2,$magasin));
            $title = $type;
        }
        if($type == "Point périodique des entrées"){
            $view = $this->prodDispoPrint("etat_statistique/stock/imprime/produit_entree.html.twig",'donnees',$produitCondApproMagRepository->prodEntreesImp($recherche,$point,$date1,$date2,$magasin));
            $title = $type;
        }
        
        if($type == "Historique des ventes d'un produit"){

            $view = $this->prodDispoPrint("etat_statistique/stat_produits/imprime/produit_achete.html.twig",'donnees',$produitCondComClitRepository->prodacheteImp($point, $recherche,$date1, $date2,$produit,$client));
            $title = $type;
            $format = "A4-L";
        }
        
        if($type == "Point des produits vendus par période"){
            $view = $this->prodDispoPrint("etat_statistique/stat_produits/imprime/produits.html.twig",'donnees',$produitCondComClitRepository->prodVendusImp($point, $recherche,$date1, $date2));
            $title = $type;
        }

        if($type == "Point des encaissements sur une période"){
           // dd((new DateTime($date1))->diff(new DateTime($date2))->format("%a"));
            $view = $this->prodDispoPrint("etat_statistique/stat_reglement/imprime/point_encaissement.html.twig",'donnees',[$paieRep->pointEncaissementImp($recherche,$point,$date1,$date2),$depenseRepository->pointTotalDepensePeriodique($date1, $date2,$point), (int)(new DateTime($date1))->diff(new DateTime($date2))->format("%a") !== 0 ? 0 :  $caisseRepository->fondDeRoulementCaisse($date1, $date2,$point), $paieRep->totalEncaissementAnterieur($point,$date1,$date2)]);
            $title = $type;
            $format = "A4-L";
        }
        if ($type == "Point des dépenses périodique"){
            $view = $this->prodDispoPrint('etat_statistique/stat_reglement/imprime/depenseImp.html.twig','donnees',$depenseRepository->pointDepenseImp($point, $recherche,$date1,$date2));
            $title =  "Point des dépenses périodique";
            $format = "A4-L";
        }
        if($type == "Liste des ventes d'une période"){
            //dd($date1, $date2,$depenseRepository->pointDepensePeriodique($date1, $date2,$point));
            $view = $this->prodDispoPrint("etat_statistique/stat_vente/imprime/liste_vente.html.twig",'donnees',[$commandeClientRepository->pointJounalierVentesImp($recherche,$point,$date1, $date2)]);
            $title = $type;
            $format = "A4-L";
        }
        if($type == "Liste des Livraisons d'une période"){
            $view = $this->prodDispoPrint("etat_statistique/stat_vente/imprime/liste_livraison.html.twig",'donnees',$produitCondMagLivRepository->prodLivresImp($recherche,$point,$date1,$date2,$magasin));
            $title = $type;
        }
        if($type == "Point caisse"){
            $view = $this->prodDispoPrint("etat_statistique/stat_vente/imprime/point_caisse.html.twig",'donnees',$transactionRepository->operationImpr($point,$recherche,$date1, $date2,$client));
            $title = $type;
        }
        if($type == "Point des Commandes"){
            //dd($statut,$statutLiv,$typeCommande);
            $view = $this->prodDispoPrint("etat_statistique/point_commande/imprime/point_commande.html.twig",'donnees',$commandeClientRepository->pointCommandesImp($recherche,$point,$date1,$date2,$statut,$statutLiv,$typeCommande));
            $title = $type;
        }
        
        $librairieService->mpdf([$view],$title,$format);
    }

    public function prodDispoPrint($page,$nom,$donne, $formate = "A4")
    {  
        //dd($donne);
        $societe = $this->getDoctrine()->getRepository(Societe::class)->findAll();

       return $this->renderView($page, [$nom => $donne,'societe'=>$societe[0]]);
    }

    /**
     * @Route("/proddispos-{type}", name="romassigcom_prod_dispose", methods={"GET","POST"})
     */
    public function prodDispos(ProduitRepository $produitRepository,Request $request,$type)
    {
        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('search');
        $orders = $request->get('order');
        $point =  $request->getSession()->get('pointVente')->getId();
        $columns = $request->get('columns');
        
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }

        $total_objects_count = $produitRepository->counts($type);
        $results = $produitRepository->prodDispos($start,$point, $length, $orders, $search,$type);
        
        $response = array( 
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
        return new JsonResponse($response);
    }


        /**
     * @Route("/pooint_depense", name="romassigcom_point_depense", methods={"GET","POST"})
     */
    public function pointDepense(DepenseRepository $depenseRepository,Request $request)
    {
        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('search');
        $orders = $request->get('order');
        $point =  $request->getSession()->get('pointVente')->getId();
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }

        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        
        $total_objects_count = $depenseRepository->counts();
        $results = $depenseRepository->pointDepense($start,$point, $length, $orders, $search,$date1, $date2);
        $response = array( 
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
        return new JsonResponse($response);
    }


    /**
     * @Route("/point_encaissement", name="romassigcom_point_encaissement", methods={"GET","POST"})
     */
    public function pointEncaissement(PaiementRepository $paiementRepository,Request $request)
    {
        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('search');
        $orders = $request->get('order');
        $point =  $request->getSession()->get('pointVente')->getId();
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }

        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        
        $total_objects_count = $paiementRepository->counts();
        $results = $paiementRepository->pointEncaissement($start,$point, $length, $orders, $search,$date1, $date2);
        $response = array( 
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
        return new JsonResponse($response);
    }

    /**
     * @Route("/etat/point/commande", name="romassigcom_point_commande", methods={"GET","POST"})
     */
    public function point_commande_vente()
    {
        return $this->renderForm('etat_statistique/stat_vente/contenu/statistiques_vente.html.twig');// point_commande.html.twig
    }

    /**
     * @Route("/etat/point/commandes", name="romassigcom_point_commandes", methods={"GET", "POST"})
     */
    public function point_commande_ventes(CommandeClientRepository $commandeClientRepository,Request $request)
    {
        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('search');
        $orders = $request->get('order');
        $point =  $request->getSession()->get('pointVente')->getId();
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $statut = $request->get('statut');
        $statutLiv = $request->get('statutLiv');
        $type_commande = $request->get('type_commande');

        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        
        //dd($start,$length);
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        
        $total_objects_count = $commandeClientRepository->counts();
        $results = $commandeClientRepository->pointCommandes($start,$point, $length, $orders, $search,$date1, $date2, $statut, $statutLiv,$type_commande);
        
        $response = array( 
            'draw' => $draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
       // 57097244
        return new JsonResponse($response);
    }

     /**
     * @Route("/point_journalier_ventes", name="romassigcom_point_journalier_ventes", methods={"GET","POST"})
     */
    public function point_jounalier_ventes(CommandeClientRepository $commandeClientRepository,Request $request)
    {
        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('search');
        $point =  $request->getSession()->get('pointVente')->getId();
        $orders = $request->get('order');
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }

        $total_objects_count = $commandeClientRepository->counts();
        $results = $commandeClientRepository->pointJounalierVentes($start,$point, $length, $orders, $search,$date1, $date2);
        
        $response = array( 
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
       // dd($date2,$date1);
        return new JsonResponse($response);
    }

    /**
     * @Route("/liste_produit_livres", name="romassigcom_liste_produit_livres", methods={"GET","POST"})
     */
    public function prodLivres(ProduitCondMagLivRepository $produitCondMagLivRepository,Request $request)
    {
        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('search');
        $orders = $request->get('order');
        $point =  $request->getSession()->get('pointVente')->getId();
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $magasin = $request->get('magasin');
        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        
        $total_objects_count = $produitCondMagLivRepository->counts();
        //(gettype($search));
        $search = gettype($search) == "array" ? $search["value"] : $search ;
        $search = $search == ""? null : $search;
        //dd($search);
        $results = $produitCondMagLivRepository->prodLivres($start,$point, $length, $orders, $search,$date1, $date2,$magasin);
        
        $response = array( 
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
        // dd($date2,$date1);
        return new JsonResponse($response);
    }

    /**
     * @Route("/liste_sorties", name="romassigcom_liste_sortie", methods={"GET","POST"})
     */
    public function ListeSortie(ProduitCondSortieMagRepository $produitCondMagLivRepository,Request $request)
    {
        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('search');
        $orders = $request->get('order');
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $point =  $request->getSession()->get('pointVente')->getId();
        $magasin = $request->get('magasin');
        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        foreach ($orders as $key => $order)
        {

            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        
        $total_objects_count = $produitCondMagLivRepository->counts();
        $results = $produitCondMagLivRepository->prodSorties($start,$point, $length, $orders, $search,$date1,$date2,$magasin);
        
        $response = array( 
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
        // dd($date2,$date1);
        return new JsonResponse($response);
    }

     /**
     * @Route("/liste/produit/sortie/print", name="romassigcom_liste_sortie_print", methods={"GET"})
     */
    public function ListeSortiePrint(Request $request,ProduitCondMagLivRepository $produitCondMagLivRepository, LibrairieService $librairieService)
    {
       $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $magasin = $request->get('magasin');
        $point =  $request->getSession()->get('pointVente')->getId();
        $results= $produitCondMagLivRepository->prodLivres(null,$point, null, null, null,$date1, $date2, $magasin);
        $view = $this->renderForm('etat_statistique/documents/liste_livraisons_periode.html.twig', [
            'points' =>$results["results"],
        ]);
        $title="Liste des livraisons du $date1 au $date2";
        $librairieService->mpdf($view,$title);
    }


    /**
     * @Route("/liste_entrees", name="romassigcom_liste_entrees", methods={"GET","POST"})
     */
    public function listeEntrees(ProduitCondApproMagRepository $produitCondApproMagRepository,Request $request)
    {
        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('search');
        $orders = $request->get('order');
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $point =  $request->getSession()->get('pointVente')->getId();
        $magasin = $request->get('magasin');
        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        
        $total_objects_count = $produitCondApproMagRepository->counts();
        $results = $produitCondApproMagRepository->prodEntrees($start,$point, $length, $orders, $search,$date1,$date2,$magasin);
        
        $response = array( 
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
        // dd($date2,$date1);
        return new JsonResponse($response);
    }

    /**
     * @Route("/liste/produit/entrees/print", name="romassigcom_liste_entrees_print", methods={"GET"})
     */
    public function listeEntreesPrint(Request $request,ProduitCondApproMagRepository $produitCondApproMagRepository, LibrairieService $librairieService)
    {
       $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $magasin = $request->get('magasin');
        $point =  $request->getSession()->get('pointVente')->getId();
        $results= $produitCondApproMagRepository->prodEntrees(null,$point, null, null, null,$date1, $date2, $magasin);
        $view = $this->renderForm('etat_statistique/documents/liste_livraisons_periode.html.twig', [
            'points' =>$results["results"],
        ]);
        $title="Liste des livraisons du $date1 au $date2.pdf";
        $librairieService->mpdf($view,$title);
    }
    /**
     * @Route("/liste/produit/livres/print", name="romassigcom_liste_produit_livres_print", methods={"GET","POST"})
     */
    public function prodLivresPrint(Request $request,ProduitCondMagLivRepository $produitCondMagLivRepository, LibrairieService $librairieService)
    {
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $magasin = $request->get('magasin');
        $point =  $request->getSession()->get('pointVente')->getId();
        $results= $produitCondMagLivRepository->prodLivres(null,$point, null, null, null,$date1, $date2, $magasin);
        $view = $this->renderForm('etat_statistique/documents/liste_livraisons_periode.html.twig', [
            'points' =>$results["results"],
        ]);
        $title="Liste des livraisons du $date1 au $date2";
        $librairieService->mpdf($view,$title);
    }
    

    /**
     * @Route("/point/journalier/ventes/print", name="romassigcom_point_journalier_ventes_print", methods={"GET","POST"})
     */
    public function pointJounalierVentesPrint(Request $request, CommandeClientRepository $commandeClientRepository, LibrairieService $librairieService)
    {
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $point =  $request->getSession()->get('pointVente')->getId();
        $results= $commandeClientRepository->pointJounalierVentes(null,$point, null, null, null,$date1, $date2);
        $view = $this->renderForm('etat_statistique/documents/Point_journalier_ventes.html.twig', [
            'points' =>$results["results"],
        ]);
        $title="Point journalier des ventes du $date1 au $date2";
        $librairieService->mpdf($view,$title);
    }

    /**
     * @Route("/point/encaissement/print", name="romassigcom_point_encaissement_print", methods={"GET","POST"})
     */
    public function pointEncaissementPrint(Request $request, PaiementRepository $paiementRepository, LibrairieService $librairieService)
    {
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $point =  $request->getSession()->get('pointVente')->getId();
        $results= $paiementRepository->pointEncaissement(null,$point, null, null, null,$date1, $date2);
        $view = $this->renderForm('etat_statistique/documents/point_encaissements_periode.html.twig', [
            'points' =>$results["results"],
        ]);
        $title="point des encaissements du $date1 au $date2";
        $librairieService->mpdf($view,$title);
    }


    /**
     * @Route("/mouvement_stock", name="romassigcom_mouvement_stock", methods={"GET","POST"})
     */
    public function mouvement_stock(EntityManagerInterface $em,Request $request)
    {
        $point =  $request->getSession()->get('pointVente');
        $magasins = $em->getRepository(Magasin::class)->findBy(['pointVente'=>$point]);
        return $this->renderForm('etat_statistique/stock/contenu/mouvement_stock.html.twig',['magasins'=>$magasins]);
    }

    /**
     * @Route("/mouvement_stock/imprime", name="romassigcom_mouvement_stock_imprime", methods={"GET","POST"})
     */
    public function imprimeStockGlo(LibrairieService $lib, Request $request){

        $date1 = $request->request->get("date1");
        $date2 = $request->request->get("date2");
        $recherche = $request->request->get("recherche");
        //dd($date1);
        $html = [
            $this->render("etat_statistique/stock/documentStock.html.twig",[]),
        ];


        return new JsonResponse($date1);
        //return $lib->mpdf($html,"Mouvement Global du Stock");

    }

    /**
     * @Route("/mouvement_stock/mouv_stock", name="romassigcom_etat_mouv_stock", methods={"GET","POST"})
     */
    public function mouvStock(Request $request, ProduitCondMagRepository $prodConMagRep, MagasinRepository $magRep, InventaireRepository $inventaireRep, ProduitCondMagInvRepository $invRep, LibrairieService $lib, ProduitCondSortieMagRepository $sortieRe, ProduitCondApproMagRepository $approRe, ProduitCondMagLivRepository $prodComLivRep, ProduitCondComClitRepository $prCondClRep, ProduitConditionnementRepository $proConRed){
        set_time_limit(-1);

        $date1 = $request->request->get('date1');
        $recherche = $request->request->get('recherche');
        $date2 = $request->request->get('date2');
        $maga = $request->request->get('magasin');
        $point =  $request->getSession()->get('pointVente');
        if($date1){
            $dd = $date1;
            $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $dd = $date1->format('Y-m-d');
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        $produitConds = $proConRed->prodCondS($recherche,$point);
        $magasins = [];
        if($maga){
            $magasins[] =  $this->getDoctrine()->getRepository(Magasin::class)->find((int)$maga);
        }else{
            $magasins = $this->getDoctrine()->getRepository(Magasin::class)->findBy(["pointVente"=>$point, "estSup"=>NULL]);
        }
        
        //Parcours des magasins
        //Dernier inventaire en date avant la date choisie
        $timestamp = strtotime($dd)-(60 * 60 * 24);
        $dateChoisie = date('Y-m-d 23:59:59', $timestamp);
        $dernierInv = $inventaireRep->dernierInventaireavantDate($point,$dateChoisie);
        
        $dateIn = null;
        if($dernierInv){
            $dateIn = ($dernierInv->getCreatedAt())->format("Y-m-d H:i:s");
        }

        $parMag = [];
        foreach($magasins as $mag){
            $resuls = [];
            foreach($produitConds as $prCon){

                //StockInitiale pour ce produit par magasin avant la date1 et le dernier inventaire
                    

                    //Somme des approvisionnement avant la période dans ce magasin pour ce produit
                    $qteApproAv = $approRe->qteApproAvantPeriode($prCon,$point,$dateIn,$mag, $dateChoisie);
                    $qteApproAv = $qteApproAv ? $qteApproAv[1] : 0 ;
                    
                    //Quantité après dernier inventaire
                    $qteAvantJJ = 0;
                    if($dernierInv){
                        $qteAvantJJ = $invRep->qteInitial($dernierInv,$prCon,$mag);
                        $qteAvantJJ = $qteAvantJJ ? $qteAvantJJ['qteCondStockPhy'] : 0 ;
                    }

                    //Quantité livré avant la période
                    $qteLivreAvnt = $prodComLivRep->qteLivre($prCon,$point,$dateIn,$mag, $dateChoisie);
                    $qteLivreAvnt ? $qteLivreAvnt[1] : 0 ;
                    

                $qteIni = (float)$qteApproAv + (float)$qteLivreAvnt - (float)$qteAvantJJ;

                //Quantité par magasin
                $qteEnStock = $prodConMagRep->qteEnStock($point,$prCon,$mag);
                if($qteEnStock){
                    //Quantité Vendue pendant la période
                    $qteVendu = $prCondClRep->qteVendu($prCon,$point,$date1, $mag,$date2);
                    //Qté Livré pendant la période
                    $qteLivre = $prodComLivRep->qteLivre($prCon,$point,$date1,$mag, $date2);

                    // Qté Approvisionné pendant la période
                    $qteAppro = $approRe->qteAppro($prCon,$point,$date1,$mag, $date2);

                    // Qté Approvisionné apres la période
                    $qteApproApre = $approRe->qteApproApres($prCon,$point,$mag, $date2);

                    if($qteApproApre){
                        $qteApproApre = $qteApproApre[1];
                    }else{
                        $qteApproApre = 0;
                    }

                    //Qté Sortie pendant la période
                    $qteSortie = $sortieRe->qteSortie($prCon,$point,$date1,$mag, $date2);
                    //produit;stockInitial;qteAppro;qteLivre;qteVendu;qteSortie;qteRetou;stockFinal
                    $resuls[]=array(

                        'produit'=>$prCon->__toString(),

                        'stockInitial'=>$qteIni,

                        'qteAppro'=> $qteAppro == null ? 0 : $qteAppro[1],

                        'qteLivre'=> $qteLivre == null ? 0 : $qteLivre[1],

                        'qteVendu'=> $qteVendu[1] == null ? 0 : $qteVendu[1],

                        'qteSortie'=> $qteSortie == null ? 0 : $qteSortie[1],

                        'qteRetou' => 0 , 

                        'stockFinal'=> ($qteEnStock ? $qteEnStock['qteStockMag'] - $qteApproApre  : 0) < 0 ? 0 : ($qteEnStock ? $qteEnStock['qteStockMag'] - $qteApproApre  : 0),

                    );
                }

            }
            $parMag[]=array(
                'magasin'=>$mag->getNomMag(),
                "produitsMag"=>$resuls
            );

        }
        return new JsonResponse($parMag);
    }

    /**
     * @Route("/fiche", name="romassigcom_etat_fiche", methods={"GET","POST"})
     */
    public function fiche(LibrairieService $lib, Request $request,SocieteRepository $sociRep,ModelSignataireRepository $modelRep){

        $ent = null;
        if($sociRep->findAll()){
            $ent = ($sociRep->findAll())[0];
        }
        $signataires = $modelRep->findOneBy(["estDefault"=>true]);
        $html = [
            $this->renderView("etat_statistique/fiche.html.twig",[
                'signataires'=>$signataires,
                'societe'=>$ent,
            ]),
        ];
        //return $html[0];
        //return new JsonResponse($date1);
        return $lib->mpdf($html,"FICHE DE RECENSEMENT CARREAUX");

    }

    /**
     * @Route("/stat_produit", name="romassigcom_etat_produit", methods={"GET","POST"})
     */
    public function stat_produit(Request $request,ProduitRepository $produitRepository,ClientRepository $cliRep, EntityManagerInterface $em)
    {
        $point =  $request->getSession()->get('pointVente');
        $produits = $produitRepository->produits($point);
        $clients = $cliRep->findBy(['pointVente'=>$point]);
        return $this->renderForm('etat_statistique/stat_produits/stat_produits.html.twig',['clients'=>$clients, "produits"=>$produits]);
    }

    /**
     * @Route("/stat_produit/produit/vendu", name="romassigcom_produit_vente_periodique", methods={"GET","POST"})
     */
    public function produitVenduPeriodique(Request $request,ProduitCondComClitRepository $prCondClRep){
        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('recherche');
        $orders = $request->get('order');
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $point =  $request->getSession()->get('pointVente')->getId();
        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        $total_objects_count = $prCondClRep->counts();
        $results = $prCondClRep->prodVendus($point,$start, $length, $orders, $search,$date1, $date2);
        
        $response = array( 
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
         
        return new JsonResponse($response);

    }

     /**
     * @Route("/stat_produit/produits/achetes", name="romassigcom_produit_achete_periodique", methods={"GET","POST"})
     */
    public function produitachetePeriodique(Request $request,ProduitCondComClitRepository $prCondClRep){

        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('recherche');
        $orders = $request->get('order');
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $produit = $request->get('produit');
        $client = $request->get('client');
        $point =  $request->getSession()->get('pointVente')->getId();
        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        $total_objects_count = $prCondClRep->counts();
        $results = $prCondClRep->prodachete($point,$start, $length, $orders, $search,$date1, $date2,$produit,$client);
        
        $response = array( 
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
        return new JsonResponse($response);

    }
    
    /**
     * @Route("/stat_produit/produits/retournes", name="romassigcom_produit_retournes", methods={"GET","POST"})
     */
    public function produitretournes(Request $request,ProduitCondComClitRepository $prCondClRep){

        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('recherche');
        $orders = $request->get('order');
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $produit = $request->get('produit');
        $client = $request->get('client');
        $point =  $request->getSession()->get('pointVente')->getId();
        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        $total_objects_count = $prCondClRep->counts2();
        $results = $prCondClRep->prodretourne($point,$start, $length, $orders, $search,$date1, $date2,$produit,$client);
        
        $response = array( 
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
        return new JsonResponse($response);

    }

         /**
     * @Route("/stat_produit/produits/conditionnement", name="romassigcom_produit_conditionnement", methods={"GET","POST"})
     */
    public function produitConditionnement(Request $request,ProduitConditionnementRepository $produitConditionnementRepository){

        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('recherche');
        $orders = $request->get('order');
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $produit = $request->get('produit');
        $client = $request->get('client');
        $point =  $request->getSession()->get('pointVente')->getId();
        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        $total_objects_count = $produitConditionnementRepository->counts();
        $results = $produitConditionnementRepository->prodconditionnement($point,$start, $length, $orders, $search);
        
        $response = array( 
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
        return new JsonResponse($response);

    }

    /**
     * @Route("/stat_commandes", name="romassigcom_etat_commande", methods={"GET","POST"})
     */
    public function stat_commandes(Request $request, ProduitRepository $produitRepository,EntityManagerInterface $em)
    {
        $point =  $request->getSession()->get('pointVente');
        $magasins = $em->getRepository(Magasin::class)->findBy(['pointVente'=>$point]);
        return $this->renderForm('etat_statistique/point_commande/stat_commande.html.twig',['magasins'=>$magasins]);
    }

    /**
     * @Route("/commande/impaye", name="romassigcom_etat_commande_impaye", methods={"GET","POST"})
     */
    public function commandeImpayes(CommandeClientRepository $cmdRep, Request $request){

        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('search');
        $orders = $request->get('order');
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $point =  $request->getSession()->get('pointVente')->getId();
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        
        $total_objects_count = $cmdRep->counts();
        $results = $cmdRep->pointImpayees($start,$point, $length, $orders, $search);
        $response = array(
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
        return new JsonResponse($response);
    }

    /**
     * @Route("/stat_clients", name="romassigcom_etat_client", methods={"GET","POST"})
     */
    public function stat_clients(Request $request,ProduitRepository $produitRepository,ClientRepository $cliRep,EntityManagerInterface $em)
    {
        $point =  $request->getSession()->get('pointVente');
        $clients = $cliRep->findBy(["pointVente"=>$point]);
        return $this->renderForm('etat_statistique/stat_clients/stat_clients.html.twig',['clients'=>$clients]);
    }
    /**
     * @Route("/stat/activite/activite/client", name="romassigcom_etat_activite_clients", methods={"GET","POST"})
     */
    public function activitesClients(PaiementRepository $paieRep, Request $request){
        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $search = $request->get('recherche');
        $orders = $request->get('order');
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $client = $request->get('client');
        $point = $request->getSession()->get('pointVente')->getId();

        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        
        $total_objects_count = $paieRep->counts();
        $results = $paieRep->activiteClient($point,$start, $length, $orders, $search,$date1, $date2,$client);
        $response = array(
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"],
        ); 
        return new JsonResponse($response);
    }

    /**
     * @Route("/stat/clients/top/client", name="romassigcom_etat_top_clients", methods={"GET","POST"})
     */
    public function topClients(PaiementRepository $paieRep, ClientRepository $clientRepository, Request $request){
        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $recherche = $request->get('recherche');
        $orders = $request->get('order');
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $client = $request->get('client');
        $point =  $request->getSession()->get('pointVente')->getId();
        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        
        $total_objects_count = $clientRepository->nombre();
        $results = $paieRep->client($point,$start, $length, $orders, $recherche,$date1, $date2,$client);
        $response = array(
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"]
        ); 
        return new JsonResponse($response);
    }

        /**
     * @Route("/stat/clients/operation/client", name="romassigcom_etat_operation_clients", methods={"GET","POST"})
     */
    public function operation(TransactionRepository $transactionRepository, Request $request){
        //dd($this->getUser()->getPointVente()->getId());
        $draw = intval($request->get('draw'));
        $start = $request->get('start');
        $length = $request->get('length');
        $recherche = $request->get('recherche');
        $orders = $request->get('order');
        $columns = $request->get('columns');
        $date1 = $request->get('dateDebut');
        $date2 = $request->get('dateFin');
        $client = $request->get('client');
        $point =  $request->getSession()->get('pointVente')->getId();
        if($date1){
            $date1 = $date1." 00:00:00";
        }else{
            $date1 = new DateTime();
            $date1 = $date1->format('Y-m-d 00:00:00');
        }
        if($date2){
            $date2 = $date2." 23:59:59";
        }else{
            $date2 = new DateTime();
            $date2 = $date2->format('Y-m-d 23:59:59');
        }
        foreach ($orders as $key => $order)
        {
            $orders[$key]['name'] = $columns[$order['column']]['data'];
        }
        
        $total_objects_count = $transactionRepository->counts();
        $results = $transactionRepository->operation($point,$start, $length, $orders, $recherche,$date1, $date2,$client);
        $response = array(
            'draw'=>$draw, 
            'recordsFiltered' => $results["countResult"], 
            'recordsTotal' => $total_objects_count,
            'data' => $results["results"]
        ); 
        return new JsonResponse($response);
    }


    /**
     * @Route("/statistique_vente", name="romassigcom_statistique_vente", methods={"GET","POST"})
     */
    public function statistique_vente(EntityManagerInterface $em,Request $request)
    {
        $point =  $request->getSession()->get('pointVente');
        $magasins = $em->getRepository(Magasin::class)->findBy(['pointVente'=>$point]);
        return $this->renderForm('etat_statistique/stat_vente/contenu/statistiques_vente.html.twig',['magasins'=>$magasins]);
    }

    
    /**
     * @Route("/stat_reglement", name="romassigcom_point_reglement", methods={"GET","POST"})
     */
    public function statistique_reglement(EntityManagerInterface $em,Request $request)
    {
        $point =  $request->getSession()->get('pointVente');
        $magasins = $em->getRepository(Magasin::class)->findBy(['pointVente'=>$point]);
        return $this->renderForm('etat_statistique/stat_reglement/contenu/statistiques_caisse.html.twig');
    }
    

   
}
