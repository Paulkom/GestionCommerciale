<?php

namespace App\EventListener;

use App\Entity\Taxe;
use App\Entity\Banque;
use App\Entity\Caisse;
use App\Entity\Client;
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
use Doctrine\ORM\Events;
use App\Entity\Livraison;
use App\Entity\Personnel;
use App\Entity\SortieMag;
use App\Entity\Transfert;
use App\Entity\Inventaire;
use App\Entity\ListCaisse;
use App\Services\ApiMecef;
use App\Entity\CommandeFrs;
use App\Entity\Fournisseur;
use App\Entity\Transaction;
use App\Entity\Utilisateur;
use App\Entity\ApproMagasin;
use App\Entity\ModePaiement;
use App\Entity\PointDeVente;
use App\Entity\DemandeDePrix;
use App\Entity\InventaireMag;
use App\Entity\MonnaieCaisse;
use App\Entity\TypeOperation;
use App\Entity\CommandeClient;
use App\Entity\ProduitCondMag;
use App\Entity\Conditionnement;
use App\Entity\FactureProforma;
use App\Entity\ModelSignataire;
use App\Entity\ProduitCondTrans;
use App\Entity\Approvisionnement;
use App\Entity\ProduitCondMagInv;
use App\Entity\ProduitCondMagLiv;
use App\Database\NativeQueryMySQL;
use App\Entity\ProduitCondComClit;
use App\Entity\ProduitCondApproMag;
use App\Entity\ProduitCondSortieMag;
use App\Repository\ClientRepository;
use App\Repository\ProfilRepository;
use PhpParser\Node\Expr\Cast\Double;
use App\Entity\ProduitConditionnement;
use App\Entity\ProduitDetacher;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\Event\OnFlushEventArgs;
use App\Repository\UtilisateurRepository;
use Doctrine\ORM\Event\PreFlushEventArgs;
use Doctrine\ORM\Event\PostFlushEventArgs;
use App\Repository\ProduitCondMagRepository;
use Symfony\Component\Security\Core\Security;
use Symfony\Component\HttpKernel\KernelEvents;
use Doctrine\Persistence\Event\LifecycleEventArgs;
use Symfony\Component\HttpKernel\Event\RequestEvent;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpKernel\Event\ExceptionEvent;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\RedirectController;
use Doctrine\Bundle\DoctrineBundle\EventSubscriber\EventSubscriberInterface;
use App\Exception\SessionExpiredException;
use DateTime;

ini_set('xdebug.max_nesting_level', 9999);

class EntitySubscriber implements EventSubscriberInterface
{
    protected $security;
    protected $em;
    protected $native;
    protected $oldMagasin = null;
    protected $newMagasin = null;
    protected $cmp = 0;
    private $mecefService;
    private $profilRepo;
    private $utilisateurRepo;
    private $clientRepo;
    private $router;
    // private $societe;
    

    private SessionInterface $session;

    public function __construct(EntityManagerInterface $em, Security $security,NativeQueryMySQL $nativ,
                                SessionInterface $session, ApiMecef $mecef, ProfilRepository $profilRepo,
                                UtilisateurRepository $utilisateurRepo,UrlGeneratorInterface $router,
                                ClientRepository $clientRepo) 
    {
        $this->security = $security;
        $this->em = $em;
        $this->native  = $nativ;
        $this->session = $session;
        $this->mecefService = $mecef;
        $this->profilRepo = $profilRepo;
        $this->utilisateurRepo = $utilisateurRepo;
        $this->clientRepo = $clientRepo;
        $this->router = $router;
    }

    function addProduitCondMag($_em, $_stock, $_magasin, $_produitConditionnement)
    {
        $produitCondMag = new ProduitCondMag;
        $produitCondMag->setQteStockMag($_stock);
        $produitCondMag->setMagasin($_magasin);
        $produitCondMag->setProduitConditionnement($_produitConditionnement);
        $_em->persist($produitCondMag);
        return $produitCondMag;
    }

    function produitCondMag($_em, $_produitCond, $_magasin)
    {
        $result = $_em->getRepository(ProduitCondMag::class)->findOneBy([
            'produitConditionnement' => $_produitCond,
            'magasin' => $_magasin
        ]);
        return $result;
    }

    public function getSubscribedEvents(): array
    {
        return [
            Events::prePersist,
            Events::postPersist,
            Events::preRemove,
            Events::postRemove,
            Events::preUpdate,
            Events::postUpdate,
            Events::preFlush,
            Events::postFlush,
            Events::onFlush,
        ];
    }


