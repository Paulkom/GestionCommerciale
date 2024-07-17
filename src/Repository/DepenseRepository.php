<?php

namespace App\Repository;

use App\Entity\Depense;
use App\Services\LibrairieService;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Depense>
 *
 * @method Depense|null find($id, $lockMode = null, $lockVersion = null)
 * @method Depense|null findOneBy(array $criteria, array $orderBy = null)
 * @method Depense[]    findAll()
 * @method Depense[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DepenseRepository extends ServiceEntityRepository
{
    private $librairieService;
    public function __construct(ManagerRegistry $registry, LibrairieService $lib)
    {
        $this->librairieService = $lib;
        parent::__construct($registry, Depense::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(Depense $entity, bool $flush = true): void
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
    public function remove(Depense $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function counts()
    {
        $result = $this->createQueryBuilder('d')->select("count(d.id)");
         return   $result->getQuery()->getSingleScalarResult();
    }


    public function pointDepense($start,$point, $length, $orders, $search,$date1,$date2)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('d')
        ->select("d.dateDep , t.libelle as type, d.beneficiere, d.montant ")->innerJoin('d.typeDepense', 't');

        // Create Count Query
        $countQuery = $this->createQueryBuilder('d');
        $countQuery->select('COUNT(d)');
        
        // Create inner joins
        $countQuery->innerJoin("d.pointVente","pv");
        
        $query->innerJoin("d.pointVente","pv");
        
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
        if ($date1) {
            $query->andWhere('d.createdAt >= :date1')
            ->setParameter('date1', $date1);
            $countQuery->andWhere('d.createdAt >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
            $query->andWhere('d.createdAt <= :date2')
            ->setParameter('date2', $date2);
            $countQuery->andWhere('d.createdAt <= :date2')
            ->setParameter('date2', $date2);
        }
        
        if($search != null && $search["value"] != ''){
            $searchItem = trim($search["value"]);
            $searchQuery = 't.libelle LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'd.dateDep LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= ' d.montant LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'd.beneficiere LIKE \'%'.$searchItem.'%\'';
           
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
                        case 'type':
                        {
                            $orderColumn = 't.libelle';
                            break;
                        }
                        case 'dateDep':
                        {
                            $orderColumn = 'd.dateDep';
                            break;
                        }
                        case 'montant':
                        {
                            $orderColumn = 'd.montant';
                            break;
                        }
                        case 'beneficiere':
                        {
                            $orderColumn = "d.beneficiere";
                            break;
                        }
                        case 'montantTotal':
                        {
                            $orderColumn = 'f.montantTotal';
                            break;
                        }
                        case 'montantRAPayer':
                        {
                            $orderColumn = 'd.montantRAPayer';
                            break;
                        }
                        case 'libelle':
                        {
                            $orderColumn = 'm.libelle';
                            break;
                        }
                        case 'montantPaye':
                        {
                            $orderColumn = 'd.montantPaye';
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

    public function pointDepenseImp($point, $search,$date1,$date2)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('d')
        ->select("d.dateDep , t.libelle as type, d.beneficiere, d.montant ")->innerJoin('d.typeDepense', 't');
        
        // Create inner joins
        
        $query->innerJoin("d.pointVente","pv");
        
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point); 
        }
        if ($date1) {
            $query->andWhere('d.createdAt >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
            $query->andWhere('d.createdAt <= :date2')
            ->setParameter('date2', $date2);
        }
        
        if($search != null && $search["value"] != ''){
            $searchItem = trim($search["value"]);
            $searchQuery = 't.libelle LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'd.dateDep LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= ' d.montant LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'd.beneficiere LIKE \'%'.$searchItem.'%\'';
           
            if($searchQuery !== null){
                $query->andWhere($searchQuery);
            }
        }
        return $query->getQuery()->getResult(); ;  

    }

    public function pointTotalDepensePeriodique($date1, $date2,$point){
        $que =  $this->createQueryBuilder('d')
        ->select("SUM(d.montant)")
        ->innerJoin("d.pointVente", "pv")
        ->andWhere("d.deletedAt IS NULL");
        
        if ($date1) {
            $que->andWhere('d.dateDep >= :date1')
            ->setParameter('date1', $date1);
        }
        
        if ($date2){
            $que->andWhere('d.dateDep <= :date2')
            ->setParameter('date2', $date2);
        }
        if($point){
            $que->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
        return $que->getQuery()->getSingleScalarResult();
    }

    // /**
    //  * @return Depense[] Returns an array of Depense objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('d')
            ->andWhere('d.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('d.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?Depense
    {
        return $this->createQueryBuilder('d')
            ->andWhere('d.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */

    public function getDepense($caisse)
    {
        return $this->createQueryBuilder('d')
            ->select('sum(d.montant) as totaldepense')
            ->andWhere('d.caisse = :val')
            ->setParameter('val', $caisse->getId())
            ->getQuery()
            ->getOneOrNullResult();
    }
}
