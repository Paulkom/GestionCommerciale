<?php

namespace App\Repository;

use DateTime;
use App\Entity\DemandeDePrix;
use Doctrine\ORM\ORMException;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;

/**
 * @extends ServiceEntityRepository<DemandeDePrix>
 *
 * @method DemandeDePrix|null find($id, $lockMode = null, $lockVersion = null)
 * @method DemandeDePrix|null findOneBy(array $criteria, array $orderBy = null)
 * @method DemandeDePrix[]    findAll()
 * @method DemandeDePrix[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class DemandeDePrixRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, DemandeDePrix::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(DemandeDePrix $entity, bool $flush = true): void
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
    public function remove(DemandeDePrix $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    // /**
    //  * @return DemandeDePrix[] Returns an array of DemandeDePrix objects
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
    public function findOneBySomeField($value): ?DemandeDePrix
    {
        return $this->createQueryBuilder('d')
            ->andWhere('d.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */

    public function countCom(){
        $year = date("Y");
        $date1 = new DateTime("1st January  $year");
        $date2 = new DateTime("1st December  $year");
        $date1->modify("first day of this month");
        $date2->modify("last day of this month");
        $start = $date1->format("Y-m-d");
        $end = $date2->format("Y-m-d");
        return $this->createQueryBuilder('c')
            ->select('count(c.id)')
            ->andWhere('c.dateDdp BETWEEN :start AND :end')
            ->setParameter('start', $start)
            ->setParameter('end', $end)
            ->getQuery()
            ->getSingleScalarResult();

   }
}
