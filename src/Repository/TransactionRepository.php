<?php

namespace App\Repository;

use App\Entity\Caisse;
use App\Entity\Transaction;
use App\Services\LibrairieService;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Transaction>
 *
 * @method Transaction|null find($id, $lockMode = null, $lockVersion = null)
 * @method Transaction|null findOneBy(array $criteria, array $orderBy = null)
 * @method Transaction[]    findAll()
 * @method Transaction[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class TransactionRepository extends ServiceEntityRepository
{
    private $librairieService;
    public function __construct(ManagerRegistry $registry, LibrairieService $lib)
    {
        parent::__construct($registry, Transaction::class);
        $this->librairieService = $lib;
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(Transaction $entity, bool $flush = true): void
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
    public function remove(Transaction $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function counts()
    {
        $result = $this->createQueryBuilder('t')->select("count(t.id)");
         return   $result->getQuery()->getSingleScalarResult();
    }

    public function operation($point,$start, $length, $orders, $search,$date1, $date2,$client){
        $query = $this->createQueryBuilder('t')
        ->select("ty.libelle as typeOperation,cl.statut,co.intitule as compte, mo.libelle as modePaiement, t.montantTransac, t.dateTransac as date, (CASE WHEN cl.statut = 'Physique' THEN (CONCAT(cl.nom, ' ', cl.prenom )) ELSE cl.denomination END) as client ");
        // Create Count Query
        $countQuery = $this->createQueryBuilder('t');
        $countQuery->select('COUNT(t)');

        $countQuery->InnerJoin('t.client', 'cl')->innerJoin('t.typeOperation','ty')->innerJoin('t.modePaiement','mo')->leftJoin('t.compte','co')->innerJoin('t.pointVente','pv');
        $query->InnerJoin('t.client', 'cl')->innerJoin('t.typeOperation','ty')->innerJoin('t.modePaiement','mo')->leftJoin('t.compte','co')->innerJoin('t.pointVente','pv');

        
        if ($date1) {
            $query->andWhere('t.dateTransac >= :date1')
            ->setParameter('date1', $date1);
            $countQuery->andWhere('t.dateTransac >= :date1')
            ->setParameter('date1', $date1);
        }

        if($point){
            $query->andWhere('pv.id >= :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id >= :id')
            ->setParameter('id', $point);  
        }

        if ($date2){
           $query->andWhere('t.dateTransac <= :date2')
           ->setParameter('date2', $date2);
           $countQuery->andWhere('t.dateTransac <= :date2')
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
               $searchQuery .= "t.dateTransac LIKE '%".$searchItem."%' OR ";
               $searchQuery .= "cl.statut LIKE '%".$searchItem."%' OR ";
               $searchQuery .= "cl.telephone1 LIKE '%".$searchItem."%' OR ";
               $searchQuery .= "cl.nom LIKE '%".$searchItem."%' OR ";
               $searchQuery .= "cl.prenom LIKE '%".$searchItem."%' OR ";
               $searchQuery .= "cl.denomination LIKE '%".$searchItem."%' OR ";
               $searchQuery .= "ty.libelle LIKE '%".$searchItem."%' OR ";
               $searchQuery .= "co.intitule LIKE '%".$searchItem."%' OR ";
               $searchQuery .= "mo.libelle LIKE '%".$searchItem."%' OR ";
               $searchQuery .= "t.montantTransac LIKE '%".$searchItem."%' ";

           }
            
           if($searchQuery != ""){
               $query->andWhere($searchQuery);
               $countQuery->andWhere($searchQuery);
           }

       }

       if ($orders != null) {
        //dump($orders);
        foreach($orders as $key => $order)
        {
            if ($order['name'] != '')
            {
                $orderColumn = null;

                switch($order['name'])
                {
                    case 'modePaiement':
                    {
                        $orderColumn = 'mo.libelle';
                        break;
                    }
                        
                    case 'date':
                    {
                        $orderColumn = 't.dateTransac';
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
                    case 'compte':
                    {
                        $orderColumn = "co.intitule";
                        break;
                    }
                    case 'typeOperation':
                    {
                        $orderColumn = "ty.libelle";
                        break;
                    }
                    case 'montantTransac':
                    {
                        $orderColumn = "t.montantTransac";
                        break;
                    }
                }
            
                //dump($orderColumn, $order['dir']);
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

    // /**
    //  * @return Transaction[] Returns an array of Transaction objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('t')
            ->andWhere('t.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('t.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?Transaction
    {
        return $this->createQueryBuilder('t')
            ->andWhere('t.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
    public function operationImpr($point,$recherche,$date1, $date2,$client){
        $query = $this->createQueryBuilder('t')
        ->select("ty.libelle as typeOperation,cl.statut,co.intitule as compte, mo.libelle as modePaiement, t.montantTransac, t.dateTransac as date, (CASE WHEN cl.statut = 'Physique' THEN (CONCAT(cl.nom, ' ', cl.prenom )) ELSE cl.denomination END) as client ");

       $query->InnerJoin('t.client', 'cl')->innerJoin('t.typeOperation','ty')->innerJoin('t.modePaiement','mo')->leftJoin('t.compte','co')->innerJoin('t.pointVente','pv');

        
        if ($date1) {
            $query->andWhere('t.dateTransac >= :date1')
            ->setParameter('date1', $date1);
        }

        if($point){
            $query->andWhere('pv.id >= :id')
            ->setParameter('id', $point); 
        }

        if ($date2){
           $query->andWhere('t.dateTransac <= :date2')
           ->setParameter('date2', $date2);
        }

        if ($client != ""){
           $query->andWhere('cl.id = :client')
           ->setParameter('client', $client);
        }
   
       if($recherche != null){
            $valRecherche = trim($recherche);
               
   
           $sousReq = "";
           if($valRecherche != ""){
               $sousReq .= "t.dateTransac LIKE '%".$valRecherche."%' OR ";
               $sousReq .= "cl.statut LIKE '%".$valRecherche."%' OR ";
               $sousReq .= "cl.telephone1 LIKE '%".$valRecherche."%' OR ";
               $sousReq .= "cl.nom LIKE '%".$valRecherche."%' OR ";
               $sousReq .= "cl.prenom LIKE '%".$valRecherche."%' OR ";
               $sousReq .= "cl.denomination LIKE '%".$valRecherche."%' OR ";
               $sousReq .= "ty.libelle LIKE '%".$valRecherche."%' OR ";
               $sousReq .= "co.intitule LIKE '%".$valRecherche."%' OR ";
               $sousReq .= "mo.libelle LIKE '%".$valRecherche."%' OR ";
               $sousReq .= "t.montantTransac LIKE '%".$valRecherche."%' ";
           }
            
           if($sousReq !== null && $sousReq != ""){
               $query->andWhere($sousReq);
           }
       }
        return $query->getQuery()->getResult();
    }

    public function getTrans(Caisse $caisse)
    {
        return $this->createQueryBuilder('t')
            ->leftJoin('t.typeOperation','to')
            ->select('sum(t.montantTransac) as totaldepot')
            ->andWhere('to.libelle = :libelle')
            ->andWhere('t.caisse = :val')
            ->setParameter('val', $caisse->getId())
            ->setParameter('libelle', 'Dépôt')
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
}
