<?php

namespace App\Repository;

use App\Entity\CommandeFrs;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use DateTime;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<CommandeFrs>
 *
 * @method CommandeFrs|null find($id, $lockMode = null, $lockVersion = null)
 * @method CommandeFrs|null findOneBy(array $criteria, array $orderBy = null)
 * @method CommandeFrs[]    findAll()
 * @method CommandeFrs[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CommandeFrsRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CommandeFrs::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(CommandeFrs $entity, bool $flush = true): void
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
    public function remove(CommandeFrs $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    // /**
    //  * @return CommandeFrs[] Returns an array of CommandeFrs objects
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
    public function findOneBySomeField($value): ?CommandeFrs
    {
        return $this->createQueryBuilder('c')
            ->andWhere('c.exampleField = :val')
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
            ->andWhere('c.dateComFrs BETWEEN :start AND :end')
            ->setParameter('start', $start)
            ->setParameter('end', $end)
            ->getQuery()
            ->getSingleScalarResult();

   }
}