    public function prePersist(LifecycleEventArgs $args): void
    {
        
        $entity = $args->getEntity();
        $em = $args->getEntityManager();

        if ($entity instanceof CommandeClient) {
            $year = date("y");
            $prefix = "CO$year";
            $numcom = $em->getRepository(CommandeClient::class)->countCom();
            $entity->setRefCom($prefix . str_pad($numcom + 1, 6, "0", STR_PAD_LEFT));
            $entity->setOperateur($this->security->getUser());
        }

        if ($entity instanceof CommandeFrs) {
            $year = date("y");
            $prefix = "CF$year";
            $numcom = $em->getRepository(CommandeFrs::class)->countCom();
            $entity->setRefCom($prefix . str_pad($numcom + 1, 6, "0", STR_PAD_LEFT));
            $entity->setOperateur($this->security->getUser());
        }

        if ($entity instanceof DemandeDePrix) {
            $year = date("y");
            $prefix = "DP$year";
            $numcom = $em->getRepository(DemandeDePrix::class)->countCom();
            $entity->setRefDdp($prefix . str_pad($numcom + 1, 6, "0", STR_PAD_LEFT));
            $entity->setOperateur($this->security->getUser());
        }

        if ($entity instanceof Facture) {
            $year = date("y");
            $prefix = "FA$year";
            $numcom = $em->getRepository(Facture::class)->countCom();
            $entity->setRefFac($prefix . str_pad($numcom + 1, 6, "0", STR_PAD_LEFT));
            $entity->setOperateur($this->security->getUser());
        }

        if ($entity instanceof FactureProforma) {
            $year = date("y");
            $prefix = "FP$year";
            $numcom = $em->getRepository(FactureProforma::class)->countCom();
            $entity->setRefFactpro($prefix . str_pad($numcom + 1, 6, "0", STR_PAD_LEFT));
            $entity->setOperateur($this->security->getUser());
        }

        if ($entity instanceof Paiement) {
            $year = date("y");
            $prefix = "PA$year";
            $numcom = $em->getRepository(Paiement::class)->countCom();
            $entity->setRefPaie($prefix . str_pad($numcom + 1, 6, "0", STR_PAD_LEFT));
            $entity->setOperateur($this->security->getUser());
        }

        if ($entity instanceof Livraison) {
            $year = date("y");
            $prefix = "LI$year";
            $numcom = $em->getRepository(Livraison::class)->countId();
            $entity->setRefLiv($prefix . str_pad($numcom + 1, 6, "0", STR_PAD_LEFT));
            $entity->setOperateur($this->security->getUser());
        }

        if($entity instanceof ProduitConditionnement){

            $nom = $entity->getProduit()->getNomProd() . ' ['. $entity->getConditionnement()->getLibelleCond().']';
            $entity->setNomProCond($nom);

            $produit    = $entity->getProduit();
            $mode       = $produit->getModeDefPrix();
            $groupeTaxe = $produit->getGroupeTaxe()->getCodeGr();

            switch ($groupeTaxe ){

                case 'B':
                    if($mode == 1){
                        $entity->setPrixDeVenteHT( $entity->getPrixDeVente() / 1.18 );
                        $entity->setPrixDeVenteTTC( $entity->getPrixDeVente());
                    }else{
                        $entity->setPrixDeVenteHT( $entity->getPrixDeVente() );
                        $entity->setPrixDeVenteTTC( $entity->getPrixDeVente() * 1.18 );
                        // $entity->setPrixDeVenteHT( floatval(preg_replace('/\s+/', '', $entity->getPrixDeVente() )));
                        // $entity->setPrixDeVenteTTC( floatval(preg_replace('/\s+/', '', $entity->getPrixDeVente() ))  * 1.18 );
                    }
                    break;
                
                case 'D':
                    if($mode == 1){
                        $entity->setPrixDeVenteHT( $entity->getPrixDeVente() / 1.18 );
                        $entity->setPrixDeVenteTTC( $entity->getPrixDeVente());
                    }else{
                        $entity->setPrixDeVenteHT( $entity->getPrixDeVente());
                        $entity->setPrixDeVenteTTC( $entity->getPrixDeVente() * 1.18 );
                    }
                    break;
                
                default:
                    $entity->setPrixDeVenteHT($entity->getPrixDeVente());
                    $entity->setPrixDeVenteTTC($entity->getPrixDeVente());
                    break;
            }

        }


        if($entity instanceof CommandeClient || $entity instanceof Facture || $entity instanceof Paiement  || $entity instanceof Livraison 
            || $entity instanceof Caisse  || $entity instanceof Approvisionnement  || $entity instanceof DemandeDePrix  || $entity instanceof CommandeFrs
            || $entity instanceof FactureProforma  || $entity instanceof Produit  || $entity instanceof Famille  || $entity instanceof ProduitConditionnement
            || $entity instanceof Personnel || $entity instanceof Utilisateur || $entity instanceof ProduitCondMag || $entity instanceof ModelSignataire
            || $entity instanceof Transaction || $entity instanceof Client || $entity instanceof Magasin || $entity instanceof Sortie
            || $entity instanceof TypeOperation || $entity instanceof Conditionnement  || $entity instanceof Taxe || $entity instanceof ListCaisse
            || $entity instanceof Banque || $entity instanceof Monnaie || $entity instanceof Inventaire || $entity instanceof Depense || $entity instanceof Fonction
            || $entity instanceof Transfert || $entity instanceof Profil || $entity instanceof Fournisseur ){
            
            if( empty($entity->getPointVente())){
                $pointVente = $this->session->get('pointVente');
                $pointVente =$this->em->getRepository(PointDeVente::class)->find((int)$pointVente->getId());
                $entity->setPointVente($pointVente);   
            }
            
        }

        if($entity instanceof Approvisionnement){
            if($entity->getReference() == ''){
                $entity->setReference('REF-'.strtoupper(bin2hex(random_bytes(8))));
            }
        }

        if($entity instanceof Produit){

            $em = $args->getObjectManager();
            $prefix = substr($entity->getFamille()->getCodeFamille(), 0, 3);
            // $nbProdParFam = $em->getRepository(Produit::class)->nbProdParFamille($prefix);
            $res = $em->getRepository(Produit::class)->lastProdParFamille($prefix);
            // dd($res);
            $pv = $this->session->get('pointVente', []);
            if( $res == [] ){
                $res = 0;
                $entity->setCodeProduit($prefix .$pv->getId(). str_pad($res + 1, 7, "0", STR_PAD_LEFT));
            }else{
                $res = $res[0]['codeProduit'];
                $res = (int)str_replace($prefix,'',$res);
                $entity->setCodeProduit($prefix . str_pad($res + 1, 7, "0", STR_PAD_LEFT));
            }
            
            
            // $entity->setCodeProduit($prefix . str_pad($res + 1, 7, "0", STR_PAD_LEFT));
            

        }
    }

