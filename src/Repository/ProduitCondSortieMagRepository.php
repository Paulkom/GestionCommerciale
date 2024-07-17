<?php

namespace App\Repository;

use App\Entity\ProduitCondSortieMag;
use App\Services\LibrairieService;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ProduitCondSortieMag>
 *
 * @method ProduitCondSortieMag|null find($id, $lockMode = null, $lockVersion = null)
 * @method ProduitCondSortieMag|null findOneBy(array $criteria, array $orderBy = null)
 * @method ProduitCondSortieMag[]    findAll()
 * @method ProduitCondSortieMag[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProduitCondSortieMagRepository extends ServiceEntityRepository
{

    private $librairieService;
    public function __construct(ManagerRegistry $registry,LibrairieService $librairieService)
    {
        $this->librairieService = $librairieService;
        parent::__construct($registry, ProduitCondSortieMag::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ProduitCondSortieMag $entity, bool $flush = true): void
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
    public function remove(ProduitCondSortieMag $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function counts()
    {
        $result = $this->createQueryBuilder('p')->select("count(p.id)");
         return   $result->getQuery()->getSingleScalarResult();
    }

    public function qteSortie($prCon,$point,$date1,$mag, $date2){
        $data = $this->createQueryBuilder('p')
        ->select("SUM(p.qteCondSortie)")
        ->innerJoin("p.produitCond","pc")
        ->innerJoin('p.sortieMag','so')
        ->innerJoin("so.magasin",'mag')
        ->innerJoin('so.sortie','s')
        ->leftJoin('s.pointVente','pv')
        ->andWhere('mag =:mag')
        ->setParameter('mag',$mag)
        ->andWhere('pc = :prod')
        ->setParameter('prod', $prCon)
        ->andWhere('pv.id = :point')
        ->setParameter('point', $point);
        if($date1 != null){
            $data->andWhere('s.dateSortie >= :date1')
            ->setParameter('date1', $date1);
        }
        if($date2 != null){
            $data->andWhere('s.dateSortie <= :date2')
            ->setParameter('date2', $date2);
        }
        return $data->groupBy('pc')->getQuery()->getOneOrNullResult();

    }

    public function prodSorties($start,$point, $length, $orders, $search,$date1,$date2,$magasin)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('p')
        ->select("pr.nomProCond,p.qteCondSortie,s.dateSortie,s.motif,m.nomMag,
        CONCAT(CASE WHEN per.nom IS NULL THEN '' ELSE per.nom END,' ',CASE WHEN per.prenoms IS NULL THEN '' ELSE per.prenoms END) as auteur");

        // Create Count Query
        $countQuery = $this->createQueryBuilder('p');
        $countQuery->select('COUNT(p)');
        
        // Create inner joins
        
        $countQuery->leftJoin('p.produitCond', 'pr');
        $countQuery->leftJoin('p.sortieMag', 'sm');
        $countQuery->leftJoin('sm.magasin', 'm')
        ->innerJoin('m.pointVente','pv');
        $countQuery->leftJoin('sm.sortie', 's');
        $countQuery->leftJoin('s.auteur', 'per');

        $query->leftJoin('p.produitCond', 'pr');
        $query->leftJoin('p.sortieMag', 'sm');
        $query->leftJoin('sm.magasin', 'm')
        ->innerJoin('m.pointVente','pv');
        $query->leftJoin('sm.sortie', 's');
        $query->leftJoin('s.auteur', 'per');
        
        
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
        if ($date1) {
            $query->andWhere('s.dateSortie >= :date1')
            ->setParameter('date1', $date1);
            $countQuery->andWhere('s.dateSortie >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
            $query->andWhere('s.dateSortie <= :date2')
            ->setParameter('date2', $date2);
            $countQuery->andWhere('s.dateSortie <= :date2')
            ->setParameter('date2', $date2);
        }

        if ($magasin) {
            $query->andWhere('m.id = :magasin')
            ->setParameter('magasin', $magasin);
            $countQuery->andWhere('m.id = :magasin')
            ->setParameter('magasin', $magasin);
        }
        
        if($search != null){
            if (is_array($search))
                $searchItem = trim($search["value"]);
            else
                $searchItem = trim($search);

            $searchQuery = 's.motif LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'pr.nomProCond LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 's.dateSortie LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'per.prenoms LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'per.nom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'm.nomMag LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.qteCondSortie LIKE \'%'.$searchItem.'%\'';
           
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
                        case 'motif':
                        {
                            $orderColumn = 's.motif';
                            break;
                        }
                        case 'qteCondSortie':
                        {
                            $orderColumn = 'p.qteCondSortie';
                            break;
                        }
                        case 'dateSortie':
                        {
                            $orderColumn = 's.dateSortie';
                            break;
                        }
                        case 'auteur':
                        {
                            $orderColumn = "CONCAT(per.nom,' ',per.prenoms)";
                            break;
                        }
                        case 'nomMag':
                        {
                            $orderColumn = 'm.nomMag';
                            break;
                        }
                        case 'pr.nomProCond':
                        {
                            $orderColumn = 'pr.nomProCond';
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
            $results =$this->librairieService->reformats($query->getQuery()->getArrayResult());
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

    public function prodSortiesImp($search,$point,$date1,$date2,$magasin)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('p')
        ->select("pr.nomProCond,p.qteCondSortie,s.dateSortie,s.motif,m.nomMag,
        CONCAT(CASE WHEN per.nom IS NULL THEN '' ELSE per.nom END,' ',CASE WHEN per.prenoms IS NULL THEN '' ELSE per.prenoms END) as auteur");

        $query->leftJoin('p.produitCond', 'pr');
        $query->leftJoin('p.sortieMag', 'sm');
        $query->leftJoin('sm.magasin', 'm')
        ->innerJoin('m.pointVente','pv');
        $query->leftJoin('sm.sortie', 's');
        $query->leftJoin('s.auteur', 'per');
        
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point); 
        }
        if ($date1) {
            $query->andWhere('s.dateSortie >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
            $query->andWhere('s.dateSortie <= :date2')
            ->setParameter('date2', $date2);
        }

        if ($magasin) {
            $query->andWhere('m.id = :magasin')
            ->setParameter('magasin', $magasin);
        }
        
        if($search != null){
            $searchItem = trim($search);

            $searchQuery = 's.motif LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'pr.nomProCond LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 's.dateSortie LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'per.prenoms LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'per.nom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'm.nomMag LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.qteCondSortie LIKE \'%'.$searchItem.'%\'';
           
            if($searchQuery !== null){
                $query->andWhere($searchQuery);
            }
        }

        return $query->getQuery()->getResult();
    }


    // /**
    //  * @return ProduitCondSortieMag[] Returns an array of ProduitCondSortieMag objects
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
    public function findOneBySomeField($value): ?ProduitCondSortieMag
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
