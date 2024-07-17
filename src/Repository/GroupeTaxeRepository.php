<?php

namespace App\Repository;

use App\Entity\GroupeTaxe;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<GroupeTaxe>
 *
 * @method GroupeTaxe|null find($id, $lockMode = null, $lockVersion = null)
 * @method GroupeTaxe|null findOneBy(array $criteria, array $orderBy = null)
 * @method GroupeTaxe[]    findAll()
 * @method GroupeTaxe[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class GroupeTaxeRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, GroupeTaxe::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(GroupeTaxe $entity, bool $flush = true): void
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
    public function remove(GroupeTaxe $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    // /**
    //  * @return GroupeTaxe[] Returns an array of GroupeTaxe objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('g')
            ->andWhere('g.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('g.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?GroupeTaxe
    {
        return $this->createQueryBuilder('g')
            ->andWhere('g.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
