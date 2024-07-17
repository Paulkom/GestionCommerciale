<?php

namespace App\Repository;

use App\Entity\ModelSignatairePersonnelFonction;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ModelSignatairePersonnelFonction>
 *
 * @method ModelSignatairePersonnelFonction|null find($id, $lockMode = null, $lockVersion = null)
 * @method ModelSignatairePersonnelFonction|null findOneBy(array $criteria, array $orderBy = null)
 * @method ModelSignatairePersonnelFonction[]    findAll()
 * @method ModelSignatairePersonnelFonction[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ModelSignatairePersonnelFonctionRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ModelSignatairePersonnelFonction::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ModelSignatairePersonnelFonction $entity, bool $flush = true): void
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
    public function remove(ModelSignatairePersonnelFonction $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    // /**
    //  * @return ModelSignatairePersonnelFonction[] Returns an array of ModelSignatairePersonnelFonction objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('m')
            ->andWhere('m.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('m.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?ModelSignatairePersonnelFonction
    {
        return $this->createQueryBuilder('m')
            ->andWhere('m.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
