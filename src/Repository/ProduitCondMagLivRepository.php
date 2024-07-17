<?php

namespace App\Repository;

use App\Entity\ProduitCondMagLiv;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ProduitCondMagLiv>
 *
 * @method ProduitCondMagLiv|null find($id, $lockMode = null, $lockVersion = null)
 * @method ProduitCondMagLiv|null findOneBy(array $criteria, array $orderBy = null)
 * @method ProduitCondMagLiv[]    findAll()
 * @method ProduitCondMagLiv[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProduitCondMagLivRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ProduitCondMagLiv::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ProduitCondMagLiv $entity, bool $flush = true): void
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
    public function remove(ProduitCondMagLiv $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function qteLivre($prCon,$point,$date1,$mag, $date2){
        $data = $this->createQueryBuilder('p')
            ->select('SUM(p.qteLiv)')
            ->innerjoin('p.produitComClit',"pc")
            ->innerJoin('p.livraisonMag','livMag')
            ->innerJoin('livMag.magasin','mag')
            ->innerJoin('pc.produit','pcc')
            ->innerjoin("pc.commandeClit",'cmd')
            ->innerJoin('cmd.pointVente', "pv")
            ->andWhere('cmd.estSup IS NULL')
            ->andWhere('pcc = :prod')
            ->setParameter('prod', $prCon)
            ->andWhere('pv.id = :point')
            ->setParameter('point', $point)
            ->andWhere('mag =:mag')
            ->setParameter('mag',$mag);
            if($date1 != null){
                $data->andWhere('cmd.dateCom >= :date1')
                ->setParameter('date1', $date1);
            }
            if($date2 != null){
                $data->andWhere('cmd.dateCom <= :date2')
                ->setParameter('date2', $date2);
            }
            return $data->groupBy('pcc')->getQuery()->getOneOrNullResult();
    }

    public function qteLivreAvantPeriode($prCon,$point,$date1,$mag, $date2){
        $data = $this->createQueryBuilder('p')
            ->select('SUM(p.qteLiv)')
            ->innerjoin('p.produitComClit',"pc")
            ->innerJoin('p.livraisonMag','livMag')
            ->innerJoin('livMag.magasin','mag')
            ->innerJoin('pc.produit','pcc')
            ->innerjoin("pc.commandeClit",'cmd')
            ->innerJoin('cmd.pointVente', "pv")
            ->andWhere('cmd.estSup IS NULL')
            ->andWhere('pcc = :prod')
            ->setParameter('prod', $prCon)
            ->andWhere('pv.id = :point')
            ->setParameter('point', $point)
            ->andWhere('mag =:mag')
            ->setParameter('mag',$mag);
            if($date1 != null){
                $data->andWhere('cmd.dateCom >= :date1')
                ->setParameter('date1', $date1);
            }
            if($date2 != null){
                $data->andWhere('cmd.dateCom <= :date2')
                ->setParameter('date2', $date2);
            }
            return $data->groupBy('pcc')->getQuery()->getOneOrNullResult();
    }

    // /**
    //  * @return ProduitCondMagLiv[] Returns an array of ProduitCondMagLiv objects
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
    public function findOneBySomeField($value): ?ProduitCondMagLiv
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

    public function prodLivres($start,$point, $length, $orders, $search,$date1,$date2,$magasin)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('p')
        ->select("pr.nomProCond,p.qteLiv,p.qteALiv,l.dateLiv,l.refLiv,m.nomMag,CONCAT(CASE WHEN lv.nom IS NULL THEN '' ELSE lv.nom END,' ',CASE WHEN lv.prenoms IS NULL THEN '' ELSE lv.prenoms END) as livreur,
         p.qteRALiv");

        // Create Count Query
        $countQuery = $this->createQueryBuilder('p');
        $countQuery->select('COUNT(p)');
        
        // Create inner joins
        $countQuery->join('p.produitComClit', 'pc')->innerJoin('pc.produit', 'pr')->innerJoin('pr.produit', 'pro');
        $countQuery->join('p.livraisonMag', 'lm');
        $countQuery->join('lm.magasin', 'm')
        ->innerJoin('m.pointVente','pv');
        $countQuery->join('lm.livraison', 'l');
        $countQuery->join('l.livreur', 'lv');

        $query->join('p.produitComClit', 'pc');
        $query->innerJoin('pc.produit', 'pr')->innerJoin('pr.produit', 'pro')->innerJoin('pr.conditionnement', 'co');
        $query->join('p.livraisonMag', 'lm');
        $query->join('lm.magasin', 'm')
        ->innerJoin('m.pointVente','pv');
        $query->join('lm.livraison', 'l');
        $query->join('l.livreur', 'lv');
        
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id = :id')
            ->setParameter('id', $point);
        }
        if ($date1) {
            $query->andWhere('l.dateLiv >= :date1')
            ->setParameter('date1', $date1);
            $countQuery->andWhere('l.dateLiv >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
            $query->andWhere('l.dateLiv <= :date2')
            ->setParameter('date2', $date2);
            $countQuery->andWhere('l.dateLiv <= :date2')
            ->setParameter('date2', $date2);
        }

        if ($magasin) {
            $query->andWhere('m.id = :magasin')
            ->setParameter('magasin', $magasin);
            $countQuery->andWhere('m.id = :magasin')
            ->setParameter('magasin', $magasin);
        }
        
        if($search !== null && $search !== ''){
            $searchItem = trim($search);
            $searchQuery = 'l.refLiv LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.qteLiv LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'l.dateLiv LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'lv.prenoms LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'lv.nom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'pro.nomProd LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'co.libelleCond LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'm.nomMag LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.qteALiv LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.qteRALiv LIKE \'%'.$searchItem.'%\'';
            $query->andWhere($searchQuery);
            $countQuery->andWhere($searchQuery);
        }
        //dd($query->getDQL());
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
                        case 'refLiv':
                        {
                            $orderColumn = 'l.refLiv';
                            break;
                        }
                        case 'qteLiv':
                        {
                            $orderColumn = 'p.qteLiv';
                            break;
                        }
                        case 'dateLiv':
                        {
                            $orderColumn = 'l.dateLiv';
                            break;
                        }
                        case 'livreur':
                        {
                            $orderColumn = "CONCAT(lv.nom,' ',lv.prenoms)";
                            break;
                        }
                        case 'qteALiv':
                        {
                            $orderColumn = 'p.qteALiv';
                            break;
                        }
                        case 'nomMag':
                        {
                            $orderColumn = 'm.nomMag';
                            break;
                        }
                        case 'qteRALiv':
                        {
                            $orderColumn = 'p.qteRALiv';
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
            $results = $this->reformat($query->getQuery()->getArrayResult());
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

    public function prodLivresImp($search,$point,$date1,$date2,$magasin)
    {
        // Create Main Query
        $query = $this->createQueryBuilder('p')
        ->select("pr.nomProCond,p.qteLiv,p.qteALiv,l.dateLiv,l.refLiv,m.nomMag,CONCAT(CASE WHEN lv.nom IS NULL THEN '' ELSE lv.nom END,' ',CASE WHEN lv.prenoms IS NULL THEN '' ELSE lv.prenoms END) as livreur,
         p.qteRALiv");

        $query->join('p.produitComClit', 'pc');
        $query->join('pc.produit', 'pr');
        $query->join('p.livraisonMag', 'lm');
        $query->join('lm.magasin', 'm')
        ->innerJoin('m.pointVente','pv');
        $query->join('lm.livraison', 'l');
        $query->join('l.livreur', 'lv');
        
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point); 
        }
        if ($date1) {
            $query->andWhere('l.dateLiv >= :date1')
            ->setParameter('date1', $date1);
        }
        if ($date2){
            $query->andWhere('l.dateLiv <= :date2')
            ->setParameter('date2', $date2);
        }

        if ($magasin) {
            $query->andWhere('m.id = :magasin')
            ->setParameter('magasin', $magasin);
        }
        
        if($search != null && $search != ''){
            $searchItem = trim($search);
            $searchQuery = 'l.refLiv LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.qteLiv LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'l.dateLiv LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'lv.prenoms LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'lv.nom LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'm.nomMag LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.qteALiv LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.qteRALiv LIKE \'%'.$searchItem.'%\'';
           
            if($searchQuery !== null){
                $query->andWhere($searchQuery);
            }
        }


        return $results = $query->getQuery()->getResult();

    }

    public function reformat($data): array
    {
        return array_map(function ($item) {
            $keys = array_keys($item);
            foreach ($keys as $key) {
                if ($item[$key] instanceof \DateTime)
                    $item[$key] = $item[$key]->format('d/m/Y');
            }
            return $item;
        }, $data);
    }
}
