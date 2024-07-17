<?php

namespace App\Repository;

use App\Entity\Inventaire;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Inventaire>
 *
 * @method Inventaire|null find($id, $lockMode = null, $lockVersion = null)
 * @method Inventaire|null findOneBy(array $criteria, array $orderBy = null)
 * @method Inventaire[]    findAll()
 * @method Inventaire[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class InventaireRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Inventaire::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(Inventaire $entity, bool $flush = true): void
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
    public function remove(Inventaire $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    // /**
    //  * @return Inventaire[] Returns an array of Inventaire objects
    //  */
    public function dernierInventaireavantDate($pointVente,$date)
    {
        $data =  $this->createQueryBuilder('i')
            ->innerJoin('i.pointVente',"pv")
            ->andWhere("pv = :point");
            if($date){
                $data->andWhere('i.createdAt <= :date')
                ->setParameter('date',$date);
            }
            $data->setParameter('point',$pointVente)
            ->andWhere('i.estSup IS NULL')
            ->andWhere('i.deletedAt IS NULL')
            ->andWhere('i.estCloturer = 1')
            ->orderBy('i.id', 'DESC')
            ->setMaxResults(1)
        ;
        return $data->getQuery()->getOneOrNullResult();
    }
    

    /*
    public function findOneBySomeField($value): ?Inventaire
    {
        return $this->createQueryBuilder('i')
            ->andWhere('i.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