    public function postPersist(LifecycleEventArgs $args): void
    {
        $em = $args->getEntityManager();
        $entity = $args->getObject();

        if ($entity instanceof ProduitCondApproMag) {
            $entity->getProduitConditionnement()->setQteStockCond(
                (double)$entity->getProduitConditionnement()->getQteStockCond() + (double)$entity->getQteCondAppro()
            ); // mise a jour du stock dans ProduitConditionnement
            $entity->getProduitConditionnement()->setQteStockCondLogique(
                (double)$entity->getProduitConditionnement()->getQteStockCondLogique() + (double)$entity->getQteCondAppro()
            ); // mise a jour du stock logique de produitconditionnent

            $entity->getProduitConditionnement()->getProduit()->setStock(
                $entity->getProduitConditionnement()->getProduit()->getStock() +
                ((double)$entity->getQteCondAppro() * $entity->getProduitConditionnement()->getQteCond())
            ); //mise a jour du stock dans Produit

            $entity->getProduitConditionnement()->setCump((double)$em->getRepository(Approvisionnement::class)->cumpFinPeriode($entity->getProduitConditionnement())); //calcul du cump

            $produitCondMag =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                'produitConditionnement' => $entity->getProduitConditionnement(),
                'magasin' => $entity->getApproMagasin()->getMagasin()
            ]);
            if ($produitCondMag != null) {
                $produitCondMag->setQteStockMag((double)$produitCondMag->getQteStockMag() + (double)$entity->getQteCondAppro());
            }else {
                $produitCondMag = new ProduitCondMag;
                $produitCondMag->setQteStockMag((double)$entity->getQteCondAppro());
            }
            $produitCondMag->setMagasin($entity->getApproMagasin()->getMagasin());
            $produitCondMag->setProduitConditionnement($entity->getProduitConditionnement());

            $em->persist($produitCondMag);
            
