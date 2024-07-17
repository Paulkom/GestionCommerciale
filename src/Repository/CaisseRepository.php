<?php

namespace App\Repository;

use App\Entity\Caisse;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Caisse>
 *
 * @method Caisse|null find($id, $lockMode = null, $lockVersion = null)
 * @method Caisse|null findOneBy(array $criteria, array $orderBy = null)
 * @method Caisse[]    findAll()
 * @method Caisse[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaisseRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Caisse::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(Caisse $entity, bool $flush = true): void
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
    public function remove(Caisse $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }



    // /**
    //  * @return Caisse[] Returns an array of Caisse objects
    //  */

    public function fondDeRoulementCaisse($date1, $date2, $point)
    {
        $query =  $this->createQueryBuilder('c')
            ->select('SUM(c.fondRoulement)')
            ->innerJoin("c.pointVente", "pv");
           
            if($point){
                $query->andWhere('pv.id = :pv')
                ->setParameter('pv', $point);
            }
            
            if($date1){
                $query ->andWhere('c.dateOuverture >= :date')
                ->setParameter('date', $date1);
            }

            if($date2){
                $query->andWhere('c.dateOuverture <= :date2')
                ->setParameter('date2', $date2);
            }
            //dd($query->getQuery()->getSingleScalarResult());
        return $query->getQuery()->getSingleScalarResult();
    }

   
    public function findOneByEtat($value): ?Caisse
    {
        return $this->createQueryBuilder('c')
            ->andWhere('c.etat = :val')
            ->setParameter('val', $value)
            ->orderBy('c.id', 'DESC')
            ->setMaxResults(1)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
}
