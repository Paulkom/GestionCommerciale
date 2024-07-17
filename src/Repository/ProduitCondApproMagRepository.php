<?php

namespace App\Repository;

use App\Entity\ProduitCondApproMag;
use App\Services\LibrairieService;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ProduitCondApproMag>
 *
 * @method ProduitCondApproMag|null find($id, $lockMode = null, $lockVersion = null)
 * @method ProduitCondApproMag|null findOneBy(array $criteria, array $orderBy = null)
 * @method ProduitCondApproMag[]    findAll()
 * @method ProduitCondApproMag[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProduitCondApproMagRepository extends ServiceEntityRepository
{
    private $librairieService;
    public function __construct(ManagerRegistry $registry,LibrairieService $librairieService)
    {
        $this->librairieService=$librairieService;
        parent::__construct($registry, ProduitCondApproMag::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ProduitCondApproMag $entity, bool $flush = true): void
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
    public function remove(ProduitCondApproMag $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function qteAppro($prCon,$point,$date1,$mag, $date2)
    {
        $data = $this->createQueryBuilder('p')
        ->select('SUM(p.qteCondAppro)')
        ->innerJoin('p.produitConditionnement', 'pc')
        ->innerJoin('p.approMagasin', "apprMa")
        ->innerJoin('apprMa.magasin','mag')
        ->innerJoin('apprMa.approvisionnement','apr')
        ->innerJoin('apr.pointVente','pv')
        ->andWhere('pv = :point')
        ->setParameter('point', $point)
        ->andWhere('pc = :prodCon')
        ->setParameter('prodCon', $prCon)
        ->andWhere('mag = :mag')
        ->setParameter('mag', $mag);

        if($date1 != null){
            $data->andWhere('apr.dateAppro >= :date1')
            ->setParameter('date1', $date1);
        }

        if($date2 != null){
            $data->andWhere('apr.dateAppro <= :date2')
            ->setParameter('date2', $date2);
        }
        
        return $data->groupBy('pc')->getQuery()->getOneOrNullResult();
        
    }

    public function qteApproApres($prCon,$point,$mag, $date2)
    {
        $data = $this->createQueryBuilder('p')
        ->select('SUM(p.qteCondAppro)')
        ->innerJoin('p.produitConditionnement', 'pc')
        ->innerJoin('p.approMagasin', "apprMa")
        ->innerJoin('apprMa.magasin','mag')
        ->innerJoin('apprMa.approvisionnement','apr')
        ->innerJoin('apr.pointVente','pv')
        ->andWhere('pv = :point')
        ->setParameter('point', $point)
        ->andWhere('pc = :prodCon')
        ->setParameter('prodCon', $prCon)
        ->andWhere('mag = :mag')
        ->setParameter('mag', $mag);
        if($date2 != null){
            $data->andWhere('apr.dateAppro > :date2')
            ->setParameter('date2', $date2);
        }
        
        return $data->groupBy('pc')->getQuery()->getOneOrNullResult();
        
    }

    public function qteApproAvantPeriode($prCon,$point,$date1,$mag, $date2)
    {
        $data = $this->createQueryBuilder('p')
        ->select('SUM(p.qteCondAppro)')
        ->innerJoin('p.produitConditionnement', 'pc')
        ->innerJoin('p.approMagasin', "apprMa")
        ->innerJoin('apprMa.magasin','mag')
        ->innerJoin('apprMa.approvisionnement','apr')
        ->innerJoin('apr.pointVente','pv')
        ->andWhere('pv = :point')
        ->setParameter('point', $point)
        ->andWhere('pc = :prodCon')
        ->setParameter('prodCon', $prCon)
        ->andWhere('mag = :mag')
        ->setParameter('mag', $mag);

        if($date1 != null){
            $data->andWhere('apr.dateAppro >= :date1')
            ->setParameter('date1', $date1);
        }

        if($date2 != null){
            $data->andWhere('apr.dateAppro <= :date2')
            ->setParameter('date2', $date2);
        }
        
        return $data->groupBy('pc')->getQuery()->getOneOrNullResult();
        
    }

    public function findByExampleField($dateDebutVer, $point,$mag,$prod, $dateInv=null )
    {
        $data =  $this->createQueryBuilder('p')
            ->innerJoin('p.produitConditionnement','pc')
            ->innerJoin('p.approMagasin','apM')
            ->innerJoin('apM.magasin','m')
            ->innerJoin('apM.approvisionnement',"a")
            ->innerJoin("a.pointVente",'pv');
            if($prod){
                $data->andWhere('pc = :pc')
                ->setParameter('pc', $prod);
            }
            if($point){
                $data->andWhere('pv = :pv')
                ->setParameter('pv', $point);
            }
            
            if($mag){
                $data->andWhere('mag = :mag')
                ->setParameter('mag', $mag);
            }
            $data->andWhere('a.estSup IS NULL')
            ->andWhere('a.deletedAt IS NULL')
            ->orderBy('p.id', 'ASC')
        ;
        return $data ->getQuery()->getResult();
    }


    // /**
    //  * @return ProduitCondApproMag[] Returns an array of ProduitCondApproMag objects
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
    public function findOneBySomeField($value): ?ProduitCondApproMag
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */

    public function counts()
    {
        $result = $this->createQueryBuilder('p')->select("count(p.id)");
         return   $result->getQuery()->getSingleScalarResult();
    }

    public function prodEntrees($start,$point, $length, $orders, $search,$date1,$date2,$magasin)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('p')
        ->select("pr.nomProCond,p.qteCondAppro,p.prixAchat,a.dateAppro,a.reference,m.nomMag,
        CONCAT(CASE WHEN fr.nom IS NULL THEN '' ELSE fr.nom END,' ',CASE WHEN fr.prenoms IS NULL THEN '' ELSE fr.prenoms END, CASE WHEN fr.raisonSociale IS NULL THEN '' ELSE fr.raisonSociale END) as fournisseur");

        // Create Count Query
        $countQuery = $this->createQueryBuilder('p');
        $countQuery->select('COUNT(p)');
        
        // Create inner joins
        $countQuery->leftJoin('p.produitConditionnement', 'pr');
        $countQuery->leftJoin('p.approMagasin', 'am');
        $countQuery->leftJoin('am.magasin', 'm')->innerJoin('m.pointVente','pv');
        $countQuery->leftJoin('am.approvisionnement', 'a');
        $countQuery->leftJoin('a.fournisseur', 'fr');

        $query->leftJoin('p.produitConditionnement', 'pr');
        $query->leftJoin('p.approMagasin', 'am');
        $query->leftJoin('am.magasin', 'm')->innerJoin('m.pointVente','pv');
        $query->leftJoin('am.approvisionnement', 'a');
        $query->leftJoin('a.fournisseur', 'fr');
        

        if($point){
            $query->andWhere('pv.id >= :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id >= :id')
            ->setParameter('id', $point);  
        }
        if ($date1) {
            $query->andWhere('a.dateAppro >= :date1')
            ->setParameter('date1', $date1);
            $countQuery->andWhere('a.dateAppro >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
            $query->andWhere('a.dateAppro <= :date2')
            ->setParameter('date2', $date2);
            $countQuery->andWhere('a.dateAppro <= :date2')
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

            $searchQuery = 'a.reference LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'pr.nomProCond LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'a.dateAppro LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'fr.prenoms LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'fr.nom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'fr.raisonSociale LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.prixAchat LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'm.nomMag LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.qteCondAppro LIKE \'%'.$searchItem.'%\'';
           
            if($searchQuery !== null){
                $query->andWhere($searchQuery);
                $countQuery->andWhere($searchQuery);
            }
        }
        // Limit
        if ($start !='') {
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
                        case 'reference':
                        {
                            $orderColumn = 'a.reference';
                            break;
                        }
                        case 'qteCondAppro':
                        {
                            $orderColumn = 'p.qteCondAppro';
                            break;
                        }
                        case 'dateAppro':
                        {
                            $orderColumn = 'a.dateAppro';
                            break;
                        }
                        case 'fournisseur':
                        {
                            $orderColumn = "CONCAT(CASE WHEN fr.nom IS NULL THEN '' ELSE fr.nom END,' ',CASE WHEN fr.prenoms IS NULL THEN '' ELSE fr.prenoms END, CASE WHEN fr.raisonSociale IS NULL THEN '' ELSE fr.raisonSociale END)";
                            break;
                        }
                        case 'nomMag':
                        {
                            $orderColumn = 'm.nomMag';
                            break;
                        }
                        case 'prixAchat':
                        {
                            $orderColumn = 'p.prixAchat';
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
        if ($start != '') {
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
    public function prodEntreesImp($search,$point,$date1,$date2,$magasin)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('p')
        ->select("pr.nomProCond,p.qteCondAppro,p.prixAchat,a.dateAppro,a.reference,m.nomMag,
        CONCAT(CASE WHEN fr.nom IS NULL THEN '' ELSE fr.nom END,' ',CASE WHEN fr.prenoms IS NULL THEN '' ELSE fr.prenoms END, CASE WHEN fr.raisonSociale IS NULL THEN '' ELSE fr.raisonSociale END) as fournisseur");

        $query->leftJoin('p.produitConditionnement', 'pr');
        $query->leftJoin('p.approMagasin', 'am');
        $query->leftJoin('am.magasin', 'm')
        ->innerJoin('m.pointVente','pv');
        $query->leftJoin('am.approvisionnement', 'a');
        $query->leftJoin('a.fournisseur', 'fr');
        
        if($point){
            $query->andWhere('pv.id >= :id')
            ->setParameter('id', $point);
        }
        if ($date1) {
            $query->andWhere('a.dateAppro >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
            $query->andWhere('a.dateAppro <= :date2')
            ->setParameter('date2', $date2);
        }

        if ($magasin) {
            $query->andWhere('m.id = :magasin')
            ->setParameter('magasin', $magasin);
        }
        
        if($search != null){
            $searchItem = trim($search);

            $searchQuery = 'a.reference LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'pr.nomProCond LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'a.dateAppro LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'fr.prenoms LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'fr.nom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'fr.raisonSociale LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.prixAchat LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'm.nomMag LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.qteCondAppro LIKE \'%'.$searchItem.'%\'';
           
            if($searchQuery !== null){
                $query->andWhere($searchQuery);
            }
        }
       
        return $query->getQuery()->getResult();
    }
}