            $em->flush();
        }

        /* Mise à jour du stock lors de la livraison */
        if ($entity instanceof ProduitCondMagLiv) {

            $entity->getProduitComClit()->getProduit()->setQteStockCond(
                (double)$entity->getProduitComClit()->getProduit()->getQteStockCond() - (double)$entity->getQteLiv()
            ); // mise a jour du stock dans ProduitConditionnement

            $entity->getProduitComClit()->setRestAliv((double)$entity->getQteRALiv());
            $entity->getProduitComClit()->getProduit()->getProduit()->setStock(
                $entity->getProduitComClit()->getProduit()->getProduit()->getStock() -
                ((double)$entity->getQteLiv() * $entity->getProduitComClit()->getProduit()->getQteCond())
            ); //mise a jour du stock dans Produit

            $produitCondMag =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                'produitConditionnement' => $entity->getProduitComClit()->getProduit(),
                'magasin' => $entity->getLivraisonMag()->getMagasin()
            ]);

            if($produitCondMag != null) {
                $produitCondMag->setQteStockMag((double)$produitCondMag->getQteStockMag() - (double)$entity->getQteLiv());
            }else {
                $produitCondMag = new ProduitCondMag;
                $produitCondMag->setQteStockMag((double)$entity->getQteLiv());
            }

            $produitCondMag->setMagasin($entity->getLivraisonMag()->getMagasin());
            $produitCondMag->setProduitConditionnement($entity->getProduitComClit()->getProduit());

            $em->persist($produitCondMag);
            $em->flush();
        }


        /* Mise à jour du stock lors du detachement */
        if ($entity instanceof ProduitDetacher) {
            //mise à jour de la source du detachemnet
                //mise à jour du produit conditionnemt--------------------
                    $entity->getProduitCondMag()->getProduitConditionnement()->setQteStockCond(
                        (double)$entity->getProduitCondMag()->getProduitConditionnement()->getQteStockCond() - (double)$entity->getQuantite()
                    ); 
                    $entity->getProduitCondMag()->getProduitConditionnement()->setQteStockCondLogique(
                        (double)$entity->getProduitCondMag()->getProduitConditionnement()->getQteStockCondLogique() - (double)$entity->getQuantite()
                    );
                //-------------------------------------------------------
                //mise à jour du produit conditionnemt--------------------
                    $entity->getProduitCondMag()->setQteStockMag((double)$entity->getProduitCondMag()->getQteStockMag() - (double)$entity->getQuantite());
                //--------------------
            //Fin de la mise à jour de la source du detachemnet

            //mise à jour du cible du detachemnet 
                //mise à jour du produit conditionnemt--------------------
                    $entity->getCible()->setQteStockCond(
                        (double)$entity->getCible()->getQteStockCond() + (double)$entity->getQuantiteCible()
                    ); 
                    $entity->getCible()->setQteStockCondLogique(
                        (double)$entity->getCible()->getQteStockCondLogique() + (double)$entity->getQuantiteCible()
                    );
                //--------------------------------------------------------
                //mise du stock dans les magasin----
                    $produitCondMag =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                        'produitConditionnement' => $entity->getCible(),
                        'magasin' => $entity->getProduitCondMag()->getMagasin()
                    ]);

                    if($produitCondMag != null) {
                        $produitCondMag->setQteStockMag((double)$produitCondMag->getQteStockMag() + (double)$entity->getQuantiteCible());
                    }else {
                        $produitCondMag = new ProduitCondMag;
                        $produitCondMag->setQteStockMag((double)$entity->getQuantiteCible());
                        $produitCondMag->setMagasin($entity->getProduitCondMag()->getMagasin());
                        $produitCondMag->setProduitConditionnement($entity->getCible());
                    }
                //----------------------------------------------
            // fin du cible du detachemnet
            $em->persist($produitCondMag);
            $em->flush();
        }


        if ($entity instanceof ProduitCondComClit) {

            $entity->setLibelleProduit($entity->getProduit()->getNomProCond());
            $entity->setGroupeTaxeProduit(
                ( $entity->getProduit()->getProduit()->getGroupeTaxe()->getCodeGr() == 'A' ) ? 'A-EX' : $entity->getProduit()->getProduit()->getGroupeTaxe()->getCodeGr()
            );
            $entity->getProduit()->setQteStockCondLogique(
                (double)$entity->getProduit()->getQteStockCondLogique() - (double)$entity->getQtite()
            ); // mise a jour du stock dans ProduitConditionnement
            $entity->setRestAliv($entity->getQtite());
           /* $entity->getProduit()->getProduit()->setStock(
                $entity->getProduit()->getProduit()->getStock() -
                ((double)$entity->getQteALiv() * $entity->getProduitComClit()->getProduit()->getQteCond())
            ); //mise a jour du stock dans Produit

            $em->persist($produitCondMag);*/
           $em->flush();
            
        }

        if ($entity instanceof CommandeFrs){
            
            $ddp = $entity->getDemandeDePrix();
            if($ddp){
                $ddp->setEstTransformer(true);
                $this->em->flush();
            }
        }

        if ($entity instanceof Utilisateur){
            $roles = array();
            if([] != $entity->getProfil()){

                foreach ($entity->getProfil() as $pro) {
                    $profil = $this->profilRepo->find($pro);
                    foreach ($profil->getRoles() as $role) {
                        $roles[] = $role; 
                    }
                }
                $entity->setRoles($roles);
                $this->em->flush();
            }
        }

        if($entity instanceof Client){
          
            if($entity->getStatut() =="Physique"){
                $entity->setNomClient( $entity->getNom() . " " . $entity->getPrenom());
            }else{
                $entity->setNomClient( ' [' . $entity->getSigle() .'] '. $entity->getDenomination());
            }
            $em->flush();
        }
    
    }



    public function preRemove(LifecycleEventArgs $args)
    {
        $em = $args->getEntityManager();
        $entity = $args->getObject();

        if($entity instanceof ProduitCondMagLiv) {

            $qteStockCond = (double)$entity->getProduitComClit()->getProduit()->getQteStockCond() + (double)$entity->getQteCondSortie();
            $qteStock = (double)$entity->getProduitCond()->getProduit()->getStock() + ($qteStockCond * (double)$entity->getProduitCond()->getQteCond());
            $qteStockMag = (double)$entity->getProdCondMag()->getQteStockMag() + (double)$entity->getQteCondSortie();

            $entity->getProduitCond()->setQteStockCond($qteStockCond);
            $entity->getProduitCond()->getProduit()->setStock($qteStock);
            $entity->getProdCondMag()->setQteStockMag($qteStockMag);

        }
        
    }


    public function postRemove(LifecycleEventArgs $args): void
    {
        $em = $args->getEntityManager();
        $entity = $args->getObject();

       
    }

    public function preUpdate(LifecycleEventArgs $args): void
    {
        $entity = $args->getObject();
        $em = $args->getEntityManager();

        if ($entity instanceof ApproMagasin) {
           
            if ($args->hasChangedField('magasin')) {
                $oldMagasin = $args->getOldValue('magasin');
                $newMagasin = $args->getNewValue('magasin');

                $this->oldMagasin = $oldMagasin;
                $this->newMagasin = $newMagasin;
            }
        }

        if ($entity instanceof ProduitCondApproMag) {
           if($args->getEntityChangeSet() != []){
              
                if ($args->hasChangedField('qteCondAppro')) {
                    $oldValue = $args->getOldValue('qteCondAppro');
                    $newValue = $args->getNewValue('qteCondAppro');
                }

                if ($args->hasChangedField('produitConditionnement')) {
                    
                    //si le conditionnement change
                    $oldProduitCond = $args->getOldValue('produitConditionnement');
                    $newProduitCond = $args->getNewValue('produitConditionnement');
                    
                    //traitement ancien produitConditionnement
                    $magasin = ($this->oldMagasin != null) ? $this->oldMagasin  : $entity->getApproMagasin()->getMagasin(); //on verifie si le magasin a changer ou pas
                    $oldProduitCondMag = $this->produitCondMag($em, $oldProduitCond, $magasin);
                    if ($oldProduitCondMag != null) {
                        $oldProduitCondMag->setQteStockMag((float)$oldProduitCondMag->getQteStockMag() - (float)$oldValue);
                        $oldProduitCond->setQteStockCond( $oldProduitCond->getQteStockCond() - (float)$oldValue);//reajustement du stock dans produitConditionnement
                        $oldProduitCond->getProduit()->setStock($oldProduitCond->getProduit()->getStock() - ((float)$oldValue * $oldProduitCond->getQteCond())); // reajustement du stock dans produit
                    }

                    //traitement nouveau produitConditionnement
                    $_magasin = ($this->newMagasin != null) ? $this->newMagasin : $entity->getApproMagasin()->getMagasin(); // on verfie le changemenet de  magasin
                    $newProduitCondMag = $this->produitCondMag($em, $newProduitCond, $_magasin);
                    if ($newProduitCondMag != null) {
                        $newProduitCondMag->setQteStockMag((float)$newProduitCondMag->getQteStockMag() + (float)$newValue);
                        $newProduitCond->setQteStockCond( $newProduitCond->getQteStockCond() + (float)$newValue);//reajustement du stock dans produitConditionnement
                        $newProduitCond->getProduit()->setStock($newProduitCond->getProduit()->getStock() + ((float)$newValue * $newProduitCond->getQteCond())); // reajustement du stock dans produit
                    } else {
                        //creation du produitcondmag car il n'existe pas
                        $magasin = ($this->newMagasin != null) ? $this->newMagasin : $entity->getApproMagasin()->getMagasin(); // on verifie le magasin
                        $prodCondMag = $this->addProduitCondMag($this->em,(float)$newValue, $magasin, $newProduitCond);
                        $newProduitCond->setQteStockCond((float)$newValue);//ajout du stock dans produitConditionnement
                    }
                    
                } else {
                    if ($this->newMagasin != null) {
                        
                        //si le magasin change et/ou la quantite du produitConditionnement change
                        $newproduitCondMag = $this->produitCondMag($em, $entity->getProduitConditionnement(), $this->newMagasin);
                        $oldproduitCondMag = $this->produitCondMag($em, $entity->getProduitConditionnement(), $this->oldMagasin);
                        
                        if ($oldproduitCondMag != null) {
                            $oldproduitCondMag->setQteStockMag((float)$oldproduitCondMag->getQteStockMag() - (float)$oldValue);
                            $oldproduitCondMag->getProduitConditionnement()->setQteStockCond($oldproduitCondMag->getProduitConditionnement()->getQteStockCond() - (float)$oldValue );
                            $oldproduitCondMag->getProduitConditionnement()->getProduit()->setStock($oldproduitCondMag->getProduitConditionnement()->getProduit()->getStock() - ((float)$oldValue * $oldproduitCondMag->getProduitConditionnement()->getQteCond())); // reajustement du stock dans produit
                        }
                        
                        if ($newproduitCondMag != null) {
                            $newproduitCondMag->setQteStockMag((float)$newproduitCondMag->getQteStockMag() + (float)$entity->getQteCondAppro());
                            $newproduitCondMag->getProduitConditionnement()->setQteStockCond($newproduitCondMag->getProduitConditionnement()->getQteStockCond() + (float)$entity->getQteCondAppro());
                            $newproduitCondMag->getProduitConditionnement()->getProduit()->setStock($newproduitCondMag->getProduitConditionnement()->getProduit()->getStock() + ((float)$entity->getQteCondAppro() * $newproduitCondMag->getProduitConditionnement()->getQteCond())); // reajustement du stock dans produit
                        } else {
                            //creation du produitcondmag car il n'existe pas
                            $_n_pcm = $this->addProduitCondMag($this->em, (float)$newValue, $this->newMagasin, $entity->getProduitConditionnement());
                            $_n_pcm->getProduitConditionnement()->setQteStockCond((float)$newValue);
                            // $_n_pcm->getProduitConditionnement()->getProduit()->setStock($_n_pcm->getProduitConditionnement()->getProduit()->getStock() + );
                        }
                    } else {
                        //si la quantite du produit conditionnement change
                        $produitCondMag = $this->produitCondMag($em , $entity->getProduitConditionnement(), $entity->getApproMagasin()->getMagasin());
                        if ($produitCondMag != null) {
                            $produitCondMag->setQteStockMag((float)$produitCondMag->getQteStockMag() - (float)$oldValue + (float)$entity->getQteCondAppro());
                        }

                        $entity->getProduitConditionnement()->setQteStockCond(
                            (double)$entity->getProduitConditionnement()->getQteStockCond() 
                            - (float)$oldValue + (float)$entity->getQteCondAppro()
                        ); // mise a jour du stock dans ProduitConditionnement

                        $entity->getProduitConditionnement()->getProduit()->setStock(
                            $entity->getProduitConditionnement()->getProduit()->getStock()
                            - ((float)$oldValue * $entity->getProduitConditionnement()->getQteCond())
                            + ((double)$entity->getQteCondAppro() * $entity->getProduitConditionnement()->getQteCond())
                        ); //mise a jour du stock dans Produit
                    }

                }
            }
        }

        if($entity instanceof Livraison) {
            if ($entity->getEstSup() == 1) {
                // Suppression de Livraison
                $livraisonMagasins  = $entity->getLivraisonMagasins();
                foreach ($livraisonMagasins as $libMag) {
                    $produitCondMagLivs = $libMag->getProduitCondMagLivs();
                    $magasin = $libMag->getMagasin();
                    foreach ($produitCondMagLivs as $key => $produitCondMagLiv) {
                        $produitCond = $produitCondMagLiv->getProduitComClit()->getProduit();
                        $produit = $produitCond->getProduit();
                        $produitComClit = $produitCondMagLiv->getProduitComClit();

                        //Ajuster la quantité restante à livrer
                        $produitComClit->setRestAliv(($produitComClit->getRestAliv()? $produitComClit->getRestAliv():0 ) + $produitCondMagLiv->getQteLiv());
                        $repo = $args->getObjectManager()->getRepository(ProduitCondMag::class);

                        //Mise à jour du stock dans ProduitCondMag
                        $prodCondMag = $repo->findOneBy(['magasin' => $magasin, 'produitConditionnement' => $produitCond]);
                        if ($prodCondMag) {
                            $prodCondMag->setQteStockMag($prodCondMag->getQteStockMag() + $produitCondMagLiv->getQteLiv());
                            $em->persist($prodCondMag);
                        }

                        //mise a jour du stock dans ProduitConditionnement
                        $produitCond->setQteStockCond($produitCond->getQteStockCond() + $produitCondMagLiv->getQteLiv());

                        //Mise à jour du stock  de produit
                        $produit->setStock($produit->getStock() + ($produitCond->getQteCond() * $produitCondMagLiv->getQteLiv()));
                    
                        $em->persist($produitComClit); 
                        $em->persist($produitCond);
                        $em->persist($produit);
                    }
                }
            }
        }

        if($entity instanceof Sortie) {
            
            if ($entity->getEstSup() == 1) {
                $sortiMagasins  = $entity->getSortieMags();
                foreach ($sortiMagasins as $sortbMag) {
                    $produitCondSortieMags = $sortbMag->getProduitCondSortieMags();
                    $magasin = $sortbMag->getMagasin();
                    foreach ($produitCondSortieMags as $key => $produitCondSortieMag) {
                        $produitCond = $produitCondSortieMag->getProduitCond();
                        $produit = $produitCond->getProduit();

                        //Mise à jour du stock dans ProduitCondMag
                        $repo = $args->getObjectManager()->getRepository(ProduitCondMag::class);
                        $prodCondMag = $repo->findOneBy(['magasin' => $magasin, 'produitConditionnement' => $produitCond]);
                        if ($prodCondMag) {
                            $prodCondMag->setQteStockMag($prodCondMag->getQteStockMag() + $produitCondSortieMag->getQteCondSortie());
                            $em->persist($prodCondMag);
                        }

                        //mise a jour du stock dans ProduitConditionnement
                        $produitCond->setQteStockCond($produitCond->getQteStockCond() + $produitCondSortieMag->getQteCondSortie());

                        //Mise à jour du stock  de produit
                        $produit->setStock($produit->getStock() + ($produitCond->getQteCond() * $produitCondSortieMag->getQteCondSortie()));
                    
                        $em->persist($produitCond);
                        $em->persist($produit);
                    }
                }
            }
        }

        if($entity instanceof Transfert){
           
            if ($entity->getEstSup() == 1) {
                
                $magasin1 = $entity->getMagasinTrans1();
                $magasin2 = $entity->getMagasinTrans2();

                $produitCondtrans = $entity->getProduitCondTrans();
                foreach ($produitCondtrans as $produitcondtran) {

                    $qte         = $produitcondtran->getQteCondTrans();
                    $produitCond = $produitcondtran->getProduitCond();
                    $produit     = $produitCond->getProduit();

                    $produitCondMag1 =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                        'produitConditionnement' => $produitCond,
                        'magasin' => $magasin1
                    ]);
                    $produitCondMag2 =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                        'produitConditionnement' => $produitCond,
                        'magasin' => $magasin2
                    ]);

                    $pct1 = $produitCondMag1->setQteStockMag($produitCondMag1->getQteStockMag() + $qte);
                    $pct2 = $produitCondMag2->setQteStockMag($produitCondMag2->getQteStockMag() - $qte);
                    $em->persist($pct1);
                    $em->persist($pct2);
                }
            }
            

        }

        if($entity instanceof CommandeClient){

            if($entity->getEstSup() == 1) {
                
                $produitCmdClits = $entity->getProduitCondComClits();
                foreach ($produitCmdClits as $procmdclit) {
                    //produit conditionnement
                    $procmd = $procmdclit->getProduit();
                    $procmd->setQteStockCondLogique( $procmd->getQteStockCondLogique() + $procmdclit->getQtite());
                    $em->persist($procmd);
                }

                $facture = ($entity->getFactures()->filter(function($element){
                    return $element->getTypeFacture() == "FV";
                }))[0];
                if ($facture) {
                    $facture->setDeletedAt(new \DateTime());
                    $facture->setEstSup(true);

                    $paiements = $facture->getPaiements();
                    foreach ($paiements as $paiement) {
                        $paiement->setDeletedAt(new \DateTime());
                        $paiement->setEstSup(true);
                        $em->persist($paiement);
                    }
                    $em->persist($facture);
                }

                $livraisons = $entity->getLivraisons();
                foreach ($livraisons as $livr) {
                
                    $livraisonsMags = $livr->getLivraisonMagasins();
                    foreach ($livraisonsMags as $lm) {
                        $produitCondmaglivs = $lm->getProduitCondMagLivs();
                        $magasin = $lm->getMagasin();
                        foreach ($produitCondmaglivs as $pcml) {
                            
                            /** @var ProduitConditionnement */
                            $produitCon = $pcml->getProduitComClit()->getProduit();
                            /** @var ProduitCondMag */
                            $produitCondMag = $this->produitCondMag($em , $produitCon, $magasin);
                            $qte = $pcml->getQteLiv();
                            /** @var Produit */
                            $produit = $produitCon->getProduit();

                            $procmd->setQteStockCond( $procmd->getQteStockCond() + $qte);
                            $produit->setStock( $produit->getStock()  + ($produitCon->getQteCond() * $qte) );
                            $produitCondMag->setQteStockMag( $produitCondMag->getQteStockMag() + $qte);
                            $em->persist($procmd);
                            $em->persist($produit);
                            $em->persist($produitCondMag);
                        }
                        
                    }
                }

            }

        }

        if ($entity instanceof ProduitCondMagLiv) {
            $qteStockCond = (double)$entity->getProduitComClit()->getProduit()->getQteStockCond();
            if ($args->hasChangedField('qteLiv')) {
                $oldValue = $args->getOldValue('qteLiv');
                $newValue = $args->getNewValue('qteLiv');

                if($args->hasChangedField('produitComClit'))
                {
                    // Mise à jour de l'ancien produit
                    $oldQte = (double)$args->getOldValue('produitComClit')->getProduit()->getQteStockCond() + (double)$oldValue;
                    $args->getOldValue('produitComClit')->getProduit()->setQteStockCond($oldQte);

                    // Mise à jour de l'ancien produit
                    $qteStockCond -= (double)$newValue;

                    //Mise à jour du stock dans ProduitCondMag
                    $oldProduitCondMag =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                        'produitConditionnement' => $args->getOldValue('produitComClit')->getProduit(),
                        'magasin' => $entity->getLivraisonMag()->getMagasin()
                    ]);
                    $newProduitCondMag =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                        'produitConditionnement' => $args->getNewValue('produitComClit')->getProduit(),
                        'magasin' => $entity->getLivraisonMag()->getMagasin()
                    ]);
                    $oldProduitCondMag->setQteStockMag((double)$oldProduitCondMag->getQteStockMag() + (double)$oldValue);
                    $newProduitCondMag->setQteStockMag((double)$newProduitCondMag->getQteStockMag() - (double)$newValue);
                }
                else
                {
                    $qteStockCond += (double)$oldValue - (double)$newValue;

                    //Remettre à jour les stocks dans ProduitCondMag
                    $produitCondMag =  $em->getRepository(ProduitCondMag::class)->findOneBy([
                        'produitConditionnement' => $entity->getProduitComClit()->getProduit(),
                        'magasin' => $entity->getLivraisonMag()->getMagasin()
                    ]);
                    $produitCondMag->setQteStockMag((double)$produitCondMag->getQteStockMag() + (double)$oldValue - (double)$newValue);
                }
                $entity->getProduitComClit()->getProduit()->setQteStockCond($qteStockCond);
            }
        }

        if($entity instanceof Approvisionnement) {
           // cas de suppression d'approvisionnement
           if ($entity->getEstSup() == 1) {
                $approMagasins  = $entity->getApproMagasins();
                foreach ($approMagasins as $approMag) {
                    $produitCondApproMags = $approMag->getProduitCondApproMags();
                    $magasin = $approMag->getMagasin();
                    
                    foreach ($produitCondApproMags as $key => $produitCondApproMag) {

                        $produitCond = $produitCondApproMag->getProduitConditionnement();
                        $produit = $produitCond->getProduit();

                        $repo = $args->getObjectManager()->getRepository(ProduitCondMag::class);
                        $prodCondMags = $repo->findBy(['magasin' => $magasin, 'produitConditionnement' => $produitCond]);
                        
                        foreach ($prodCondMags as $key => $prodCondMag) {
                            if($prodCondMag->getQteStockMag() >= $produitCondApproMag->getQteCondAppro())
                                $prodCondMag->setQteStockMag($prodCondMag->getQteStockMag() - $produitCondApproMag->getQteCondAppro());
                            $em->persist($prodCondMag);
                        }

                        if($produitCond->getQteStockCond() >= $produitCondApproMag->getQteCondAppro()){
                            $produitCond->setQteStockCond($produitCond->getQteStockCond() - $produitCondApproMag->getQteCondAppro());
                            $produit->setStock($produit->getStock() - ( $produitCond->getQteCond() * $produitCondApproMag->getQteCondAppro()));
                        }

                        if($produitCond->getQteStockCondLogique() >= $produitCondApproMag->getQteCondAppro())
                            $produitCond->setQteStockCondLogique($produitCond->getQteStockCondLogique() - $produitCondApproMag->getQteCondAppro());
                        
                        $em->persist($produitCond);
                        $em->persist($produit);

                    }
                }
            }
        }

        if($entity instanceof ProduitConditionnement){
            $nom = $entity->getProduit()->getNomProd() . ' ['. $entity->getConditionnement()->getLibelleCond().']';
            $entity->setNomProCond($nom);

            if ($args->hasChangedField('qteCond')) {
                $old = $args->getOldValue('qteCond');
                $new = $args->getNewValue('qteCond');

                if($old != $new){
                    if ($old == 1) {
                        $produit = $entity->getProduit();
                        $produit->setStock($produit->getStock() * (int)$new);
                    }
                }
            }

        }

        if($entity instanceof Produit){

            if ($args->hasChangedField('nomProd')) {
                foreach ($entity->getProduitConditionnements() as $pc) {
                    $nom = $pc->getProduit()->getNomProd() . ' ['. $pc->getConditionnement()->getLibelleCond().']';
                    $pc->setNomProCond($nom);
                }
            }

            if ($args->hasChangedField('famille')){
                $em = $args->getObjectManager();
                $newFamille = $args->getNewValue('famille');
                $famille = $em->getRepository(Famille::class)->find($newFamille);

                $prefix = substr( $famille->getCodeFamille(), 0, 3);
                $res = $em->getRepository(Produit::class)->lastProdParFamille($prefix);
                // $res = (int)str_replace($prefix,'',$res);
                // $entity->setCodeProduit($prefix . str_pad($res + 1, 7, "0", STR_PAD_LEFT));
                $pv = $this->session->get('pointVente', []);
                if( $res == [] ){
                    $res = 0;
                    $entity->setCodeProduit($prefix .$pv->getId(). str_pad($res + 1, 7, "0", STR_PAD_LEFT));
                }else{
                    $res = $res[0]['codeProduit'];
                    $res = (int)str_replace($prefix,'',$res);
                    $entity->setCodeProduit($prefix . str_pad($res + 1, 7, "0", STR_PAD_LEFT));
                }
                
                // dd($res);
                // $entity->setCodeProduit($prefix .$pv->getId(). str_pad($res + 1, 7, "0", STR_PAD_LEFT));
            }

            // cas de suppression de produit
            if ($args->hasChangedField('deletedAt')) {
                foreach ($entity->getProduitConditionnements() as $pc) {
                    $pc->setDeletedAt(new \DateTime());
                    foreach ($pc->getProduitCondMags() as $pcm) {
                        $pcm->setDeletedAt(new \DateTime());
                    }
                }
            }
        }

        if ($entity instanceof ProduitCondMagInv) {

            if ($args->hasChangedField('estCloturer')) {

                $newValue = $args->getNewValue('estCloturer');

                if($newValue){
                    //reajustement du stock
                    $newStockCond = (float)$entity->getQteCondStockPhy();
                    $entity->getProduitCondInv()->setQteStockCond($newStockCond);
                    $entity->getProduitCondInv()->getProduit()->setStock(
                        $entity->getProduitCondInv()->getQteCond() * $newStockCond
                    );
                    $prodCondMag = $this->produitCondMag($em, $entity->getProduitCondInv(), $entity->getInventaireMag()->getMagasin());
                    if($prodCondMag)
                        $prodCondMag->setQteStockMag($newStockCond);
                }
            }
        }

        if ($entity instanceof Inventaire) {
            if ($args->hasChangedField('estCloturer')) {
                $newValue = $args->getNewValue('estCloturer');
                if($newValue){
                    $entity->setDateFinInv(new \DateTime());
                }
            }
        }

        if($entity instanceof Client){
          
            if($entity->getStatut() =="Physique"){
                $entity->setNomClient( $entity->getNom() . " " . $entity->getPrenom());
            }else{
                $entity->setNomClient( ' [' . $entity->getSigle() .'] '. $entity->getDenomination());
            }
            
        }

        if ($entity instanceof Utilisateur){
            
            if ($args->hasChangedField('profil')) {
                $roles = array();
                if([] != $entity->getProfil()){
                    foreach ($entity->getProfil() as $pro) {
                        $profil = $this->profilRepo->find($pro);
                        foreach ($profil->getRoles() as $role) {
                            $roles[] = $role; 
                        }
                    }
                    $entity->setRoles($roles);
                }
            }
        }
        
        // if($entity instanceof ProduitConditionnement){
            
        //     $produit    = $entity->getProduit();
        //     $mode       = $produit->getModeDefPrix();
        //     $groupeTaxe = $produit->getGroupeTaxe()->getCodeGr();
        //     switch ($groupeTaxe ){

        //         case 'B':
        //             if($mode == 1){
        //                 $entity->setPrixDeVenteHT( $entity->getPrixDeVente() / 1.18 );
        //                 $entity->setPrixDeVenteTTC( $entity->getPrixDeVente());
        //             }else{
        //                 $entity->setPrixDeVenteHT( $entity->getPrixDeVente());
        //                 $entity->setPrixDeVenteTTC( $entity->getPrixDeVente() * 1.18 );
        //             }
        //             break;
                
        //         case 'D':
        //             if($mode == 1){
        //                 $entity->setPrixDeVenteHT( $entity->getPrixDeVente() / 1.18 );
        //                 $entity->setPrixDeVenteTTC( $entity->getPrixDeVente());
        //             }else{
        //                 $entity->setPrixDeVenteHT( $entity->getPrixDeVente());
        //                 $entity->setPrixDeVenteTTC( $entity->getPrixDeVente() * 1.18 );
        //             }
        //             break;
                
        //         default:
        //             $entity->setPrixDeVenteHT($entity->getPrixDeVente());
        //             $entity->setPrixDeVenteTTC($entity->getPrixDeVente());
        //             break;
        //     }

        // }

    }


    public function postUpdate(LifecycleEventArgs $args): void
    {
        $entity = $args->getObject();
        $em = $args->getObjectManager();
        $em->flush();

        if($entity instanceof Societe){
            
            $societe = $em->getRepository(Societe::class)->findAll()[0];
            $soc = [
                'id' => $entity->getId(),
                'estRegimeTPS' => $entity->getEstRegimeTPS(),
                'estModeMecef'   => $societe->getEstModeMecef(),
                'nim'      => $societe->getApiNim(),
                'ifu'      => $societe->getIfu(),
                'host'      => $societe->getApiLink(),
                'messageCommercial' => $societe->getMessageCommercial(),
                'token'    =>  $societe->getApiToken()
            ];
            $this->session->set('societe', $soc);

        }

        if ($entity instanceof Profil){
            //get all users .. has this profil
            $utilisateurs = $this->utilisateurRepo->findUtilisateursHasProfil($entity->getId());
            
            if($utilisateurs != []){
                foreach ($utilisateurs as $user) {
                    if([] != $user->getProfil()){

                        foreach ($user->getProfil() as $pro) {
                            $profil = $this->profilRepo->find($pro);
                            foreach ($profil->getRoles() as $role) {
                                $roles[] = $role; 
                            }
                        }
                        $user->setRoles($roles);
                        $this->em->flush();
                    }
                }
            }
            
        }
        
    }

    public function preFlush(PreFlushEventArgs $args): void
    {
        $em = $args->getEntityManager();
    }

    public function onFlush(OnFlushEventArgs $args)
    {
        $em = $args->getEntityManager();
    }

    public function postFlush(PostFlushEventArgs $eventArgs)
    {
        
    }
}
