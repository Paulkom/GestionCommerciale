<?php

namespace App\Repository;

use App\Entity\ProdCondComClit;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ProdCondComClit>
 *
 * @method ProdCondComClit|null find($id, $lockMode = null, $lockVersion = null)
 * @method ProdCondComClit|null findOneBy(array $criteria, array $orderBy = null)
 * @method ProdCondComClit[]    findAll()
 * @method ProdCondComClit[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProdCondComClitRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ProdCondComClit::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ProdCondComClit $entity, bool $flush = true): void
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
    public function remove(ProdCondComClit $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function getProdCmdMag($idComd,$idMag)
    {
        return $this->createQueryBuilder('p')
            ->select('p.*')
            ->leftJoin('p.commandeClit','c')
            ->leftJoin('p.magasin','mag')
            ->andWhere('mag.id = :idMag')
            ->andWhere('c.id = :idComd')
            ->setParameter('idComd', $idComd)
            ->setParameter('idMag', $idMag)
            ->getQuery()
            ->getArrayResult();
    }

    // /**
    //  * @return ProdCondComClit[] Returns an array of ProdCondComClit objects
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
    public function findOneBySomeField($value): ?ProdCondComClit
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
