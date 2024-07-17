<?php

namespace App\Repository;

use App\Entity\Caisse;
use App\Entity\Paiement;
use App\Services\LibrairieService;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Paiement>
 *
 * @method Paiement|null find($id, $lockMode = null, $lockVersion = null)
 * @method Paiement|null findOneBy(array $criteria, array $orderBy = null)
 * @method Paiement[]    findAll()
 * @method Paiement[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PaiementRepository extends ServiceEntityRepository
{
    private $librairieService;
    public function __construct(ManagerRegistry $registry, LibrairieService $lib)
    {
        $this->librairieService = $lib;
        parent::__construct($registry, Paiement::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(Paiement $entity, bool $flush = true): void
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
    public function remove(Paiement $entity, bool $flush = true): void
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
        return $this->createQueryBuilder('p')
            ->select('count(p.id)')
            ->andWhere('p.datePaie BETWEEN :start AND :end')
            ->setParameter('start', $start)
            ->setParameter('end', $end)
            ->getQuery()
            ->getSingleScalarResult();

   }

    public function counts()
    {
        $result = $this->createQueryBuilder('p')->select("count(p.id)");
         return   $result->getQuery()->getSingleScalarResult();
    }
    public function clientImp($point, $recherche,$date1, $date2,$client){
        //dd($search);
        $query = $this->createQueryBuilder('p')
        ->select("cl.id, cl.telephone1, cl.ifu, cl.statut, (CASE WHEN cl.statut = 'Physique' THEN (CONCAT(cl.nom, ' ', cl.prenom )) ELSE cl.denomination END) as client, SUM(p.montantPaye) as CA");

       $query->InnerJoin('p.facture', 'f')->innerJoin('f.commandeCli','cmd')->innerJoin('cmd.acheteur','cl')->innerJoin('cmd.pointVente','pv');
        
         if ($date1) {
             $query->andWhere('cmd.dateCom >= :date1')
             ->setParameter('date1', $date1);
         }
         if($point){
            $query->andWhere('pv.id >= :id')
            ->setParameter('id', $point);
        }

         if ($date2){
            $query->andWhere('cmd.dateCom <= :date2')
            ->setParameter('date2', $date2);
         }

         if ($client != ""){
            $query->andWhere('cl.id = :client')
            ->setParameter('client', $client);
         }
        if($recherche != null){
            
            $eleRechercher = trim($recherche);
                
    
            $sousReq = "";
            if($eleRechercher != ""){
                $sousReq .= "cmd.dateCom LIKE '%".$eleRechercher."%' OR ";
                $sousReq .= "cl.ifu LIKE '%".$eleRechercher."%' OR ";
                $sousReq .= "cl.statut LIKE '%".$eleRechercher."%' OR ";
                $sousReq .= "cl.telephone1 LIKE '%".$eleRechercher."%' OR ";
                $sousReq .= "cl.nom LIKE '%".$eleRechercher."%' OR ";
                $sousReq .= "cl.prenom LIKE '%".$eleRechercher."%' OR ";
                $sousReq .= "cl.denomination LIKE '%".$eleRechercher."%'";
            }
             
            if($sousReq != ""){
                $query->andWhere($sousReq);
            }
        }
        $query->groupBy('cl.id');
        return $query->orderBy("client","ASC")->getQuery()->getResult();
    }

    public function client($point,$start, $length, $orders, $search,$date1, $date2,$client){
        //dd($search);
        $query = $this->createQueryBuilder('p')
        ->select("cl.id, cl.telephone1, cl.ifu, cl.statut, (CASE WHEN cl.statut = 'Physique' THEN (CONCAT(cl.nom, ' ', cl.prenom )) ELSE cl.denomination END) as client, SUM(p.montantPaye) as CA");
        // Create Count Query
        $countQuery = $this->createQueryBuilder('p');
        $countQuery->select('COUNT(p)');

        // Create inner joins
        $countQuery->InnerJoin('p.facture', 'f')->innerJoin('f.commandeCli','cmd')->innerJoin('cmd.acheteur','cl')->innerJoin('cmd.pointVente','pv');
        $query->InnerJoin('p.facture', 'f')->innerJoin('f.commandeCli','cmd')->innerJoin('cmd.acheteur','cl')->innerJoin('cmd.pointVente','pv');
        
         if ($date1) {
             $query->andWhere('cmd.dateCom >= :date1')
             ->setParameter('date1', $date1);
             $countQuery->andWhere('cmd.dateCom >= :date1')
             ->setParameter('date1', $date1);
         }
         if($point){
            $query->andWhere('pv.id >= :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id >= :id')
            ->setParameter('id', $point);  
        }

         if ($date2){
            $query->andWhere('cmd.dateCom <= :date2')
            ->setParameter('date2', $date2);
            $countQuery->andWhere('cmd.dateCom <= :date2')
            ->setParameter('date2', $date2);
         }

         if ($client != ""){
            $query->andWhere('cl.id = :client')
            ->setParameter('client', $client);
            $countQuery->andWhere('cl.id = :client')
            ->setParameter('client', $client);
         }
    
        if($search != null){
            $searchItem ="";
             if (is_array($search)){
                $searchItem = trim($search["value"]);
             }else{
                $searchItem = trim($search);
             }
                
    
            $searchQuery = "";
            if($searchItem != ""){
                $searchQuery .= "cmd.dateCom LIKE '%".$searchItem."%' OR ";
                $searchQuery .= "cl.ifu LIKE '%".$searchItem."%' OR ";
                $searchQuery .= "cl.statut LIKE '%".$searchItem."%' OR ";
                $searchQuery .= "cl.telephone1 LIKE '%".$searchItem."%' OR ";
                $searchQuery .= "cl.nom LIKE '%".$searchItem."%' OR ";
                $searchQuery .= "cl.prenom LIKE '%".$searchItem."%' OR ";
                $searchQuery .= "cl.denomination LIKE '%".$searchItem."%'";
            }
             
            if($searchQuery != ""){
                $query->andWhere($searchQuery);
                $countQuery->andWhere($searchQuery);
            }

          //  dd($searchQuery);
        }

        if ($orders != null) {
            foreach($orders as $key => $order)
            {
                if ($order['name'] != '')
                {
                    $orderColumn = null;

                    switch($order['name'])
                    {
                        case 'ifu':
                        {
                            $orderColumn = 'cl.ifu';
                            break;
                        }
                            
                        case 'date':
                        {
                            $orderColumn = 'cmd.dateCom';
                            break;
                        }
                        case 'client':
                        {
                            $orderColumn = "cl.nom";
                            break;
                        }
                        case 'statut':
                        {
                            $orderColumn = "cl.statut";
                            break;
                        }
                        case 'telephone1':
                        {
                            $orderColumn = "cl.telephone1";
                            break;
                        }
                        case 'CA':
                        {
                            $orderColumn = "CA";
                            break;
                        }
                    }
                
                    if ($orderColumn !== null)
                    {
                        $query->orderBy($orderColumn, $order['dir']);
                    }
                }
            }

           // dd("OK");
        }
        
        
        if ($start != '') {
            $query->setFirstResult((int)$start)->setMaxResults((int)$length);
        }

        $query->groupBy('cl.id');

        //dd($query->getDQL());
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

    public function activiteClient($point,$start, $length, $orders, $search,$date1, $date2,$client){
        $query = $this->createQueryBuilder('p')
        ->select("cmd.refCom, f.refFac, (CASE WHEN cl.statut = 'Physique' THEN CONCAT(cl.nom, ' ', cl.prenom ) ELSE cl.denomination END) as client, cmd.montantTtc, p.datePaie, p.montantPaye");
        // Create Count Query
        $countQuery = $this->createQueryBuilder("p");
        $countQuery->select("COUNT(p)");
        
        // Create inner joins
        $countQuery->InnerJoin('p.facture', 'f')->join('f.commandeCli','cmd')->innerJoin('cmd.acheteur','cl')->innerJoin('cmd.pointVente','pv');
        $query->InnerJoin('p.facture', 'f')->join('f.commandeCli','cmd')->innerJoin('cmd.acheteur','cl')->innerJoin('cmd.pointVente','pv');
        
        if($point){
            $query->andWhere('pv.id >= :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id >= :id')
            ->setParameter('id', $point);  
        }
        if ($date1) {
            $query->andWhere('cmd.dateCom >= :date1')
            ->setParameter('date1', $date1);
            $countQuery->andWhere('cmd.dateCom >= :date1')
            ->setParameter('date1', $date1);
        }

        if ($date2){
        $query->andWhere('cmd.dateCom <= :date2')
        ->setParameter('date2', $date2);
        $countQuery->andWhere('cmd.dateCom <= :date2')
        ->setParameter('date2', $date2);
        }

        if ($client != ""){
        $query->andWhere('cl.id = :client')
        ->setParameter('client', $client);
        $countQuery->andWhere('cl.id = :client')
        ->setParameter('client', $client);
        }

        if($search != null){
            if (is_array($search))
                $searchItem = trim($search["value"]);
            else
                $searchItem = trim($search);
    
            $searchQuery = "";
            if($searchItem != ""){
                $searchQuery .= "p.datePaie LIKE '%".$searchItem."%' OR ";
                $searchQuery .= "cmd.refCom LIKE '%".$searchItem."%' OR ";
                $searchQuery .= "f.refFac LIKE '%".$searchItem."%' OR ";
                $searchQuery .= "cl.nom LIKE '%".$searchItem."%' OR ";
                $searchQuery .= "cl.prenom LIKE '%".$searchItem."%' OR ";
                $searchQuery .= "cl.denomination LIKE '%".$searchItem."%' OR ";
                $searchQuery .= "p.montantPaye LIKE '%".$searchItem."%'";
            }
             
            if($searchQuery !== null && $searchQuery != ""){
            $query->andWhere($searchQuery);
            $countQuery->andWhere($searchQuery);
            }
        }
        // $query->groupBy('cl');
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
                             $orderColumn = 'cmd.refCom';
                             break;
                         }
                         
                         case 'date':
                         {
                             $orderColumn = 'cmd.dateCom';
                             break;
                         }
                         case 'client':
                         {
                            $orderColumn = "cl.nom";
                            break;
                         }
                         case 'refFac':
                        {
                            $orderColumn = "p.id";
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
        
        if ($start != '') {
            $query->setFirstResult((int)$start)->setMaxResults((int)$length);
        }
        if ($start != null && $length != null) {
            $results = $this->librairieService->reformats($query->getQuery()->getArrayResult());
        }else {
            $results = $query->getQuery()->getResult();
        }
        
        $countResult = $countQuery->getQuery()->getSingleScalarResult();
        return array(
            "results" 		=>$results ,
            "countResult"	=> $countResult
        );
    
    }

    public function activiteClientImp($point,$date1,$recherche, $date2,$client){
        $query = $this->createQueryBuilder('p')
        ->select("cmd.refCom, f.refFac, (CASE WHEN cl.statut = 'Physique' THEN CONCAT(cl.nom, ' ', cl.prenom ) ELSE cl.denomination END) as client, cmd.montantTtc, p.datePaie, p.montantPaye");
       $query->InnerJoin('p.facture', 'f')->innerJoin('f.commandeCli','cmd')->innerJoin('cmd.acheteur','cl')->innerJoin('cmd.pointVente','pv');
        
        if($point){
            $query->andWhere('pv.id >= :id')
            ->setParameter('id', $point);
        }
        if ($date1) {
            $query->andWhere('cmd.dateCom >= :date1')
            ->setParameter('date1', $date1);
        }

        if ($date2){
        $query->andWhere('cmd.dateCom <= :date2')
        ->setParameter('date2', $date2);
        }

        if ($client != ""){
        $query->andWhere('cl.id = :client')
        ->setParameter('client', $client);
        };

        if($recherche != null){
            $valChercher = trim($recherche);
            $sousReq = "";
            if($valChercher != ""){
                $sousReq .= "p.datePaie LIKE '%".$valChercher."%' OR ";
                $sousReq .= "cmd.refCom LIKE '%".$valChercher."%' OR ";
                $sousReq .= "f.refFac LIKE '%".$valChercher."%' OR ";
                $sousReq .= "cl.nom LIKE '%".$valChercher."%' OR ";
                $sousReq .= "cl.prenom LIKE '%".$valChercher."%' OR ";
                $sousReq .= "cl.denomination LIKE '%".$valChercher."%' OR ";
                $sousReq .= "p.montantPaye LIKE '%".$valChercher."%'";
            }
             
            if($sousReq !== null && $sousReq != ""){
                $query->andWhere($sousReq);
            }
        }
        return $query->orderBy("client",'ASC')->getQuery()->getResult();
    
    }

    public function totalEncaissementAnterieur($point,$date1,$date2){
        $query = $this->createQueryBuilder('p')
        ->select("SUM(p.montantPaye)")
        ->innerJoin("p.pointVente","pv")
        ->innerJoin('p.facture', 'f')
        ->innerJoin('f.commandeCli', 'cmd');
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
        if ($date1) {
            $query->andWhere('p.datePaie >= :date1')
            ->setParameter('date1', $date1)
            ->andWhere('cmd.dateCom < :date')
            ->setParameter('date', $date1);
        }
        if ($date2){
            $query->andWhere('p.datePaie <= :date2')
            ->setParameter('date2', $date2);
        }
        return $query->getQuery()->getSingleScalarResult();
    }

    public function pointEncaissement($start,$point, $length, $orders, $search,$date1,$date2)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('p')
        ->select("p.refPaie,cc.refCom,p.datePaie,cc.dateCom,
        CONCAT(CASE WHEN c.nom IS NULL THEN '' ELSE c.nom END,' ',CASE WHEN c.prenom IS NULL THEN '' ELSE c.prenom END,' ',CASE WHEN c.denomination IS NULL THEN '' ELSE c.denomination END) as client,
         f.montantTotal,p.montantPaye,p.montantRAPayer, (p.montantPaye + p.montantRAPayer) as total,m.libelle");

        // Create Count Query
        $countQuery = $this->createQueryBuilder('p');
        $countQuery->select('COUNT(p)');
        
        // Create inner joins
        $countQuery->leftJoin('p.facture', 'f')
        ->innerJoin("p.pointVente","pv");
        $countQuery->leftJoin('p.modePaiement', 'm');
        $countQuery->leftJoin('f.commandeCli', 'cc');
        $countQuery->leftJoin('cc.acheteur', 'c')->andWhere("p.estSup IS NULL");
        
        $query->leftJoin('p.facture', 'f')
        ->innerJoin("p.pointVente","pv");
        $query->leftJoin('p.modePaiement', 'm');
        $query->leftJoin('f.commandeCli', 'cc');
        $query->leftJoin('cc.acheteur', 'c')->andWhere("p.estSup IS NULL");
        
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
        if ($date1) {
            $query->andWhere('p.createdAt >= :date1')
            ->setParameter('date1', $date1);
            $countQuery->andWhere('p.createdAt >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
            $query->andWhere('p.createdAt <= :date2')
            ->setParameter('date2', $date2);
            $countQuery->andWhere('p.createdAt <= :date2')
            ->setParameter('date2', $date2);
        }
        
        if($search != null && $search["value"] != ''){
            $searchItem = trim($search["value"]);
            $searchQuery = 'p.refPaie LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'f.refFac LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.createdAt LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.prenom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.nom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.denomination LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.sigle LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.montantPaye LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'f.montantTotal LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.montantRAPayer LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'm.libelle LIKE \'%'.$searchItem.'%\'';
           
            if($searchQuery !== null){
                $query->andWhere($searchQuery);
                $countQuery->andWhere($searchQuery);
            }
        }

        // Limit

        if ($start) {
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
                        case 'refPaie':
                        {
                            $orderColumn = 'p.refPaie';
                            break;
                        }
                        case 'refFac':
                        {
                            $orderColumn = 'f.refFac';
                            break;
                        }
                        case 'datePaie':
                        {
                            $orderColumn = 'p.datePaie';
                            break;
                        }
                        case 'client':
                        {
                            $orderColumn = "CONCAT(c.nom,' ',c.prenom, ' ',c.denomination)";
                            break;
                        }
                        case 'montantTotal':
                        {
                            $orderColumn = 'f.montantTotal';
                            break;
                        }
                        case 'montantRAPayer':
                        {
                            $orderColumn = 'p.montantRAPayer';
                            break;
                        }
                        case 'libelle':
                        {
                            $orderColumn = 'm.libelle';
                            break;
                        }
                        case 'montantPaye':
                        {
                            $orderColumn = 'p.montantPaye';
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
        if ($search != null && $start != null) {
            $results = $this->librairieService->reformats($query->getQuery()->getArrayResult());
            //dd($results);
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

    public function pointEncaissementImp($search,$point,$date1,$date2)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('p')
        ->select("p.refPaie,f.refFac,p.datePaie,cc.refCom, cc.dateCom,
        CONCAT(CASE WHEN c.nom IS NULL THEN '' ELSE c.nom END,' ',CASE WHEN c.prenom IS NULL THEN '' ELSE c.prenom END,' ',CASE WHEN c.denomination IS NULL THEN '' ELSE c.denomination END) as client,
         f.montantTotal,p.montantPaye,p.montantRAPayer, (p.montantPaye + p.montantRAPayer) as total,  m.libelle");

        $query->leftJoin('p.facture', 'f');
        $query->leftJoin('p.modePaiement', 'm');
        $query->leftJoin('f.commandeCli', 'cc');
        $query->leftJoin('cc.acheteur', 'c')->innerJoin("p.pointVente","pv")->andWhere("p.estSup IS NULL");
        
        if ($date1) {
            $query->andWhere('p.createdAt >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
            $query->andWhere('p.createdAt <= :date2')
            ->setParameter('date2', $date2);
        }
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point); 
        }
        
        if($search != null && $search != ''){
            $searchItem = trim($search);
            $searchQuery = 'p.refPaie LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'f.refFac LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.createdAt LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.prenom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.nom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.raisonSociale LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'c.sigle LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.montantPaye LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'f.montantTotal LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.montantRAPayer LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'm.libelle LIKE \'%'.$searchItem.'%\'';
           
            if($searchQuery !== null){
                $query->andWhere($searchQuery);
            }
        }
        return $query->getQuery()->getResult();

    }

    public function reformat($data): array
    {
        return array_map(function ($item) {
            $keys = array_keys($item);
            foreach ($keys as $key) {
                if ($item[$key] instanceof \DateTime)
                    $item[$key] = $item[$key]->format('d/m/Y à H:i');
            }

            return $item;
        }, $data);
    }


    // /**
    //  * @return Paiement[] Returns an array of Paiement objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('p.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?Paiement
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */

    public function getChifreAffaire($caisse)
    {
        return $this->createQueryBuilder('p')
            ->select('sum(p.montantPaye) as totalpaiement')
            ->andWhere('p.caisse = :val')
            ->setParameter('val', $caisse->getId())
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
}
