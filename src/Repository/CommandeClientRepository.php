<?php

namespace App\Repository;

use App\Entity\CommandeClient;
use App\Services\LibrairieService;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<CommandeClient>
 *
 * @method CommandeClient|null find($id, $lockMode = null, $lockVersion = null)
 * @method CommandeClient|null findOneBy(array $criteria, array $orderBy = null)
 * @method CommandeClient[]    findAll()
 * @method CommandeClient[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CommandeClientRepository extends ServiceEntityRepository
{

    private $librairieService;
    public function __construct(ManagerRegistry $registry,LibrairieService $librairieService)
    {
        $this->librairieService=$librairieService;
        parent::__construct($registry, CommandeClient::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(CommandeClient $entity, bool $flush = true): void
    {
        $this->_em->persist($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function remove(CommandeClient $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function countCom(){
        $year = date("Y");
        $date1 = new DateTime("1st January  $year");
        $date2 = new DateTime("1st December  $year");
        $date1->modify("first day of this month");
        $date2->modify("last day of this month");
        $start = $date1->format("Y-m-d");
        $end = $date2->format("Y-m-d");
        return $this->createQueryBuilder('c')
            ->select('count(c.id)')
            ->andWhere('c.dateCom BETWEEN :start AND :end')
            ->setParameter('start', $start)
            ->setParameter('end', $end)
            ->getQuery()
            ->getSingleScalarResult();

   }


    public function counts()
    {
        $result = $this->createQueryBuilder('c')->select("count(c.id)");
         return   $result->getQuery()->getSingleScalarResult();
    }

   public function pointJounalierVentes($start,$point, $length, $orders, $search,$date1,$date2)
   {
       // Create Main Query
       $query = $this->createQueryBuilder('c')
       ->select("c.refCom,c.dateCom,
       CONCAT(CASE WHEN cc.nom IS NULL THEN '' ELSE cc.nom END,' ',CASE WHEN cc.prenom IS NULL THEN '' ELSE cc.prenom END,' ',CASE WHEN cc.denomination IS NULL THEN '' ELSE cc.denomination END) as client,
        c.montantHt,c.montantTtc,c.typeCommande,c.statut");

       // Create Count Query
       $countQuery = $this->createQueryBuilder('c');
       $countQuery->select('COUNT(c)');
       
       // Create inner joins
       $countQuery->leftJoin('c.acheteur', 'cc')->innerJoin("c.pointVente",'pv')->andWhere('c.deletedAt IS NULL');
       $query->leftJoin('c.acheteur', 'cc')->innerJoin("c.pointVente",'pv')->andWhere('c.deletedAt IS NULL');

       
       if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
        if ($date1) {
            $query->andWhere('c.dateCom >= :date1')
            ->setParameter('date1', $date1);
            $countQuery->andWhere('c.dateCom >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
            $query->andWhere('c.dateCom <= :date2')
            ->setParameter('date2', $date2);
            $countQuery->andWhere('c.dateCom <= :date2')
            ->setParameter('date2', $date2);
        }
       
        if($search != null && $search["value"] != ''){
            if (is_array($search))
                $searchItem = trim($search["value"]);
            else
                $searchItem = trim($search);
           $searchQuery = 'c.refCom LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'c.dateCom LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'cc.prenom LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'cc.nom LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'cc.raisonSociale LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'cc.sigle LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'c.montantHt LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'c.montantTtc LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'c.typeCommande LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'c.statut LIKE \'%'.$searchItem.'%\'';
          
           if($searchQuery !== null){
               $query->andWhere($searchQuery);
               $countQuery->andWhere($searchQuery);
           }
        }
        // Limit
        if ($start != '') {
            $query->setFirstResult($start)->setMaxResults($length);
        }
       
        // Order
        if ($orders!= null) {
            foreach($orders as $key => $order)
            {
                // $order['name'] is the name of the order column as sent by the JS
                if ($order['name'] != '')
                {
                    $orderColumn = null;
                
                    switch($order['name'])
                    {
                        case 'refCom':
                        {
                            $orderColumn = 'c.refCom';
                            break;
                        }
                        
                        case 'dateCom':
                        {
                            $orderColumn = 'c.dateCom';
                            break;
                        }
                        case 'client':
                        {
                            $orderColumn = "CONCAT(CASE WHEN cc.nom IS NULL THEN '' ELSE cc.nom END,' ',CASE WHEN cc.prenom IS NULL THEN '' ELSE cc.prenom END,' ',CASE WHEN cc.raisonSociale IS NULL THEN '' ELSE cc.raisonSociale END,' ',CASE WHEN cc.denomination IS NULL THEN '' ELSE cc.denomination END)";
                            break;
                        }
                        case 'montantTtc':
                        {
                            $orderColumn = 'c.montantTtc';
                            break;
                        }
                        case 'montantHt':
                        {
                            $orderColumn = 'c.montantHt';
                            break;
                        }
                        case 'typeCommande':
                        {
                            $orderColumn = 'c.typeCommande';
                            break;
                        }
                        case 'statut':
                        {
                            $orderColumn = 'c.statut';
                            break;
                        }
                        
                    }
            
                    if ($orderColumn !== null)
                    {
                        $query->orderBy($orderColumn, $order['dir']);
                    }
                }
            }
        }
       
       // Execute
       if ($search != null && $start != null && $length != null) {
           $results = $this->librairieService->reformats($query->getQuery()->getArrayResult());
       }else {
           $results = $query->getQuery()->getResult();
       }
      
       $countResult = $countQuery->getQuery()->getSingleScalarResult();
     //dd($results);
       return array(
           "results" 		=>$results ,
           "countResult"	=> $countResult
       );  
    } 

    

    public function pointJounalierVentesImp($search,$point,$date1,$date2)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('c')
        ->select("c.refCom,c.dateCom,
        CONCAT(CASE WHEN cc.nom IS NULL THEN '' ELSE cc.nom END,' ',CASE WHEN cc.prenom IS NULL THEN '' ELSE cc.prenom END,' ',CASE WHEN cc.denomination IS NULL THEN '' ELSE cc.denomination END) as client,
         c.montantHt,c.montantTtc,c.typeCommande,c.statut");

        $query->leftJoin('c.acheteur', 'cc')->innerJoin("c.pointVente","pv")->andWhere('c.deletedAt IS NULL');
        
        if ($date1) {
            $query->andWhere('c.dateCom >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
            $query->andWhere('c.dateCom <= :date2')
            ->setParameter('date2', $date2);
        }
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point); 
        }
        
         if($search != null && $search != ''){
            $searchItem = trim($search);
            $searchQuery = 'c.refCom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.dateCom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'cc.prenom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'cc.nom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'cc.raisonSociale LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'cc.sigle LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.montantHt LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.montantTtc LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.typeCommande LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.statut LIKE \'%'.$searchItem.'%\'';
           
            if($searchQuery !== null){
                $query->andWhere($searchQuery);
            }
         }
        return $query->getQuery()->getResult();
    } 
 

   
    public function pointCommandes($start,$point, $length, $orders, $search,$date1,$date2,$statut,$statutLiv,$type_commande)
    {
       // Create Main Query
       $query = $this->createQueryBuilder('c')
       ->select("c.refCom,c.dateCom,
       CONCAT(CASE WHEN cc.nom IS NULL THEN '' ELSE cc.nom END,' ',CASE WHEN cc.prenom IS NULL THEN '' ELSE cc.prenom END,' ',CASE WHEN cc.denomination IS NULL THEN '' ELSE cc.denomination END) as client,
        c.montantHt,c.montantTtc,c.typeCommande,c.statut,c.statutLiv");

       // Create Count Query
       $countQuery = $this->createQueryBuilder('c');
       $countQuery->select('COUNT(c)');
       
       // Create inner joins
       $countQuery->leftJoin('c.acheteur', 'cc')->innerJoin("c.pointVente","pv");
       $query->leftJoin('c.acheteur', 'cc')->innerJoin("c.pointVente","pv");
       
       if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
        if ($date1) {
            $query->andWhere('c.dateCom >= :date1')
            ->setParameter('date1', $date1);
            $countQuery->andWhere('c.dateCom >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
           $query->andWhere('c.dateCom <= :date2')
           ->setParameter('date2', $date2);
           $countQuery->andWhere('c.dateCom <= :date2')
           ->setParameter('date2', $date2);
        }

        if ($statutLiv){
            $query->andWhere('c.statutLiv = :statutLiv')
            ->setParameter('statutLiv', $statutLiv);
            $countQuery->andWhere('c.statutLiv = :statutLiv')
            ->setParameter('statutLiv', $statutLiv);
        }

        if($statut){
            $query->andWhere('c.statut = :statut')
            ->setParameter('statut', $statut);
            $countQuery->andWhere('c.statut = :statut')
            ->setParameter('statut', $statut);
        }
        if($type_commande){
            $query->andWhere('c.typeCommande = :type_commande')
            ->setParameter('type_commande', $type_commande);
            $countQuery->andWhere('c.typeCommande = :type_commande')
            ->setParameter('type_commande', $type_commande);
        }

       if($search != null){
            if (is_array($search))
                $searchItem = trim($search["value"]);
            else
             $searchItem = trim($search);

            $searchQuery = 'c.refCom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.dateCom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'cc.prenom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'cc.nom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'cc.raisonSociale LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'cc.sigle LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.montantHt LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.montantTtc LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.typeCommande LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.statut LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.statutLiv LIKE \'%'.$searchItem.'%\'';
          
            if($searchQuery !== null){
               $query->andWhere($searchQuery);
               $countQuery->andWhere($searchQuery);
            }
       }
       
       
       // Order
       if ($orders!= null) {
            foreach($orders as $key => $order)
            {
                // $order['name'] is the name of the order column as sent by the JS
                if ($order['name'] != '')
                {
                    $orderColumn = null;
                
                    switch($order['name'])
                    {
                        case 'refCom':
                        {
                            $orderColumn = 'c.refCom';
                            break;
                        }
                        
                        case 'dateCom':
                        {
                            $orderColumn = 'c.dateCom';
                            break;
                        }
                        case 'client':
                        {
                            $orderColumn = "CONCAT(CASE WHEN cc.nom IS NULL THEN '' ELSE cc.nom END,' ',CASE WHEN cc.prenom IS NULL THEN '' ELSE cc.prenom END,' ',CASE WHEN cc.raisonSociale IS NULL THEN '' ELSE cc.raisonSociale END,' ',CASE WHEN cc.denomination IS NULL THEN '' ELSE cc.denomination END)";
                            break;
                        }
                        case 'montantTtc':
                        {
                            $orderColumn = 'c.montantTtc';
                            break;
                        }

                        case 'montantHt':
                        {
                            $orderColumn = 'c.montantHt';
                            break;
                        }

                        case 'typeCommande':
                        {
                            $orderColumn = 'c.typeCommande';
                            break;
                        }

                        case 'statut':
                        {
                            $orderColumn = 'c.statut';
                            break;
                        }

                        case 'statutLiv':
                        {
                            $orderColumn = 'c.statutLiv';
                            break;
                        }
                        
                    }
            
                    if ($orderColumn !== null)
                    {
                        $query->orderBy($orderColumn, $order['dir']);
                    }
                }
            }
       }
       // Limit
       if ($start != '') {
            $query->setFirstResult((int)$start)->setMaxResults((int)$length);
        }
       // Execute
       if ($start != null && $length != null) {
           $results = $this->librairieService->reformats($query->getQuery()->getArrayResult());
       }else {
           $results = $query->getQuery()->getResult();
       }
      
       $countResult = $countQuery->getQuery()->getSingleScalarResult();
     //dd($results);
       return array(
           "results" 		=>$results ,
           "countResult"	=> $countResult
       );  

   } 


   public function pointCommandesImp($search,$point,$date1,$date2,$statut,$statutLiv,$type_commande)
   {
       // Create Main Query
       // dump($search,$date1,$date2,$statut,$statutLiv,$type_commande);
       $query = $this->createQueryBuilder('c')
       ->select("c.refCom,c.dateCom,
       CONCAT(CASE WHEN cc.nom IS NULL THEN '' ELSE cc.nom END,' ',CASE WHEN cc.prenom IS NULL THEN '' ELSE cc.prenom END,' ',CASE WHEN cc.denomination IS NULL THEN '' ELSE cc.denomination END) as client,
        c.montantHt,c.montantTtc,c.typeCommande,c.statut,c.statutLiv");
       $query->leftJoin('c.acheteur', 'cc')->innerJoin("c.pointVente","pv");
       //$query->innerJoin("c.typeCommande","ty");
       if($point){
        $query->andWhere('pv.id = :id')
        ->setParameter('id', $point);  
    }
        if ($date1 != "") {
            $query->andWhere('c.dateCom >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2 != ""){
           $query->andWhere('c.dateCom <= :date2')
           ->setParameter('date2', $date2);
        }

        if ($statutLiv != ""){
            $query->andWhere('c.statutLiv = :statutLiv')
            ->setParameter('statutLiv', $statutLiv);
        }

        if($statut != ""){
            $query->andWhere('c.statut = :statut')
            ->setParameter('statut', $statut);
        }

        if($type_commande != ""){
            $query->andWhere('c.typeCommande = :type_commande')
            ->setParameter('type_commande', $type_commande);
        }

       if($search != null){
             $searchItem = trim($search);

            $searchQuery = 'c.refCom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.dateCom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'cc.prenom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'cc.nom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'cc.raisonSociale LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'cc.sigle LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.montantHt LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.montantTtc LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.typeCommande LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.statut LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.statutLiv LIKE \'%'.$searchItem.'%\'';
          
            if($searchQuery !== null){
               $query->andWhere($searchQuery);
            }
       }
       // dd($query->getQuery()->getResult());
       return $query->getQuery()->getResult();

   } 

   public function pointImpayees($start,$point, $length, $orders, $search,$date1 = null, $date2 = null){

       // Create Main Query
       $query = $this->createQueryBuilder('c')
       ->select("c.refCom,c.dateCom,
       CONCAT(CASE WHEN cc.nom IS NULL THEN '' ELSE cc.nom END,' ',CASE WHEN cc.prenom IS NULL THEN '' ELSE cc.prenom END,' ',CASE WHEN cc.raisonSociale IS NULL THEN '' ELSE cc.raisonSociale END,' ',CASE WHEN cc.denomination IS NULL THEN '' ELSE cc.denomination END) as client,
        c.montantTtc,c.montantRest,c.typeCommande,c.statut");

       // Create Count Query
       $countQuery = $this->createQueryBuilder('c');
       $countQuery->select('COUNT(c)');
       
       // Create inner joins
       $countQuery->leftJoin('c.acheteur', 'cc')->innerJoin('c.pointVente','pv');
       $query->leftJoin('c.acheteur', 'cc')->innerJoin('c.pointVente','pv');

       if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
       
       if ($date1) {
           $query->andWhere('c.dateCom >= :date1')
           ->setParameter('date1', $date1);
           $countQuery->andWhere('c.dateCom >= :date1')
           ->setParameter('date1', $date1);
       }
       if ($date2){
           $query->andWhere('c.dateCom <= :date2')
           ->setParameter('date2', $date2);
           $countQuery->andWhere('c.dateCom <= :date2')
           ->setParameter('date2', $date2);
       }
       
       if($search != null && $search["value"] != ''){
           $searchItem = trim($search["value"]);
           $searchQuery = 'c.refCom LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'c.dateCom LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'cc.prenom LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'cc.nom LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'c.montantTtc LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'cc.raisonSociale LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'cc.sigle LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'c.montantRest LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'c.typeCommande LIKE \'%'.$searchItem.'%\' OR ';
           $searchQuery .= 'c.statut LIKE \'%'.$searchItem.'%\'';
          
           if($searchQuery !== null){
               $query->andWhere($searchQuery);
               $countQuery->andWhere($searchQuery);
           }
       }
       $query->andWhere("c.statut =:stat")->setParameter("stat","En attente");
       $countQuery->andWhere("c.statut =:stat")->setParameter("stat","En attente");
       
       // Limit
       if ($start) {
           $query->setFirstResult($start)->setMaxResults($length);
       }
       
       // Order
       if($orders!= null) {
            foreach($orders as $key => $order)
            {
                // $order['name'] is the name of the order column as sent by the JS
                if ($order['name'] != '')
                {
                    $orderColumn = null;
                
                    switch($order['name'])
                    {
                        case 'refCom':
                        {
                            $orderColumn = 'c.refCom';
                            break;
                        }
                        
                        case 'dateCom':
                        {
                            $orderColumn = 'c.dateCom';
                            break;
                        }

                        case 'client':
                        {
                            $orderColumn = "CONCAT(CASE WHEN cc.nom IS NULL THEN '' ELSE cc.nom END,' ',CASE WHEN cc.prenom IS NULL THEN '' ELSE cc.prenom END,' ',CASE WHEN cc.raisonSociale IS NULL THEN '' ELSE cc.raisonSociale END,' ',CASE WHEN cc.denomination IS NULL THEN '' ELSE cc.denomination END)";
                            break;
                        }

                        case 'montantRest':
                        {
                            $orderColumn = 'c.montantRest';
                            break;
                        }

                        case 'montantTtc':
                        {
                            $orderColumn = 'c.montantTtc';
                            break;
                        }

                        case 'typeCommande':
                        {
                            $orderColumn = 'c.typeCommande';
                            break;
                        }
                        
                    }
            
                    if ($orderColumn !== null)
                    {
                        $query->orderBy($orderColumn, $order['dir']);
                    }
                }
            }
       }
       
       // Execute
       if ($search != null && $start != null && $length != null) {
           $results = $this->$this->librairieService->reformats($query->getQuery()->getArrayResult());
       }else {
           $results = $query->getQuery()->getResult();
       }
      
       $countResult = $countQuery->getQuery()->getSingleScalarResult();
       //dd($results);
       return array(
           "results" 		=> $results ,
           "countResult"	=>  $countResult
       );  


   }

    // /**
    //  * @return CommandeClient[] Returns an array of CommandeClient objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('c')
            ->andWhere('c.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('c.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?CommandeClient
    {
        return $this->createQueryBuilder('c')
            ->andWhere('c.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
