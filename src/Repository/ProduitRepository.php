<?php

namespace App\Repository;

use App\Entity\Produit;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Produit>
 *
 * @method Produit|null find($id, $lockMode = null, $lockVersion = null)
 * @method Produit|null findOneBy(array $criteria, array $orderBy = null)
 * @method Produit[]    findAll()
 * @method Produit[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProduitRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Produit::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(Produit $entity, bool $flush = true): void
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
    public function remove(Produit $entity, bool $flush = true): void
    {
        $this->deletedAt = new \DateTime();
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    /**
     * @param $prefix
     * @return float|int|mixed|string
     * @throws \Doctrine\ORM\NoResultException
     * @throws \Doctrine\ORM\NonUniqueResultException
     */
    // public function nbProdParFamille($prefix)
    // {
    //     return  $this->createQueryBuilder('p')
    //         ->select('COUNT(p.id)')
    //         ->innerJoin('p.famille', 'f')
    //         ->where('f.codeFamille LIKE \'%' . $prefix . '%\'')
    //         ->orderBy('p.id', 'DESC')
    //         ->getQuery()
    //         ->getSingleScalarResult()
    //     ;
    // }

    public function lastProdParFamille($prefix)
    {
        return   $this->createQueryBuilder('p')
            ->select('p.codeProduit')
            ->where('p.codeProduit LIKE \'%' . $prefix . '%\'')
            ->orderBy('p.id', 'DESC')
            ->getQuery()
            ->setMaxResults(1)
            ->getResult()
            // ->getSingleScalarResult()
        ;
    }

    public function produits($point){
        return $this->createQueryBuilder('p')
            ->innerJoin('p.pointVente','pv')
            ->andWhere('pv = :id')
            ->setParameter('id', $point)
            ->andWhere('p.estSup IS NULL OR p.estSup = 0')
            ->orderBy('p.nomProd', 'ASC')
            ->getQuery()
            ->getResult()
        ;
    }

    /*
    public function findOneBySomeField($value): ?Produit
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */

    public function counts($etat)
    {
        $result = $this->createQueryBuilder('p')
            ->select("count(p.id)");
            if ($etat==0) {
                $result ->where('p.stock = :val');
            }else {
                $result ->where('p.stock > :val');
            }
         return   $result->setParameter('val', 0)->getQuery()->getSingleScalarResult();
    }


    public function proddispos($start,$point, $length, $orders, $search,$type)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('p')
        ->select('p.codeProduit,p.nomProd,f.libelleFamille,p.stock');

        // Create Count Query
        $countQuery = $this->createQueryBuilder('p');
        $countQuery->select('COUNT(p)');
        
        // Create inner joins
        $query->leftJoin('p.famille', 'f')->innerJoin('p.pointVente',"pv");
        $countQuery->leftJoin('p.famille', 'f')->innerJoin('p.pointVente',"pv");

        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
        if ($type == 0) {
            $countQuery->andWhere('p.stock = 0');
            $query->andWhere('p.stock = 0');
            $query->andWhere('p.estService != 1');
            $query->andWhere('p.deletedAt is NULL');
            $countQuery->andWhere('p.estService != 1');
            $countQuery->andWhere('p.deletedAt is NULL');
        }else {
            $countQuery->andWhere('p.stock > 0');
            $query->andWhere('p.stock > 0');
            $query->andWhere('p.deletedAt is NULL');
            $countQuery->andWhere('p.deletedAt is NULL');
        }
        
        if($search["value"] != ''){
            $searchItem = trim($search["value"]);
            $searchQuery = 'p.codeProduit LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.nomProd LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'f.libelleFamille LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.stock LIKE \'%'.$searchItem.'%\'';
           
            if($searchQuery !== null){
                $query->andWhere($searchQuery);
                $countQuery->andWhere($searchQuery);
            }
        }
        // Limit
        $query->setFirstResult($start)->setMaxResults($length);

        // Order
        foreach ($orders as $key => $order)
        {
            // $order['name'] is the name of the order column as sent by the JS
            if ($order['name'] != '')
            {
                $orderColumn = null;
            
                switch($order['name'])
                {
                    case 'codeProduit':
                    {
                        $orderColumn = 'p.codeProduit';
                        break;
                    }
                    case 'nomProd':
                    {
                        $orderColumn = 'p.nomProd';
                        break;
                    }
                    case 'libelleFamille':
                    {
                        $orderColumn = 'f.libelleFamille';
                        break;
                    }
                    case 'stock':
                    {
                        $orderColumn = 'p.stock';
                        break;
                    }
                   
                }
        
                if ($orderColumn !== null)
                {
                    $query->orderBy($orderColumn, $order['dir']);
                }
            }
        }
        // Execute
        $results = $query->getQuery()->getArrayResult();
        $countResult = $countQuery->getQuery()->getSingleScalarResult();
        return array(
            "results" 		=> $results,
            "countResult"	=> $countResult
        );  

    }

    public function proddisposImp($search,$point)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('p')
        ->select('p.codeProduit,p.nomProd,f.libelleFamille,p.stock');
        
        // Create inner joins
        $query->leftJoin('p.famille', 'f')->innerJoin('p.pointVente',"pv");
        $query->andWhere('p.stock > 0');
        $query->andWhere('p.deletedAt is NULL');
        
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
        if($search!= ''){
            $searchItem = trim($search);
            $searchQuery = 'p.codeProduit LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.nomProd LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'f.libelleFamille LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.stock LIKE \'%'.$searchItem.'%\'';
           
            if($searchQuery !== null){
                $query->andWhere($searchQuery);
            }
        }
        return $query->getQuery()->getResult();

    }

    public function prodRuptImp($search,$point)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('p')
        ->select('p.codeProduit,p.nomProd,f.libelleFamille,p.stock');
        
        // Create inner joins
        $query->leftJoin('p.famille', 'f')->innerJoin('p.pointVente',"pv");
        $query->andWhere('p.stock = 0');
        $query->andWhere('p.estService != 1');
        $query->andWhere('p.deletedAt is NULL');
        
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
        if($search!= ''){
            $searchItem = trim($search);
            $searchQuery = 'p.codeProduit LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.nomProd LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'f.libelleFamille LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.stock LIKE \'%'.$searchItem.'%\'';
           
            if($searchQuery !== null){
                $query->andWhere($searchQuery);
            }
        }
        return $query->getQuery()->getResult();

    }

    public function getProduits($etat)
    {
        $result = $this->createQueryBuilder('p')->select("p");
            if($etat == 1) {
                $result ->where('p.stock > :val');
            }else {
                $result ->where('p.stock = :val');
            }
        return $result->setParameter('val', 0)->getQuery()->getResult();
    }

}
