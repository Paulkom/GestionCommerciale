<?php

namespace App\Repository;

use App\Entity\ProduitCondMagInv;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ProduitCondMagInv>
 *
 * @method ProduitCondMagInv|null find($id, $lockMode = null, $lockVersion = null)
 * @method ProduitCondMagInv|null findOneBy(array $criteria, array $orderBy = null)
 * @method ProduitCondMagInv[]    findAll()
 * @method ProduitCondMagInv[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProduitCondMagInvRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ProduitCondMagInv::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ProduitCondMagInv $entity, bool $flush = true): void
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
    public function remove(ProduitCondMagInv $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function qteInitial($dernierInv,$prCon,$mag){
        //dd($dernierInv,$prCon,$mag);
        $data = $this->createQueryBuilder('p')
            ->select('p.qteCondStockPhy')
            ->innerJoin('p.produitCondInv','prod')
            ->innerJoin('p.inventaireMag',"invMag")
            ->innerJoin('invMag.magasin',"mag")
            ->innerJoin('invMag.inventaire','invent')
            ->andWhere('invent =:inv')
            ->setParameter('inv',$dernierInv)
            ->andWhere('mag = :mag')
            ->setParameter("mag",$mag)
            ->andWhere('prod =:prod ')
            ->setParameter('prod', $prCon);
        return $data->getQuery()->getOneOrNullResult();
    }

    // /**
    //  * @return ProduitCondMagInv[] Returns an array of ProduitCondMagInv objects
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
    public function findOneBySomeField($value): ?ProduitCondMagInv
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
