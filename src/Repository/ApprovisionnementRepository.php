<?php

namespace App\Repository;

use App\Entity\Approvisionnement;
use App\Entity\ProduitConditionnement;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Approvisionnement>
 *
 * @method Approvisionnement|null find($id, $lockMode = null, $lockVersion = null)
 * @method Approvisionnement|null findOneBy(array $criteria, array $orderBy = null)
 * @method Approvisionnement[]    findAll()
 * @method Approvisionnement[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ApprovisionnementRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Approvisionnement::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(Approvisionnement $entity, bool $flush = true): void
    {
        if ($flush) {
            $this->_em->persist($entity);
        }
        $this->_em->flush();
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function remove(Approvisionnement $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function cumpFinPeriode(ProduitConditionnement $pc)
    {
        return $this->createQueryBuilder('a')
            ->select('SUM(pa.prixAchat * pa.qteCondAppro) / SUM(pa.qteCondAppro) AS CUMP')
            ->innerJoin('a.approMagasins', 'ap')
            ->innerJoin('ap.magasin', 'm')
            ->innerJoin('ap.produitCondApproMags', 'pa')
            ->innerJoin('pa.produitConditionnement', 'pc')
            ->where('pc.id = ' . $pc->getId())
            ->getQuery()
            ->getSingleScalarResult()
        ;
    }


    /*
    public function findOneBySomeField($value): ?Approvisionnement
    {
        return $this->createQueryBuilder('a')
            ->andWhere('a.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
