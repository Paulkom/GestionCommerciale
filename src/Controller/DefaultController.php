<?php

namespace App\Controller;

use DateTime;
use Faker\Factory;
use App\Entity\Menu;
use App\Entity\Taxe;
use NumberFormatter;
use App\Entity\Media;
use Twig\Environment;
use App\Entity\Caisse;
use App\Entity\Client;
use App\Entity\Compte;
use App\Entity\Profil;
use App\Entity\Sortie;
use App\Entity\Depense;
use App\Entity\Facture;
use App\Entity\Famille;
use App\Entity\Magasin;
use App\Entity\Monnaie;
use App\Entity\Produit;
use App\Entity\Societe;
use App\Entity\Fonction;
use App\Entity\Paiement;
use App\Entity\Livraison;
use App\Entity\Personnel;
use App\Entity\Transfert;
use App\Entity\GroupeTaxe;
use App\Entity\Inventaire;
use App\Entity\ListCaisse;
use App\Services\ApiMecef;
use App\Entity\Detachement;
use App\Entity\Transaction;
use App\Entity\Utilisateur;
use App\Entity\ModePaiement;
use App\Entity\PointDeVente;
use App\Services\Parameters;
use PharIo\Manifest\Library;
use App\Entity\Configuration;
use App\Entity\InventaireMag;
use App\Entity\TypeOperation;
use App\Form\DetachementType;
use App\Entity\CommandeClient;
use App\Entity\ProduitCondMag;
use App\Entity\Conditionnement;
use App\Entity\ModelSignataire;
use App\Entity\Approvisionnement;
use App\Entity\ProduitCondMagInv;
use Symfony\Component\Mime\Email;
use App\Database\NativeQueryMySQL;
use App\Repository\MenuRepository;
use App\Repository\TaxeRepository;
use App\Repository\PaiementRepository;
use App\Services\LibrairieService;
use Doctrine\ORM\EntityRepository;
use App\Repository\ProfilRepository;
use App\Repository\FamilleRepository;
use App\Repository\ProduitRepository;
use App\Entity\ProduitConditionnement;
use App\Entity\UtilisateurPointDeVente;
use App\Repository\PersonnelRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Repository\PointDeVenteRepository;
use App\Repository\ObjectifRepository;
use App\Repository\ConditionnementRepository;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Security\Core\Security;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\RouterInterface;
use Symfony\Component\Routing\Annotation\Route;
use App\Entity\ModelSignatairePersonnelFonction;
use App\Repository\CommandeClientRepository;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RequestStack;
use App\Repository\ProduitConditionnementRepository;
use Symfony\Component\Validator\Validator\ValidatorInterface;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Security\Csrf\CsrfTokenManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class DefaultController extends AbstractController
{
    protected $columnsDefault = [];
    protected $em;
    protected $passwordHasher;
    protected $tokenManager;
    protected $requestStack;
    protected $library;
    private $mecefService;
    private $session;
    private $security;
    private $taxeRepo;
    private $profilRepo;
    private $menuRepo;
    private $parameters;
    private $router;


    public function __construct(
        EntityManagerInterface $em,
        UserPasswordHasherInterface $passwordHasher,
        CsrfTokenManagerInterface $tokenManager,
        RequestStack $requestStack,
        LibrairieService $library,
        ApiMecef $mecef,
        SessionInterface $session,
        Security $security,
        TaxeRepository $taxeRepo,
        ProfilRepository $profilRepo,
        MenuRepository $menuRepo,
        Parameters $parameters,
        RouterInterface $router
    ) {
        $this->em = $em;
        $this->passwordHasher = $passwordHasher;
        $this->tokenManager   = $tokenManager;
        $this->requestStack   = $requestStack;
        $this->library = $library;
        $this->session = $session;
        $this->mecefService = $mecef;
        $this->security = $security;
        $this->taxeRepo = $taxeRepo;
        $this->profilRepo = $profilRepo;
        $this->menuRepo = $menuRepo;
        $this->parameters = $parameters;
        $this->router = $router;
    }

    /**
     * @return Response
     * @Route("/admin/generer/menus", name="app_generer_menu")
     */

    public function generateMenus(): Response
    {
        dd($this->parameters->getMenus(true));
    }

    public function afficherMenus(MenuRepository $menuRepository)
    {
        $user = $this->getUser();
        $userRoles = $user->getRoles();

        $em = $this->getDoctrine()->getManager();
        $menus = $em->createQuery(
            "
            SELECT m
            FROM App\Entity\Menu m
            LEFT JOIN m.menuSuperieur ms
            LEFT JOIN m.sousMenus sm
            WHERE ms IS NULL
            AND sm.roles IN (:val)"
        )
            ->setParameter('val', $userRoles)
            ->getResult();
        return $this->render('layouts/menu.html.twig', compact('menus'));
    }

    /**
     * @return Response
     * @Route("/admin", name="app_admin_dashboard")
     */
    public function index(Request $request, MailerInterface $mailer,PaiementRepository $paiementRepository, PersonnelRepository $personnelRepository, CommandeClientRepository $comCliRep, ObjectifRepository $objectifRepository
    ): Response
    {
        $pointPersonnel = $personnelRepository->pointDepensePersonnel();
        $listePersonnel = $personnelRepository->listePersonnel();
        $paiementDeMois = $paiementRepository->pointDesPaiementDuMois();
        $commandeMois = $comCliRep->sommeDesCommandesParType();
        $objectifActif = $objectifRepository->findOneBy(["estActif"=>true]);

        // $pointPaiemetMois = $paiementRepository->pointDesPaiementDuMois();
        // $dernierPaiementJournaliers = $paiementRepository->pointDesPaiementDesXDerniersJours(10);
       // $totalPaiement = $paiementRepository->pointDesPaiementJours();
       $obj =  $objectifActif ? $objectifActif->getMontantObjectif() : 0;
        return $this->render(
            'base.html.twig',
            [
             // "pointDeXMoisDePaiement"=> $paiementDeXMois,
                // "pointPaiemetMois" => $pointPaiemetMois,
                "commandeMois"=>$commandeMois,
                "depensePersonnel" => $pointPersonnel,
                 "listePersonnel" => $listePersonnel,
                 "paiementMois" => $paiementDeMois,
                 "objectif" =>  $obj,
                 "pourcentageObjectif"=>  $obj / ($paiementDeMois != 0 ? $paiementDeMois : 1),
                 "ecartObjectif" =>  ($obj - ($paiementDeMois != 0 ? $paiementDeMois : 1))
                // "dernierPaiementJournaliers" => $dernierPaiementJournaliers,
                //"totalPaiement"=>$totalPaiement
            ]
        );
    }

    /**
     * @return Response
     * @Route("/sessionIdentity", name="app_admin_session_identity")
     */
    public function sessionIdentity(Request $request): Response
    {
        // ici je sauvegarde l'identifiant de la session en base avant la redirection sur le dashboard
        $this->getUser()->setSecurityCode($this->session->getId());
        $this->em->flush();
        return $this->redirectToRoute("app_admin_dashboard");
    }

    /**
     * @return Response
     * @Route("/stock/cond", name="app_produitCond_list")
     */
    public function indexbrut(): Response
    {
        return $this->render('ajaxify/produitconditionnement.list.html.twig');
    }

    /**
     * @Route(
     *     "/dynamic-save-{class}/{action}/{key}/{param}",
     *     name="app_entity_callandsave",
     *     defaults={"key" = null, "param" = null, "action":"call"},
     *     methods={"GET", "POST"}
     *     )
     */
    public function callAndSave(
        Request            $request,
        Environment        $env,
        LibrairieService   $lib,
        ValidatorInterface $validator,
        $class,
        $action,
        $key,
        $param
    ): Response {

        try {
            $data = $request->getMethod() === 'POST' ? $request->request->all() : $request->query->all();
            $html = '';
            $html_new = '';
            $form = null;
            //echo $class;
            // echo ucfirst($class);
            //dump(ucfirst($class),$class);
            $classname = 'App\\Entity\\' . ucfirst($class);
            $classtype = 'App\\Form\\' . ucfirst($class . 'Type');
            $repository = $this->em->getRepository(get_class(new $classname()));
            $view = '';
            //dump("Bonjour");
            if (!empty($key)) {
                $entity = $repository->find($key);
                $message = "Modification effectuée avec succès.";
            } else {
                $entity = new $classname();
                $message = "Enregistrement effectué avec succès.";
            }
            if ($action !== 'del') {
                $reflector = new \ReflectionClass($classtype);
                $constructor = $reflector->getConstructor();
                if ($constructor && $constructor->getParameters()) {
                    //$params = $constructor->getParameters();
                    if (
                        (new $classname() instanceof Transfert) ||
                        (new $classname() instanceof Sortie) ||
                        (new $classname() instanceof Inventaire) ||
                        (new $classname() instanceof Transaction) ||
                        (new $classname() instanceof Paiement) ||
                        (new $classname() instanceof CommandeClient) ||
                        (new $classname() instanceof Livraison) ||
                        (new $classname() instanceof ProduitCondMag) ||
                        (new $classname() instanceof Depense) ||
                        (new $classname() instanceof Produit) ||
                        (new $classname() instanceof Compte) ||
                        (new $classname() instanceof Famille) ||
                        (new $classname() instanceof Approvisionnement) ||
                        (new $classname() instanceof Magasin) ||
                        (new $classname() instanceof Detachement)
                    )
                        $formtype = $reflector->newInstanceArgs([$this->em, $this->session]);

                    elseif (new $classname() instanceof Utilisateur) {
                        $formtype = $reflector->newInstanceArgs([$this->em, $this->profilRepo]);
                    } elseif (new $classname() instanceof Profil) {
                        $formtype = $reflector->newInstanceArgs([$this->menuRepo]);
                    } elseif (new $classname() instanceof Menu) {
                        $formtype = $reflector->newInstanceArgs([$this->router]);
                    } else
                        $formtype = new $classtype();
                } else {
                    $formtype = new $classtype();
                }

                if ($env->getLoader()->exists($lib->camel2dashed($class) . '/partials/_card_form.html.twig')) {
                    $form = $this->createForm(get_class($formtype), $entity, [
                        'action' => $this->generateUrl('app_entity_callandsave', ['class' => $class, 'action' => 'save', 'key' => $key]),
                    ]);
                    $form->handleRequest($request);
                    $view = $lib->camel2dashed($class) . '/partials/_card_form.html.twig';
                    $html = $this->renderView($view, [
                        'entity' => $entity,
                        'form' => $form->createView(),
                        'param' => ($param) ? $param : null,
                    ]);
                }
            }

            $results = ['entity' => $entity];
            switch ($action) {
                case 'call':
                    break;
                case 'show':
                    $entities = $repository->find($key);
                    if ($env->getLoader()->exists($lib->camel2dashed($class) . '/show.html.twig')) {
                        $view = $lib->camel2dashed($class) . '/show.html.twig';
                        $html = $this->renderView($view, [
                            'entitie' => $entities,
                        ]);
                    }
                    $results['html'] = $html;
                    break;
                case 'edit':
                    if (!empty($view)) {
                        $form_new = $this->createForm(get_class($formtype), (new $classname()), [
                            'action' => $this->generateUrl('app_entity_callandsave', ['class' => $class, 'action' => 'save', 'key' => $key]),
                        ]);
                        $form_new->handleRequest($request);
                        $html_new = $this->renderView($view, [
                            'entity' => new $classname(),
                            'form' => $form_new->createView(),
                        ]);
                        $results['edit'] = $html;
                        $results['new'] = $html_new;
                    }
                    break;
                case 'save':
                    $control = property_exists($entity, 'password') ? $form->isSubmitted() : $form->isSubmitted() && $form->isValid();
                    $errors = $validator->validate($entity);
                    //dd($form->getErrors(true, false));
                    //if (count($errors) > 0) return new JsonResponse((string)$errors);
                    if ($control) {
                        $entity->setCreatedAt(new \DateTime());
                        $entity->setUpdatedAt(new \DateTime());
                        if (property_exists($entity, 'password')) {
                            if ($form->get('password')->getData() != null) {
                                $entity->setPassword(
                                    $this->passwordHasher->hashPassword(
                                        $entity,
                                        $form->get('password')->getData()
                                    )
                                );
                            }
                        }
                        $repository->add($entity);
                        $results = $message;
                    }
                    break;
                case 'del':
                    $cle = null;
                    /*if ($this->isCsrfTokenValid('delete' . $entity->getId(), $data['token'])) {
                        $cle = $entity->getId();
                        $repository->remove($entity);
                    }*/
                    if ($entity->getId()) {
                        $cle = $entity->getId();
                        $entity->setEstSup(1);
                        $entity->setDeletedAt(new DateTime());
                        $repository->add($entity);
                    }
                    return new JsonResponse($cle);
                default:
            }
        } catch (\Exception $ex) {
            $results = $ex->getMessage();
            dd($ex);
        }

        return new JsonResponse($results);
    }

    /**
     * @param Request $request
     * @param $class
     * @return void
     * @Route("/loading/select-auto-complete/{class}", name="app_load_select", methods={"GET", "POST"})
     */
    public function loadSelect(Request $request, NativeQueryMySQL $native, LibrairieService $lib, $class): JsonResponse
    {
        $parameters = $request->getMethod() === 'POST' ? $request->request->all() : $request->query->all();
        $classname = 'App\\Entity\\' . ucfirst($class);
        $default_alias = "o";
        $list_columns_result = "";
        $list_join_columns_result = "";
        $options = "GROUP_CONCAT(DISTINCT CONCAT('<option value=\"', " . $default_alias . ".id" . ", '\">'" . ", 'Lol', '</option>') separator '') AS options";
        $join_sql = "";
        $sql = "SELECT :columns \nFROM $classname $default_alias ";
        $options_cols = isset($parameters['text']) ? explode(';', $parameters['text']) : [];
        $count_sql = "SELECT COUNT($default_alias) \nFROM $classname $default_alias ";
        $where = "\nWHERE ";
        $search = "";
        $cpt = 0;
        $entities = [];
        if (isset($parameters['search']) && !empty($parameters['search'])) {
            $search = $parameters['search'];

            if (isset($parameters['columns'])) {
                $columns = explode(';', $parameters['columns']);

                for ($i = (count($columns) - 1); $i >= 0; $i--) {
                    $field = $columns[$i];
                    //Chercher la position de la sous chaîne ":" dans la colonne $field
                    $position = strpos($field, ":");
                    if ($position === false) {
                        if (in_array($field, $options_cols)) {
                            $key = array_search($field, $options_cols);
                            $options_cols[$key] = $default_alias . ".$field";
                        }
                        if (!in_array($field, $options_cols)) $list_columns_result .= $default_alias . ".$field, ";
                        $where .= $default_alias . ".$field LIKE '%$search%' OR ";
                        $this->columnsDefault[$field] = true;
                    } else {
                        $cpt++;
                        //Récupérer la position du # dans la colonne
                        $diese_index = strpos($field, "#");
                        //Récupérer la colonne réelle de la table de jointure
                        $champs = explode('#', substr($field, $diese_index + 1, strlen($field)));
                        //Récupérer le nom de la colonne de jointure
                        $join_entity_name = substr($field, 0, $position);
                        $join_table_name = substr($field, $position + 1, $diese_index - $position - 1);
                        //Récupérer le nom équivalent dans la base de donnée
                        $database_table_name = $lib->camel2dashed($join_table_name);
                        //Récupérer toutes les colonnes de la table jointure $database_table_name
                        $all_cols = $native::GetAllColumnsFromTable($database_table_name);
                        //Récupérer celles qui ne sont ni clé primaire, ni étrangère
                        $h = 0;
                        $concat = "";
                        $alias = "";
                        foreach ($all_cols as $col) {
                            if ($col['Key'] === "") {
                                $assoc_col = lcfirst($lib->camelize($col['Field']));
                                if (in_array($assoc_col, $options_cols)) {
                                    $key = array_search($assoc_col, $options_cols);
                                    $options_cols[$key] = $default_alias . '_' . $cpt . ".$assoc_col";
                                }

                                if (property_exists('App\\Entity\\' . ucfirst($join_table_name), $assoc_col) && in_array($assoc_col, $champs)) {
                                    $h++;
                                    if (!in_array($assoc_col, $options_cols)) $concat .= $default_alias . '_' . $cpt . ".$assoc_col, ' ', ";
                                    $alias .= strtolower($assoc_col) . "_";
                                }
                            }
                        }
                        $alias .= $cpt;

                        $tab = explode(',', rtrim($concat, ", ' ' "));
                        if (sizeof($tab) > 1) {
                            $concat = rtrim($concat, ", ' ' ");
                            $concat = substr_replace(rtrim($concat, ", "), "CONCAT(", 0, 0);
                            $concat = substr_replace($concat, ")", strlen($concat), 0);
                        } else
                            $concat = rtrim($concat, ", ' ' ");

                        $this->columnsDefault[$alias] = true;
                        $list_join_columns_result .= $concat . " AS $alias, ";
                        $where .= "$concat LIKE '%$search%' OR ";
                        //Mettre à jour la chaîne de jointure
                        $join_sql .= "\nLEFT JOIN " . $default_alias . "." . $join_entity_name . " " . $default_alias . '_' . $cpt;
                    }
                }
                $list_columns_result .= $list_join_columns_result;
            }
            $option_concat = "";
            foreach ($options_cols as $cle => $options_col) {
                $p = "$options_col, ";
                $list_columns_result = str_replace($p, "", $list_columns_result);
                $list_columns_result = rtrim($list_columns_result, ",$options_col");
                if ($cle === 0 && count($options_cols) - 1 !== $cle) $option_concat .= "CONCAT(";
                if (count($options_cols) > 1)
                    $option_concat .= $options_col . (count($options_cols) - 1 === $cle ? ") AS text" : ", ' ', ");
                else
                    $option_concat .= "$options_col AS text";
            }
            $list_columns_result .= $option_concat;
            $list_columns_result = rtrim($list_columns_result, ", ");
            if (strlen($where) > 6)
                $where = rtrim($where, " OR ");
            else
                $where = "";
            //Reconstruire la requête avec les jointures
            $sql .= $join_sql;
            $sql = str_replace(":columns", $list_columns_result, $sql) . $where;

            $entities = $this->em->createQuery($sql)->getArrayResult();
        }

        return new JsonResponse($entities);
    }

    /**
     * @param Request $request
     * @param $class
     * @return void
     * @Route("/admin/{class}-data-load/ajax", name="app_load_data_ajax", methods={"GET", "POST"})
     */
    public function ajaxLoad(Request $request, Environment $env, NativeQueryMySQL $native, LibrairieService $lib, $class): Response
    {
        //$poinVente = $request->getSession()->get('pointVente');
        $parameters = $request->getMethod() == 'GET' ? $request->query->all() : $request->request->all();
        $result = null;
        if (isset($parameters['id']) && !empty($parameters['id'])) {
            $id = $parameters['id'];
            $token = $this->renderView('_token.html.twig', ['id' => $id]);
            $result = [
                'id' => $id,
                'token' => $token,
            ];
        } else {
            $classname = 'App\\Entity\\' . ucfirst($class);
            $default_alias = "o";
            $list_columns_result = "";
            $list_join_columns_result = "";
            $join_alias = [];
            $join_sql = "";
            $sql = "SELECT :columns \nFROM $classname $default_alias ";
            $count_sql = "SELECT COUNT($default_alias) \nFROM $classname $default_alias ";
            $search = (isset($parameters['search']['value'])
                && $parameters['search']['value']) ? $parameters['search']['value'] : '';
            $where = "\nWHERE (o.deletedAt is null OR o.estSup != 1) AND ( ";
            $cpt = 0;
            //Gestion du chargement par ajax
            if (isset($parameters['champs']) && is_array($parameters['champs'])) {
                foreach ($parameters['champs'] as $key => $field) {
                    //Chercher la position de la sous chaîne ":$class" dans la colonne $field
                    $position = strpos($field, ":");
                    if ($position === false) {
                        $list_columns_result .= $default_alias . ".$field, ";
                        if ($search != "") {
                            $where .= $default_alias . ".$field LIKE '%$search%' OR ";
                        }
                        $this->columnsDefault[$field] = true;
                    } else {
                        $cpt++;
                        //Récupérer la position du # dans la colonne
                        $diese_index = strpos($field, "#");
                        //Récupérer la colonne réelle de la table de jointure
                        $champs = explode('#', substr($field, $diese_index + 1, strlen($field)));
                        //Récupérer le nom de la colonne de jointure
                        $join_entity_name = substr($field, 0, $position);
                        $join_table_name = substr($field, $position + 1, $diese_index - $position - 1);
                        //Récupérer le nom équivalent dans la base de donnée
                        $database_table_name = $lib->camel2dashed($join_table_name);
                        //Récupérer toutes les colonnes de la table jointure $database_table_name
                        $all_cols = $native::GetAllColumnsFromTable($database_table_name);
                        //Récupérer celles qui ne sont ni clé primaire, ni étrangère
                        $h = 0;
                        $concat = "";
                        $alias = "";
                        foreach ($all_cols as $col) {
                            if ($col['Key'] === "") {
                                $assoc_col = lcfirst($lib->camelize($col['Field']));
                                if (property_exists('App\\Entity\\' . ucfirst($join_table_name), $assoc_col) && in_array($assoc_col, $champs)) {
                                    $h++;
                                    //if($h === 1) $concat .= "CONCAT(";
                                    $concat .= $default_alias . '_' . $cpt . ".$assoc_col, ' ', ";
                                    $alias .= strtolower($assoc_col) . "_";
                                }
                            }
                        }
                        $alias .= $cpt;
                        /*$concat = rtrim($concat, ", ' ' ");*/
                        $tab = explode(',', rtrim($concat, ", ' ' "));
                        if (sizeof($tab) > 1) {
                            $concat = substr_replace(rtrim($concat, ", "), "CONCAT(", 0, 0);
                            $concat = substr_replace($concat, ")", strlen($concat), 0);
                        } else
                            $concat = rtrim($concat, ", ' ' ");

                        /*$concat = rtrim($concat, ", ") . ")";*/
                        $this->columnsDefault[$alias] = true;
                        $list_join_columns_result .= $concat . " AS $alias, ";
                        $where .= "$concat LIKE '%$search%' OR ";
                        //Mettre à jour la chaîne de jointure
                        $join_sql .= "\nINNER JOIN " . $default_alias . "." . $join_entity_name . " " . $default_alias . '_' . $cpt;
                    }
                }
                $list_columns_result .= $list_join_columns_result;
            }
            if (($env->getLoader()->exists($lib->camel2dashed($class) . '/partials/_actions.html.twig'))) {
                $html = $this->renderView(
                    $lib->camel2dashed($class) . '/partials/_actions.html.twig',
                    [
                        'id' => '|o.id|',
                        'class' => $class
                    ]
                );
            } else {
                $html = $this->renderView('_actions.html.twig', ['id' => '|o.id|', 'class' => $class]);
            }

            $vs = explode('|', $html);
            $gs = "";
            foreach ($vs as $key => $v) {
                if ($key === 0) $gs .= "CONCAT(";
                $gs .= strpos($v, "o.id") === false ? "'$v', " : $v . ', ';
            }
            $gs = rtrim($gs, ", ");
            $gs .= ")";
            $list_columns_result .= $gs . " AS action";
            $list_columns_result = rtrim($list_columns_result, ", ");
            if (strlen($where) > 6) {
                $where = rtrim($where, " OR ");
                $where = rtrim($where, " AND ");
                $where .= ")";
                if (str_contains($where, 'AND ()')) {
                    $where = str_replace('AND ()', '', $where);
                }
            } else {
                $where = "";
            }

            //Reconstruire la requête avec les jointures
            //dump($where);
            $sql .= $join_sql;
            $count_sql .= $join_sql;
            $sql = str_replace(":columns", $list_columns_result, $sql) . $where . "\nORDER BY $default_alias.id DESC";
            $count_sql .= $where;
            // dump($sql);
            //Récupération des données
            $alldata = $this->em->createQuery($sql)
                ->setMaxResults($parameters['length'])
                ->setFirstResult($parameters['start'])
                ->getArrayResult();
            //dd($alldata);
            // compter les données
            $totalRecords = $totalDisplay = $this->em->createQuery($count_sql)->getSingleScalarResult();
            $data = $this->reformat($alldata);
            $result = [
                'recordsTotal' => $totalRecords,
                'recordsFiltered' => $totalDisplay,
                'data' => $data,
            ];
        }
        //dd($parameters);
        //Retourner la réponse finale sous forme json
        return new JsonResponse($result);
    }

    /**
     * @param $data
     * @return array
     */
    public function reformat($data): array
    {
        return array_map(function ($item) {
            $keys = array_keys($item);
            foreach ($keys as $key) {
                if ($item[$key] instanceof \DateTime)
                    $item[$key] = $item[$key]->format('d/m/Y');

                if ($item[$key] == "En attente")
                    $item[$key] = "<div class='badge badge-secondary fw-bold'>$item[$key]</div>";

                if ($item[$key] == "payer")
                    $item[$key] = "<div class='badge badge-success fw-bold'>$item[$key]</div>";

                if ($item[$key] == "Payée")
                    $item[$key] = "<div class='badge badge-success fw-bold'>$item[$key]</div>";

                if ($item[$key] == "Partiel")
                    $item[$key] = "<div class='badge badge-primary fw-bold'>$item[$key]</div>";

                if ($item[$key] == "Annuler")
                    $item[$key] = "<div class='badge badge-danger fw-bold'>$item[$key]</div>";


                if ($item[$key] == "Partielle")
                    $item[$key] = "<div class='badge badge-primary fw-bold'>$item[$key]</div>";

                if ($item[$key] == "Terminée")
                    $item[$key] = "<div class='badge badge-success fw-bold'>$item[$key]</div>";

                if ($item[$key] == "Non livrée")
                    $item[$key] = "<div class='badge badge-danger fw-bold'>$item[$key]</div>";

                if ($item[$key] == "FA")
                    $item[$key] = "<div class='badge badge-danger fw-bold'> Fact. Avoir</div>";

                if ($item[$key] == "FV")
                    $item[$key] = "<div class='badge badge-success fw-bold'> Fact. Vente </div>";

                if ($item[$key] == "EV")
                    $item[$key] = "<div class='badge badge-success fw-bold'> Fact. Vente Exportat* </div>";

                if ($item[$key] == "EA")
                    $item[$key] = "<div class='badge badge-danger fw-bold'> Fact. Avoir Exportat* </div>";

                if (gettype($item[$key]) === 'boolean') {
                    $value = $item[$key] ? 1 : 0;
                    $checked = $item[$key] ? "checked" : "";
                    $item[$key] = '
                        <div class="form-check form-check-sm form-check-custom form-check-solid">
                            <input class="form-check-input" type="checkbox" disabled value="' . $value . '" checked="' . $checked . '"/>
                        </div>';
                }
                if (is_numeric($item[$key]) && is_float($item[$key] + 0)) {
                    $item[$key] = number_format($item[$key], 2, '.', ' ');
                }
            }
            return $item;
        }, $data);
    }

    function is_decimal($val)
    {
        return is_numeric($val) && is_float();
    }

    /**
     * @param $array
     * @param $keyword
     * @return array
     */
    public function arraySearch($array, $keyword)
    {
        return array_filter($array, function ($a) use ($keyword) {
            return (bool)preg_grep("/$keyword/i", (array)$a);
        });
    }

    /**
     * @param $array
     * @param $allowed
     * @return array
     */
    public function filterArray($array, $allowed = [])
    {
        $arr = array_filter(
            $array,
            function ($val, $key) use ($allowed) { // N.b. $val, $key not $key, $val
                return isset($allowed[$key]) && ($allowed[$key] === true || $allowed[$key] === $val);
            },
            ARRAY_FILTER_USE_BOTH
        );

        return $arr;
    }

    /**
     * @Route(
     *     "/list-des-{class}/{action}",
     *     name="app_entity_liste",
     *     methods={"GET"}
     *     )
     */
    public function lists(Request $request, Environment $env, LibrairieService $lib, $class, $action)
    {
        $data = $request->query->all();
        $html = '';
        $html_new = '';

        $classname = 'App\\Entity\\' . ucfirst($class);
        $classtype = 'App\\Form\\' . ucfirst($class . 'Type');
        $repository = $this->em->getRepository(get_class(new $classname()));
        $entities = $repository->findAll();

        $entity = new $classname();
        if ($action == 'list') {
            if ($env->getLoader()->exists($lib->camel2dashed($class) . '/list.html.twig')) {
                $view = $lib->camel2dashed($class) . '/list.html.twig';
                $html = $this->renderView($view, [
                    'entities' => $entities,
                ]);
            }
            $results['html'] = $html;
        } else {
            if ($env->getLoader()->exists($lib->camel2dashed($class) . '/partials/_form.html.twig')) {
                if ($class == "CommandeClient") {
                    $client = $this->em->getRepository(Client::class)->findOneBy(['nom' => "cash", 'prenom' => "cash"]);
                    $entity->setAcheteur($client);
                }
                $form = $this->createForm(get_class(new $classtype()), $entity);
                $form->handleRequest($request);

                $view = $lib->camel2dashed($class) . '/partials/_card_form.html.twig';
                $html_new = $this->renderView($view, [
                    'entity' => $entity,
                    'form' => $form->createView(),
                ]);
            }
            /*$commandeClient = new CommandeClient();
            $form = $this->createForm(CommandeClientType::class, $commandeClient);
            $form->handleRequest($request);
            $view = $lib->camel2dashed($class) . '/partials/_form.html.twig';
            $html_new = $this->renderView($view, [
                'commande_client' => $commandeClient,
                'form' => $form,
            ]);*/
            $results['html'] = $html_new;
        }
        return new JsonResponse($results);
    }

    /**
     * @return Response
     * @Route("/chargement/base", name="app_load_data", methods={"GET", "POST"})
     */
    public function createDatabaseData()
    {
        set_time_limit(0);
        $rootDirectory = $this->getParameter('root_directory');
        $faker = Factory::create('fr_FR');

        ### POINT DE VENTE
        $pointVente = $this->session->get('pointVente', []);
        $poinVente = new PointDeVente();
        $poinVente->setCode('pv_pr');
        $poinVente->setEstPrincipal(true);
        $poinVente->setAdresse('-');
        $poinVente->setLibelle('POINT DE VENTE PRINCIPAL');
        $poinVente->setTel('0');
        $this->em->persist($poinVente);

        if (empty($pointVente)) {
            $this->session->set('pointVente', $poinVente);
        }

        ### MODE DE PAIE
        $arr_mode_paie = [
            'ESP' => 'espèce',
            'CC' => 'Compte',
            'CH' => 'Chèque',
            'VIR' => 'Virement',
            'MMO' => 'Mobile Money',
        ];
        foreach ($arr_mode_paie as $key => $value) {
            $mode = new ModePaiement();
            $mode->setCode($key);
            $mode->setLibelle($value);
            $this->em->persist($mode);
        }

        ### TAXES
        $arr_taxe = [
            ['libelle' => 'TAXE SUR VALEUR AJOUTEE',        'appellation' => 'TVA',     'typeTaux' => 0, 'taux' => 18,  'sens' => 1, 'code' => 'TVA'],
            ['libelle' => 'ACCOMPTE ASSIS SUR IMPÖTS',      'appellation' => 'AIB',     'typeTaux' => 0, 'taux' => 1,   'sens' => 0, 'code' => 'AIB1'],
            ['libelle' => 'ACCOMPTE ASSIS SUR IMPÖTS',      'appellation' => 'AIB',     'typeTaux' => 0, 'taux' => 5,   'sens' => 0, 'code' => 'AIB5'],
            ['libelle' => 'ACCOMPTE ASSIS SUR IMPÖTS',      'appellation' => 'AIB',     'typeTaux' => 0, 'taux' => 3,   'sens' => 0, 'code' => 'AIB3'],
            ['libelle' => 'EXONERE',                        'appellation' => 'EX',      'typeTaux' => 0, 'taux' => 0,   'sens' => 1, 'code' => 'TVA-EX'],
            ['libelle' => 'EXPORTATION',                    'appellation' => 'TVA-EXP', 'typeTaux' => 0, 'taux' => 0,   'sens' => 1, 'code' => 'TVA-EXP'],
            ['libelle' => 'TVA REGIME D\'EXCEPTION 18%',    'appellation' => 'TVAD',    'typeTaux' => 0, 'taux' => 18,  'sens' => 1, 'code' => 'TVAD'],
            ['libelle' => 'TPS',                            'appellation' => 'E',       'typeTaux' => 0, 'taux' => 0,   'sens' => 1, 'code' => 'E'],
            ['libelle' => 'RESERVE',                        'appellation' => 'F',       'typeTaux' => 0, 'taux' => 0,   'sens' => 1, 'code' => 'F'],
        ];
        foreach ($arr_taxe as $ligne) {
            $taxe = new Taxe();
            $taxe->setLibelle($ligne['libelle']);
            $taxe->setAppellation($ligne['appellation']);
            $taxe->setTypeTaux($ligne['typeTaux']);
            $taxe->setTaux($ligne['taux']);
            $taxe->setSens($ligne['sens']);
            $taxe->setCodeTaxe($ligne['code']);
            $taxe->setTypeTaxe(NULL);
            $taxe->setPointVente($poinVente);
            $this->em->persist($taxe);
        }

        $this->em->flush();


        ### GROUPE DE TAXE
        $arr_groupe_taxe = [
            ['libelle' => 'A - EXONERE',                        'code' => 'A',  'taux' => 5],
            ['libelle' => 'B - TAXABLE 18%',                    'code' => 'B',  'taux' => 1],
            ['libelle' => 'C - EXPORTATION',                    'code' => 'C',  'taux' => 6],
            ['libelle' => 'D - TVA REGIME D\'EXCEPTION 18%',    'code' => 'D',  'taux' => 7],
            ['libelle' => 'E - REGIME TPS',                     'code' => 'E',  'taux' => 8],
            ['libelle' => 'F - RESERVE',                        'code' => 'F',  'taux' => 9],
        ];
        foreach ($arr_groupe_taxe as $line) {
            $taux = $this->taxeRepo->find($line['taux']);
            $gtace = new GroupeTaxe();
            $gtace->setCodeGr($line['code']);
            $gtace->setLibelleGr($line['libelle']);
            $gtace->setTauxGr($taux);
            $gtace->setPointVente($poinVente);
            $this->em->persist($gtace);
        }

        ### CLIENT ORDINAIRE
        $client = new Client();
        $client->setNom('Ordinaire');
        $client->setPrenom('-');
        $client->setAdresse('-');
        $client->setNomClient('Ordinaire -');
        $client->setStatut('Physique');
        $client->setPointVente($poinVente);
        $this->em->persist($client);



        ### MONNNAIE
        $arr_monnaies = [5, 10, 25, 50, 100, 200, 250, 500, 1000, 2000, 5000, 10000];
        foreach ($arr_monnaies as $mon) {
            $monnaie = new Monnaie();
            $monnaie->setLibelle($mon . '' . 'F CFA');
            $monnaie->setValeur($mon);
            $this->em->persist($monnaie);
        }

        $arr_typeops = ['Dépôt', 'Retrait'];
        foreach ($arr_typeops as $arr_typeop) {
            $type = new TypeOperation();
            $type->setLibelle($arr_typeop);
            $this->em->persist($type);
        }

        ### FONCTIONS
        $fonctions = [
            'DIR'  => 'DIRECTEUR',
            'GER'  => 'GERANT',
            'COMP' => 'COMPTABLE',
            'CAIS' => 'CAISSIERE',
        ];
        foreach ($fonctions as $key => $fonc) {
            $fonction = new Fonction();
            $fonction->setCode($key);
            $fonction->setIntitule($fonc);
            $this->em->persist($fonction);
        }



        // //Point de vent

        // $filename = $rootDirectory . '/importation/produit.csv';
        // $handle = fopen($filename, "r");
        // while (($raw_string = fgets($handle)) !== false) {
        //     $row = str_getcsv($raw_string, ';');
        //     if ($row[0]) {
        //         $famille = $this->em->getRepository(Famille::class)->findOneBy(['codeFamille' => $row[0]]);
        //         if ($famille) {
        //             $produit = new Produit;
        //             $produit->setFamille($famille);
        //             $produit->setRefProd($row[1]);
        //             $produit->setNomProd($row[2]);
        //             $produit->setEstTaxable($row[3]);
        //             $produit->setEstService($row[4]);
        //             $produit->setDescProd($row[5]);
        //             $produit->setSeuilAppro(0);
        //             $produit->setStock(0);
        //             $produit->setPointDeVente($poinVente);
        //             $this->em->persist($produit);
        //             $this->em->flush();
        //         }
        //     }
        // }
        // fclose($handle);

        //ProduitConditionnement
        // $filename = $rootDirectory . '/importation/produitConditionnement.csv';
        // $handlep = fopen($filename, "r");
        // while (($raw_string = fgets($handlep)) !== false) {
        //     $row = str_getcsv($raw_string, ';');
        //     if ($row[0]) {
        //         $produit = $this->em->getRepository(Produit::class)->findOneBy(['descProd' => $row[0]]);
        //         $conditionnement = $this->em->getRepository(Conditionnement::class)->findOneBy(['codeCond' => $row[1]]);

        //         if ($produit && $conditionnement) {
        //             $produitCond = new ProduitConditionnement();
        //             $produitCond->setProduit($produit);
        //             $produitCond->setConditionnement($conditionnement);
        //             $produitCond->setPrixDeVente($row[2]);
        //             $produitCond->setPrixDeVenteHT($row[2]);
        //             $produitCond->setPrixDeVenteTTC($row[3]);
        //             $produitCond->setQteStockCond(0);
        //             $produitCond->setQteCond($row[4]);
        //             $nomProCond = $produit->getNomProd() . ' ['. $conditionnement->getLibelleCond().']';
        //             $produitCond->setNomProCond($nomProCond);
        //             $produitCond->setQteStockCondLogique($row[4]);
        //             if ($row[3] > 1000) {
        //                 $produitCond->setPrixMax((int)$row[3]  + 200);
        //                 $produitCond->setPrixMin((int)$row[3] - 100);  
        //             }else if ($row[3] > 0 && $row[3] <= 1000 ){
        //                 $produitCond->setPrixMax((int)$row[3]  + 100);
        //                 $produitCond->setPrixMin((int)$row[3] - 50);  
        //             }else{
        //                 $produitCond->setPrixMax((int)$row[3]);
        //                 $produitCond->setPrixMin((int)$row[3]);
        //             }
        //             $this->em->persist($produitCond);
        //         }
        //     }
        // }
        // fclose($handlep);



        /** @var Personnel */
        $personnel = new Personnel();
        $personnel->setNom('ADMIN');
        $personnel->setPrenoms('ROMAS');
        $personnel->setEmail('contact@romastechnologie.com');
        $personnel->setTel('0');
        $personnel->setSexe('Masculin');
        $this->em->persist($personnel);


        $user = new Utilisateur();
        $user->setUsername("Administrateur");
        $user->setPassword($this->passwordHasher->hashPassword($user, "admin@rom@s"));
        $user->setRoles([
            'ROLE_ADRESSE_LIVRAISON',
            'ROLE_APPROVISIONNEMENT',
            'ROLE_BANQUE',
            'ROLE_CAISSE',
            'ROLE_CLIENT',
            'ROLE_COMMANDE_CLIENT',
            'ROLE_COMMANDE_FRS',
            'ROLE_CONDITIONNEMENT',
            'ROLE_COMPTE',
            'ROLE_DEMANDE_DE_PRIX',
            'ROLE_ETAT',
            'ROLE_FACTURE',
            'ROLE_FACTURE_PRO_FORMA',
            'ROLE_FAMILLE',
            'ROLE_FONCTION',
            'ROLE_FOURNISSEUR',
            'ROLE_INVENTAIRE',
            'ROLE_LISTE_CAISSE',
            'ROLE_LIVRAISON',
            'ROLE_MAGASIN',
            'ROLE_MODEL_SIGNATURE',
            'ROLE_MODE_PAIEMENT',
            'ROLE_MONNAIE',
            'ROLE_PAIEMENT',
            'ROLE_MOUVEMENT_STOCK',
            'ROLE_STAT_VENTE',
            'ROLE_POINT_COMMANDE',
            'ROLE_ETAT_PRODUIT',
            'ROLE_ETAT_CLIENT',
            'ROLE_ETAT_FICHE',
            'ROLE_PROFIL',
            'ROLE_TRANSFERT',
            'ROLE_TRANSACTION',
            'ROLE_SORTIE',
            'ROLE_UTILISATEUR',
            'ROLE_POINT_VENTE',
            'ROLE_TAXE',
            'ROLE_TYPE_TAXE',
            'ROLE_TYPE_OPERATION',
            'ROLE_PERSONNEL',
            'ROLE_PRODUIT',
            'ROLE_SOCIETE',
            'ROLE_MENU',
            'ROLE_DEPENSE',
            'ROLE_SUIVI_STOCK',
            'ROLE_DEMANDE_PRIX',
            'ROLE_TYPE_DEPENSE',
            'ROLE_MODEL_SIGNATAIRE',
            'ROLE_DEPOT',
            'ROLE_CONFIGURATION',
            'ROLE_MODE_DE_PAIEMENT'
        ]);
        $this->em->persist($user);


        ### MAGASIN
        $magasins = [
            ['MP', 'MAGASIN PRINCIPAL', '-', '1']
        ];
        foreach ($magasins as $mag) {
            $magasin = new Magasin();
            $magasin->setCodeMag($mag[0]);
            $magasin->setNomMag($mag[1]);
            $magasin->setAdresse($mag[2]);
            $magasin->setSuperviseur($personnel);
            $magasin->setEstPrincipal($mag[3]);
            $this->em->persist($magasin);
        }

        ### CONDITIONNEMENT
        $conditionnements = [
            ['UNI', 'UNITE', '1']
        ];
        foreach ($conditionnements as $cond) {
            $conditionnement = new Conditionnement();
            $conditionnement->setCodeCond($cond[0]);
            $conditionnement->setLibelleCond($cond[1]);
            $conditionnement->setValeur(1);
            $this->em->persist($conditionnement);
        }

        ### CONFIGURATION
        $configuration = new Configuration();
        $configuration->setEstModeCarreau(true);
        $configuration->setFormatImpression('A4');
        $this->em->persist($configuration);

        ### MEDIA
        $media = new Media();
        $media->setNomMedia('1.jpg');
        $media->setExtension('jpg');
        $this->em->persist($media);



        ### CAISSE
        $caisse = new ListCaisse();
        $caisse->setCode('CP');
        $caisse->setLibelle('CAISSE PRINCIPAL');
        $caisse->setEtat(0);
        $this->em->persist($caisse);


        ### MODEL SIGNATAIRE
        $model = new ModelSignataire();
        $model->setLibelle('Model 1');
        $model->setEstDefault(true);

        $mspf = new ModelSignatairePersonnelFonction();
        $mspf->setFonction($fonction);
        $mspf->setPersonnel($personnel);

        $model->addModelSignatairePersonnelFonction($mspf);
        $this->em->persist($model);

        ### FAMILLE
        $famille = new Famille();
        $famille->setCodeFamille('SER');
        $famille->setLibelleFamille('SERVICE');
        $famille->setPointVente($poinVente);
        $this->em->persist($famille);

        ### SOCIETE
        $societe = new Societe();
        $societe->setAdresse('COTONOU');
        $societe->setSigle('ROMAS');
        $societe->setDenomination('ROYAL MAGNIFICAT SERVICES SARL');
        $societe->setRaisonSociale('ROYAL MAGNIFICAT SERVICES SARL');
        $societe->setRccm('-');
        $societe->setTelephone('99999999');
        $societe->setIfu('3201501642813');
        $societe->setLieuImpression('Cotonou');
        $societe->setApiLink('https://developper.impots.bj/sygmef-emcf');
        $societe->setApiNim('TS01003999');
        $societe->setApiToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjMyMDE1MDE2NDI4MTN8VFMwMTAwMzk5OSIsInJvbGUiOiJUYXhwYXllciIsIm5iZiI6MTY4NjY3NTkzNiwiZXhwIjoxNzAzOTc3MjAwLCJpYXQiOjE2ODY2NzU5MzYsImlzcyI6ImltcG90cy5iaiIsImF1ZCI6ImltcG90cy5iaiJ9.j0wNlllvxEsrdBCcVbH5pHD2ORS4b9OCQtqot8g_3Rg');
        $societe->setEntete($media);
        $societe->setEstRegimeTPS(false);
        $societe->setEstModeMecef(false);
        $this->em->persist($societe);


        $user->setPersonnel($personnel);
        $this->em->persist($user);

        $up = new UtilisateurPointDeVente();
        $up->setUtilisateur($user);
        $up->setPointDeVente($poinVente);
        $up->setEstActif(1);
        $this->em->persist($up);

        $this->em->flush();

        $this->parameters->getMenus(true);

        return $this->redirectToRoute('app_login');
        // return new JsonResponse('Chargement de données réussi !!');
    }


    /**
     * @return Response
     * @Route("/importation/produit/inventaire", name="app_importation_produit_inventaire", methods={"GET", "POST"})
     */
    public function importProduitInventorier()
    {
        set_time_limit(0);
        $rootDirectory = $this->getParameter('root_directory');

        $filename = $rootDirectory . '/importation/inventaire.csv';
        $handle = fopen($filename, "r");

        while (($raw_string = fgets($handle)) !== false) {
            $row = str_getcsv($raw_string, ';');
            if ($row[0]) {

                //FAMILLE
                $famille = $this->em->getRepository(Famille::class)->findOneBy(['libelleFamille' => $row[0]]);
                if (!$famille) {
                    $valeur = $row[0];
                    $famille  = new Famille();
                    $famille->setLibelleFamille($row[0]);
                    $famille->setCodeFamille(substr($valeur, 0, 4));
                    $this->em->persist($famille);
                    // $this->em->flush();
                }

                //CONDITIONNEMENT
                $conditionnement = $this->em->getRepository(Conditionnement::class)->findOneBy(['libelleCond' => $row[4]]);
                if (!$conditionnement) {
                    $conditionnement = new Conditionnement();
                    $conditionnement->setCodeCond(substr($row[4], 0, 4));
                    $conditionnement->setLibelleCond($row[4]);
                    $this->em->persist($conditionnement);
                }

                //PRODUIT
                $produit = $this->em->getRepository(Produit::class)->findOneBy(['nomProd' => $row[1]]);
                $groupTaxe = $this->em->getRepository(GroupeTaxe::class)->findOneBy(['id' => '2']);
                $magasin = $this->em->getRepository(Magasin::class)->findOneBy(['estPrincipal' => true]);

                if (!$produit) {
                    $prod = new Produit();
                    $prod->setFamille($famille);
                    $prod->setGroupeTaxe($groupTaxe);
                    $prod->setModeDefPrix(1);
                    $prod->setMagasinDefaut($magasin);
                    $prod->setEstTaxable(true);
                    $prod->setEstService(false);
                    $prod->setEstModeCarreau(false);
                    $prod->setNomProd($row[1]);
                    $prod->setStock($row[2]);
                    $pc = new ProduitConditionnement();
                    $pc->setPrixDeVente(preg_replace('/\s+/', '', $row[3]));
                    $pc->setConditionnement($conditionnement);
                    $pc->setQteStockCondLogique($row[2]);
                    $pc->setQteStockCond($row[2]);
                    $pc->setQteCond(1);
                    $prod->addProduitConditionnement($pc);
                    $this->em->persist($prod);

                    // PRODUIT COND MAG
                    $prodCondMag = new ProduitCondMag();
                    $prodCondMag->setProduitConditionnement($pc);
                    $prodCondMag->setMagasin($magasin);
                    $prodCondMag->setQteStockMag($row[2]);
                    $this->em->persist($prodCondMag);
                }
                $this->em->flush();
            }
        }
        fclose($handle);
        self::importInventaire();

        return new JsonResponse('Importation terminé !!');
    }

    /**
     * @return Response
     * @Route("/importer/inventaire", name="app_importation_inventaire", methods={"GET", "POST"})
     */
    public function importInventaire()
    {
        set_time_limit(0);
        $rootDirectory = $this->getParameter('root_directory');

        $filename = $rootDirectory . '/importation/inventaire.csv';
        $handle = fopen($filename, "r");

        $personnel = $this->em->getRepository(Personnel::class)->find(1);

        $magasin = $this->em->getRepository(Magasin::class)->findOneBy(['estPrincipal' => true]);
        $inventaire = new Inventaire();
        $inventaire->setDateDebutInv(new \DateTime());
        $inventaire->setMotif("inventaire initial");
        $inventaire->addPersonnesConcernee($personnel);
        $this->em->persist($inventaire);

        $inventaireMag = new InventaireMag();
        $inventaireMag->setInventaire($inventaire);
        $inventaireMag->setMagasin($magasin);
        $this->em->persist($inventaireMag);

        while (($raw_string = fgets($handle)) !== false) {
            $row = str_getcsv($raw_string, ';');
            if ($row[0]) {
                $produit = $this->em->getRepository(Produit::class)->findOneBy(['nomProd' => $row[1]]);
                if ($produit == null) {
                    dd($row[1]);
                }
                $prodCondMagInv = new ProduitCondMagInv();
                $prodCondMagInv->setQteCondStockLog(0);
                $prodCondMagInv->setQteCondStockPhy($row[2]);
                $prodCondMagInv->setProduitCondInv($produit->getProduitConditionnements()->first());
                $prodCondMagInv->setEcart($row[2]);
                $prodCondMagInv->setInventaireMag($inventaireMag);
                $this->em->persist($prodCondMagInv);
            }
        }
        fclose($handle);

        $inventaire->setDateFinInv(new \DateTime());
        // $this->em->persist($inventaire);

        $this->em->flush();
        return new JsonResponse('Importation terminé !!');
    }



    /**
     * @return Response
     * @Route("/chargement/utilisateur", name="app_load_data_user", methods={"GET", "POST"})
     */
    public function createUser(UserPasswordHasherInterface $passwordHasher, PointDeVenteRepository $pvr, PersonnelRepository $pr)
    {

        $pv = $pvr->find(1);
        // if (empty($pv)) {
        $this->session->set('pointVente', $pv);
        // }
        $personnel1 = $pr->find(1);

        // /** @var Personnel */
        // $personnel = new Personnel();
        // $personnel->setNom('ADMIN');
        // $personnel->setPrenoms('ROMAS');
        // $personnel->setEmail('admin@gmail.com');
        // $personnel->setTel('0');
        // $personnel->setSexe('Masculin');
        // $this->em->persist($personnel);  
        // $this->em->flush();

        // $user = new Utilisateur();
        // $user->setUsername("Administrateur");
        // $user->setPassword($this->passwordHasher->hashPassword($user,"admin@rom@s"));
        // $user->setRoles(['ROLE_SUPER_ADMIN']);
        // $user->setPersonnel($personnel);
        // $this->em->persist($user);
        // $this->em->flush();

        $user = new Utilisateur();
        $user->setUsername("Administrateur");
        $user->setPassword($this->passwordHasher->hashPassword($user, "admin@rom@s"));
        $user->setRoles([
            'ROLE_ADRESSE_LIVRAISON',
            'ROLE_APPROVISIONNEMENT',
            'ROLE_BANQUE',
            'ROLE_CAISSE',
            'ROLE_CLIENT',
            'ROLE_COMMANDE_CLIENT',
            'ROLE_COMMANDE_FRS',
            'ROLE_CONDITIONNEMENT',
            'ROLE_COMPTE',
            'ROLE_DEMANDE_DE_PRIX',
            'ROLE_ETAT',
            'ROLE_FACTURE',
            'ROLE_FACTURE_PRO_FORMA',
            'ROLE_FAMILLE',
            'ROLE_FONCTION',
            'ROLE_FOURNISSEUR',
            'ROLE_INVENTAIRE',
            'ROLE_LISTE_CAISSE',
            'ROLE_LIVRAISON',
            'ROLE_MAGASIN',
            'ROLE_MODEL_SIGNATURE',
            'ROLE_MODE_PAIEMENT',
            'ROLE_MONNAIE',
            'ROLE_PAIEMENT',
            'ROLE_MOUVEMENT_STOCK',
            'ROLE_STAT_VENTE',
            'ROLE_POINT_COMMANDE',
            'ROLE_ETAT_PRODUIT',
            'ROLE_ETAT_CLIENT',
            'ROLE_ETAT_FICHE',
            'ROLE_PROFIL',
            'ROLE_TRANSFERT',
            'ROLE_TRANSACTION',
            'ROLE_SORTIE',
            'ROLE_UTILISATEUR',
            'ROLE_POINT_VENTE',
            'ROLE_TAXE',
            'ROLE_OBJECTIF',
            'ROLE_TYPE_TAXE',
            'ROLE_TYPE_OPERATION',
            'ROLE_PERSONNEL',
            'ROLE_PRODUIT',
            'ROLE_SOCIETE',
            'ROLE_MENU',
            'ROLE_DEPENSE',
            'ROLE_SUIVI_STOCK',
            'ROLE_DEMANDE_PRIX',
            'ROLE_TYPE_DEPENSE',
            'ROLE_MODEL_SIGNATAIRE',
            'ROLE_DEPOT',
            'ROLE_CONFIGURATION',
            'ROLE_MODE_DE_PAIEMENT'
        ]);
        $user->setPersonnel($personnel1);
        $this->em->persist($user);
        $this->em->flush();



        // $up = new UtilisateurPointDeVente();
        // $up->setUtilisateur($user);
        // $up->setPointDeVente($pv);
        // $up->setEstActif(1);
        // $this->em->persist($up);

        // $this->em->flush();


        return new JsonResponse('Utilisateur créé !!');
    }


    /**
     * @Route("/verifier/unicite", name="romassigcom_verifier_unicite", methods={"GET", "POST"})
     */
    public function verifierUnicite(Request $request)
    {
        $em = $this->getDoctrine()->getManager();
        $col = $request->query->get('column');
        $valeur = $request->query->get('valeur');
        $entity = $request->query->get('entity');
        $id = $request->query->get('id');
        if ($col != '' && $valeur != '' && $entity != '') {
            $classname = 'App\\Entity\\' . ucfirst($entity);
            $query = $em->getRepository(get_class(new $classname()))->createQueryBuilder('o');
            if ($valeur)
                $query = $query->andWhere(is_null($valeur) || empty($valeur) ?
                    'TRIM(LOWER(o.' . $col . ')) IS NULL' :
                    'TRIM(LOWER(o.' . $col . ')) = \'' . trim(strtolower($valeur)) . '\'');
            if ($id)
                $query = $query->andWhere(is_null($id) || empty($id) ? 'TRIM(o.id) IS NULL' : 'o.id != \'' . trim($id) . '\'');

            $query = $query->andWhere('o.estSup IS NULL');
            $objet = $query->getQuery()->getResult();
            return new JsonResponse($objet);
        }
        return '';
    }

    /**
     * @Route("/supprimer/{id}/{entity}", name="romassigcom_suppresion_logique", methods={"GET", "POST"})
     */
    public function supprimer(Request $request)
    {
        $em = $this->getDoctrine()->getManager();
        $entity = $request->query->get('entity');
        $id = $request->query->get('id');
        $classname = 'App\\Entity\\' . ucfirst($entity);
        $entity = $em->getRepository(get_class(new $classname()))->find((int)$id);
        if ($entity != null) {
            $entity = $entity->setEstSup(1);
            $em->getRepository(get_class(new $classname()))->add($entity);
            if ($entity->getEstSup() == 1)
                return new JsonResponse("$entity a été supprimé avec succès");
        }
        return new JsonResponse("$entity n'a été supprimé avec succès");
    }
}
