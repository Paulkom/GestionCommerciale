<?php

namespace App\Repository;

use App\Entity\ProduitCondMag;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ProduitCondMag>
 *
 * @method ProduitCondMag|null find($id, $lockMode = null, $lockVersion = null)
 * @method ProduitCondMag|null findOneBy(array $criteria, array $orderBy = null)
 * @method ProduitCondMag[]    findAll()
 * @method ProduitCondMag[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProduitCondMagRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ProduitCondMag::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ProduitCondMag $entity, bool $flush = true): void
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
    public function remove(ProduitCondMag $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function produitMagasin($id){
        return $this->createQueryBuilder('p')
        ->innerJoin("p.produitConditionnement","pc")
        ->innerJoin("pc.conditionnement","c")
        ->innerJoin('pc.produit','pr')
        ->innerJoin('p.magasin',"m")
        ->andWhere('m.id = :val')
        ->setParameter('val', $id)
        ->andWhere("pr.estSup = 0 OR pr.estSup IS NULL")
        ->orderBy('pr.nomProd', 'ASC')
        ->getQuery()
        ->getResult()
    ;
    }

    public function qteEnStock($point,$prodCon,$mag){
        $qte = $this->createQueryBuilder('p')
        ->select('p.qteStockMag')
        ->innerJoin("p.produitConditionnement","pc")
        ->innerJoin('p.magasin',"m")
        ->innerJoin('m.pointVente',"pv")
        ->andWhere('pv = :point')
        ->setParameter('point',$point)
        ->andWhere('pc =:prod')
        ->setParameter('prod',$prodCon)
        ->andWhere('m =:mag')
        ->setParameter('mag',$mag)
        ;
        return $qte->getQuery()->getOneOrNullResult();
    }

    // /**
    //  * @return ProduitCondMag[] Returns an array of ProduitCondMag objects
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
    public function findOneBySomeField($value): ?ProduitCondMag
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
