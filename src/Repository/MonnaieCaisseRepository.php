<?php

namespace App\Repository;

use App\Entity\MonnaieCaisse;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<MonnaieCaisse>
 *
 * @method MonnaieCaisse|null find($id, $lockMode = null, $lockVersion = null)
 * @method MonnaieCaisse|null findOneBy(array $criteria, array $orderBy = null)
 * @method MonnaieCaisse[]    findAll()
 * @method MonnaieCaisse[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class MonnaieCaisseRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, MonnaieCaisse::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(MonnaieCaisse $entity, bool $flush = true): void
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
    public function remove(MonnaieCaisse $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    // /**
    //  * @return MonnaieCaisse[] Returns an array of MonnaieCaisse objects
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
    public function findOneBySomeField($value): ?MonnaieCaisse
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
