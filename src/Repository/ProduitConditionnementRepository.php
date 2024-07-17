<?php

namespace App\Repository;

use App\Entity\Magasin;
use App\Entity\ProduitConditionnement;
use App\Services\LibrairieService;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ProduitConditionnement>
 *
 * @method ProduitConditionnement|null find($id, $lockMode = null, $lockVersion = null)
 * @method ProduitConditionnement|null findOneBy(array $criteria, array $orderBy = null)
 * @method ProduitConditionnement[]    findAll()
 * @method ProduitConditionnement[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProduitConditionnementRepository extends ServiceEntityRepository
{
    private $librairieService;
    public function __construct(ManagerRegistry $registry, LibrairieService $lib)
    {
        $this->librairieService = $lib;
        parent::__construct($registry, ProduitConditionnement::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ProduitConditionnement $entity, bool $flush = true): void
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
    public function remove(ProduitConditionnement $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }
    public function counts()
    {
        $result = $this->createQueryBuilder('pc')->select("count(pc.id)");
         return   $result->getQuery()->getSingleScalarResult();
    }

    public function prodCondS($search,$point){
        $query = $this->createQueryBuilder('pc')
        ->InnerJoin('pc.produit', 'p')->InnerJoin("pc.conditionnement", 'c')->innerJoin('p.pointVente','pv');

        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point); 
        }
        if($search != null && $search  != ""){
            $query->andWhere('p.nomProd LIKE \'%'.$search.'%\''); 
        }
        return $query->getQuery()->getResult();
    }

    public function prodconditionnement($point,$start, $length, $orders, $search)
    {
        $query = $this->createQueryBuilder('pc')
        ->select("p.nomProd, pc.qteCond,pc.prixMin,pc.prixMax,pc.prixDeVente,c.libelleCond");
        // Create Count Query
        $countQuery = $this->createQueryBuilder('pc');
        $countQuery->select('COUNT(pc)');
        
        // Create inner joins
        $countQuery->InnerJoin('pc.produit', 'p')->InnerJoin("pc.conditionnement", 'c')->innerJoin('p.pointVente','pv');
        $query->InnerJoin('pc.produit', 'p')->InnerJoin("pc.conditionnement", 'c')->innerJoin('p.pointVente','pv');
        
         if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
    
        if($search != null){
             if (is_array($search))
                 $searchItem = trim($search["value"]);
             else
                $searchItem = trim($search);
    
            $searchQuery = "";
            if($searchItem != ""){
                $searchQuery .= 'p.nomProd LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'pc.qteCond LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'pc.prixMin LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'pc.prixMax LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'pc.prixDeVente LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'c.libelleCond LIKE \'%'.$searchItem.'%\'';
            }
             
           
             if($searchQuery !== null && $searchQuery != ""){
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
                         case 'nomProd':
                         {
                             $orderColumn = 'p.nomProd';
                             break;
                         }
                         
                         case 'libelleCond':
                         {
                             $orderColumn = 'c.libelleCond';
                             break;
                         }
                         case 'prixDeVente':
                         {
                            $orderColumn = "pc.prixDeVente";
                            break;
                         }
                         case 'prixMin':
                            {
                                $orderColumn = "pc.prixMin";
                                break;
                            }
                        case 'prixMax':
                        {
                            $orderColumn = "pc.prixMax";
                            break;
                        }
                        case 'qteCond':
                        {
                            $orderColumn = "pc.qteCond";
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
        //dd($query->getDQL());
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

    public function prodconditionnementImp($point,$search)
    {
        $query = $this->createQueryBuilder('pc')
        ->select("p.nomProd, pc.qteCond,pc.prixMin,pc.prixMax,pc.prixDeVente,c.libelleCond");
        // Create Count Query
        
        // Create inner joins
        $query->InnerJoin('pc.produit', 'p')->InnerJoin("pc.conditionnement", 'c')->innerJoin('p.pointVente','pv');
        
         if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
        }
    
        if($search != null){
            $searchItem = trim($search);
            $searchQuery = "";
            if($searchItem != ""){
                $searchQuery .= 'p.nomProd LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'pc.qteCond LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'pc.prixMin LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'pc.prixMax LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'pc.prixDeVente LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'c.libelleCond LIKE \'%'.$searchItem.'%\'';
            }
             
           
             if($searchQuery !== null && $searchQuery != ""){
                $query->andWhere($searchQuery);
             }
        }
       
        return $query->getQuery()->getResult();
    
    }
    

    // /**
    //  * @return ProduitConditionnement[] Returns an array of ProduitConditionnement objects
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
    public function findOneBySomeField($value): ?ProduitConditionnement
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
