<?php

namespace App\Repository;

use App\Entity\NumeroMobileMoney;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<NumeroMobileMoney>
 *
 * @method NumeroMobileMoney|null find($id, $lockMode = null, $lockVersion = null)
 * @method NumeroMobileMoney|null findOneBy(array $criteria, array $orderBy = null)
 * @method NumeroMobileMoney[]    findAll()
 * @method NumeroMobileMoney[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class NumeroMobileMoneyRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, NumeroMobileMoney::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(NumeroMobileMoney $entity, bool $flush = true): void
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
    public function remove(NumeroMobileMoney $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    // /**
    //  * @return NumeroMobileMoney[] Returns an array of NumeroMobileMoney objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('n')
            ->andWhere('n.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('n.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?NumeroMobileMoney
    {
        return $this->createQueryBuilder('n')
            ->andWhere('n.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
