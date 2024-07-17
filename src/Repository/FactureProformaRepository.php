<?php

namespace App\Repository;

use App\Entity\FactureProforma;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<FactureProforma>
 *
 * @method FactureProforma|null find($id, $lockMode = null, $lockVersion = null)
 * @method FactureProforma|null findOneBy(array $criteria, array $orderBy = null)
 * @method FactureProforma[]    findAll()
 * @method FactureProforma[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class FactureProformaRepository  extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, FactureProforma::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(FactureProforma $entity, bool $flush = true): void
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
    public function remove(FactureProforma $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

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
            ->andWhere('c.dateFactpro BETWEEN :start AND :end')
            ->setParameter('start', $start)
            ->setParameter('end', $end)
            ->getQuery()
            ->getSingleScalarResult();

   }

    // /**
    //  * @return FactureProforma[] Returns an array of FactureProforma objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('c')
            ->andWhere('c.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('c.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?FactureProforma
    {
        return $this->createQueryBuilder('c')
            ->andWhere('c.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
