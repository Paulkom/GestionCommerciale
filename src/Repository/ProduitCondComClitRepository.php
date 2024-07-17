<?php

namespace App\Repository;

use App\Entity\CommandeClient;
use App\Entity\ProduitCondComClit;
use App\Services\LibrairieService;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<ProduitCondComClit>
 *
 * @method ProduitCondComClit|null find($id, $lockMode = null, $lockVersion = null)
 * @method ProduitCondComClit|null findOneBy(array $criteria, array $orderBy = null)
 * @method ProduitCondComClit[]    findAll()
 * @method ProduitCondComClit[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProduitCondComClitRepository extends ServiceEntityRepository
{
    private $librairieService;
    public function __construct(ManagerRegistry $registry, LibrairieService $lib)
    {
        $this->librairieService = $lib;
        parent::__construct($registry, ProduitCondComClit::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(ProduitCondComClit $entity, bool $flush = true): void
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
    public function remove(ProduitCondComClit $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function counts()
    {
        $result = $this->createQueryBuilder('pcc')
        ->select("count(pcc.id)")
        ->InnerJoin('pcc.produit', 'pc')
        ->InnerJoin("pc.produit", 'p')
        ->innerJoin('pc.conditionnement','c')
        ->innerJoin("pcc.commandeClit","cmd")
        ->innerJoin("cmd.acheteur","cl")
        ->innerJoin('p.pointVente','pv')
        ->andWhere("cmd.statut != :statu")
        ->setParameter('statu',"Annuler");
         return   $result->getQuery()->getSingleScalarResult();
    }

    public function counts2()
    {
        $result = $this->createQueryBuilder('pcc')
        ->select("count(pcc.id)")
        ->InnerJoin('pcc.produit', 'pc')
        ->InnerJoin("pc.produit", 'p')
        ->innerJoin('pc.conditionnement','c')
        ->innerJoin("pcc.commandeClit","cmd")
        ->innerJoin("cmd.acheteur","cl")
        ->innerJoin('p.pointVente','pv')
        ->andWhere('cmd.deletedAt IS  NULL')
        ->andWhere('cmd.estSup IS  NULL')
        ->andWhere("cmd.statut = :statu")
        ->setParameter('statu',"Annuler")
        ->andWhere("cmd.motifAnnulation IS NOT NULL");
         return   $result->getQuery()->getSingleScalarResult();
    }


    // /**
    //  * @return ProduitCondComClit[] Returns an array of ProduitCondComClit objects
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


    /**
     * @return ProduitCondComClit|null
     */
    public function getOnPro($prodid,$comid): ?ProduitCondComClit
    {
        return $this->createQueryBuilder('p')
            ->join('p.produit','prod')
            ->join('p.commandeClit','com')
            ->andWhere('com.id = :comid')
            ->andWhere('prod.id= :prodid')
            ->setParameter('comid', $comid)
            ->setParameter('prodid', $prodid)
            ->getQuery()
            ->getOneOrNullResult();
            
    }

    /**
     * @return ProduitCondComClit[]
     */
    public function findByCommandeClit(CommandeClient $commande)
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.commandeClit = :commande')
            ->setParameter('commande', $commande)
            ->getQuery()
            ->getResult();
    }

    /**
     * @return ProduitCondComClit[] Returns an array of ProduitCondComClit objects
    */
    public function getProdCmdMag($idComd,$idMag)
    {
        return $this->createQueryBuilder('p')
            ->select('p')
            ->leftJoin('p.commandeClit','c')
            // ->leftJoin('c.livraisons', 'l')
            // ->leftJoin('l.livraisonMagasins','lm')
            // ->leftJoin('lm.produitCondMagLivs','pl')
            ->andWhere('p.restAliv > 0 OR p.restAliv IS NULL')
            ->andWhere('p.magasin = :idMag')
            ->andWhere('c.deletedAt IS  NULL')
            ->andWhere('c.estSup IS  NULL')
            ->andWhere('c.id = :idComde')
            ->groupBy('p.id')
            ->setParameter('idComde', $idComd)
            ->setParameter('idMag', $idMag)
            ->getQuery()
            ->getResult();
    }

    public function qteVendu($prodCon,$point,$date1,$mag, $date2)
    {
        //dump($point,$mag,$prodCon);
         $data = $this->createQueryBuilder('p')
            ->select('sum(p.qtite)')
            ->innerJoin('p.produit','pc')
            ->innerJoin('p.commandeClit','cmd')
            ->innerJoin('p.magasin','mag')
            ->innerJoin('cmd.pointVente', "pv")
            ->andWhere('pc = :prod')
            ->andWhere('cmd.estSup IS NULL')
            ->setParameter('prod', $prodCon)
            ->andWhere('pv.id = :pv')
            ->setParameter('pv', $point)
            ->andWhere('mag =:mag')
            ->setParameter('mag',$mag);
            $data->andWhere('cmd.deletedAt IS  NULL')
            ->andWhere('cmd.estSup IS  NULL');
            //$countQuery->andWhere('cmd.deletedAt IS  NULL')->andWhere('cmd.estSup IS  NULL');
            
            if($date1 != null){
                $data->andWhere('cmd.dateCom >= :date1')
                ->setParameter('date1', $date1);
            }
            if($date2 != null){
                $data->andWhere('cmd.dateCom <= :date2')
                ->setParameter('date2', $date2);
            }
            return $data->getQuery()->getOneOrNullResult();
    }

    public function prodachete($point,$start, $length, $orders, $search,$date1, $date2,$produit,$client)
    {
        $query = $this->createQueryBuilder('pcc')
        ->select(" pcc.createdAt as date ,pcc.prix as prixDeVente, cmd.refCom, CONCAT(p.nomProd, '  [', c.codeCond , ']') as nomProd, pcc.qtite,
        CONCAT(CASE WHEN cl.nom IS NULL THEN '' ELSE cl.nom END,' ',CASE WHEN cl.prenom IS NULL THEN '' ELSE cl.prenom END,' ',CASE WHEN cl.denomination IS NULL THEN '' ELSE cl.denomination END) as client");
        // Create Count Query
        $countQuery = $this->createQueryBuilder('pcc');
        $countQuery->select('COUNT(pcc)');
        
        // Create inner joins
        $countQuery->InnerJoin('pcc.produit', 'pc')->InnerJoin("pc.produit", 'p')->innerJoin('pc.conditionnement','c')->innerJoin("pcc.commandeClit","cmd")->innerJoin("cmd.acheteur","cl")->innerJoin('p.pointVente','pv')->andWhere("cmd.statut != :statu")->setParameter('statu',"Annuler");
        $query->InnerJoin('pcc.produit', 'pc')->InnerJoin("pc.produit", 'p')->innerJoin('pc.conditionnement','c')->innerJoin("pcc.commandeClit","cmd")->innerJoin("cmd.acheteur","cl")->innerJoin('p.pointVente','pv')->andWhere("cmd.statut != :statu")->setParameter('statu',"Annuler");
        
         if ($date1) {
             $query->andWhere('pcc.createdAt >= :date1')
             ->setParameter('date1', $date1.' 00:00:00');
             $countQuery->andWhere('pcc.createdAt >= :date1')
             ->setParameter('date1', $date1.' 00:00:00');
         }

         if ($date2){
            $query->andWhere('pcc.createdAt <= :date2')
            ->setParameter('date2', $date2.' 23:59:59');
            $countQuery->andWhere('pcc.createdAt <= :date2')
            ->setParameter('date2', $date2.' 23:59:59');
         }

         if ($client != ""){
            $query->andWhere('cl.id = :client')
            ->setParameter('client', $client);
            $countQuery->andWhere('cl.id = :client')
            ->setParameter('client', $client);
         }

         if ($produit != ""){
            $query->andWhere('p.id = :produit')
            ->setParameter('produit', $produit);
            $countQuery->andWhere('p.id = :produit')
            ->setParameter('produit', $produit);
         }
         if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }

         $query->andWhere('cmd.deletedAt IS  NULL')->andWhere('cmd.estSup IS  NULL');
         $countQuery->andWhere('cmd.deletedAt IS  NULL')->andWhere('cmd.estSup IS  NULL');
    
        if($search != null){
             if (is_array($search))
                 $searchItem = trim($search["value"]);
             else
                $searchItem = trim($search);
    
            $searchQuery = "";
            if($searchItem != ""){
                $searchQuery .= 'pcc.createdAt LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'p.nomProd LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'cmd.refCom LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= "CONCAT(CASE WHEN cl.nom IS NULL THEN '' ELSE cl.nom END,' ',CASE WHEN cl.prenom IS NULL THEN '' ELSE cl.prenom END,' ',CASE WHEN cl.raisonSociale IS NULL THEN '' ELSE cl.raisonSociale END,' ',CASE WHEN cl.denomination IS NULL THEN '' ELSE cl.denomination END) LIKE '%".$searchItem."%' OR ";
                $searchQuery .= 'pc.prixDeVente LIKE \'%'.$searchItem.'%\'';
            }
             
           
             if($searchQuery !== null && $searchQuery != ""){
                $query->andWhere($searchQuery);
                $countQuery->andWhere($searchQuery);
             }
        }
    
        
        // Order
        if ($orders!= null) {
             foreach($orders as $key => $order)
             {
                 // $order['name'] is the name of the order column as sent by the JS
                 if ($order['name'] != '')
                 {
                     $orderColumn = null;
                 
                     switch($order['name'])
                     {
                         case 'nomProd':
                         {
                             $orderColumn = 'p.nomProd';
                             break;
                         }
                         
                         case 'date':
                         {
                             $orderColumn = 'pcc.createdAt';
                             break;
                         }
                         case 'refCom':
                            {
                                $orderColumn = 'cmd.refCom';
                                break;
                            }
                         case 'client':
                         {
                            $orderColumn = "cl.id";
                            break;
                         }
                         case 'produit':
                        {
                            $orderColumn = "p.id";
                            break;
                        }
                         
                     }
             
                     if ($orderColumn !== null)
                     {
                         $query->orderBy($orderColumn, $order['dir']);
                     }
                 }
             }
        }
        // Limit
        if ($start != '') {
             $query->setFirstResult((int)$start)->setMaxResults((int)$length);
         }
        // Execute
        //dd($query->getDQL());
        if ($start != null && $length != null) {
            $results = $this->librairieService->reformats($query->getQuery()->getArrayResult());
        }else {
            $results = $query->getQuery()->getResult();
        }
       
        $countResult = $countQuery->getQuery()->getSingleScalarResult();
       
        return array(
            "results" 		=>$results ,
            "countResult"	=> $countResult
        );  
    
    }

    public function prodretourne($point,$start, $length, $orders, $search,$date1, $date2,$produit,$client)
    {
        $query = $this->createQueryBuilder('pcc')
        ->select(" pcc.createdAt as date ,pc.prixDeVente, CONCAT(p.nomProd, '  [', c.codeCond , ']') as nomProd, pcc.qtite,
        CONCAT(CASE WHEN cl.nom IS NULL THEN '' ELSE cl.nom END,' ',CASE WHEN cl.prenom IS NULL THEN '' ELSE cl.prenom END,' ',CASE WHEN cl.denomination IS NULL THEN '' ELSE cl.denomination END) as client");
        // Create Count Query
        $countQuery = $this->createQueryBuilder('pcc');
        $countQuery->select('COUNT(pcc)');
        
        // Create inner joins
        $countQuery->InnerJoin('pcc.produit', 'pc')
        ->InnerJoin("pc.produit", 'p')
        ->innerJoin('pc.conditionnement','c')
        ->innerJoin("pcc.commandeClit","cmd")
        ->innerJoin("cmd.acheteur","cl")
        ->innerJoin('p.pointVente','pv')
        ->andWhere("cmd.statut = :statu")
        ->setParameter('statu',"Annuler")
        ->andWhere("cmd.motifAnnulation IS NOT NULL");
        $query->InnerJoin('pcc.produit', 'pc')
        ->InnerJoin("pc.produit", 'p')
        ->innerJoin('pc.conditionnement','c')
        ->innerJoin("pcc.commandeClit","cmd")
        ->innerJoin("cmd.acheteur","cl")
        ->innerJoin('p.pointVente','pv')
        ->andWhere("cmd.statut = :statu")
        ->setParameter('statu',"Annuler")
        ->andWhere("cmd.motifAnnulation IS NOT NULL");;
        
         if ($date1) {
             $query->andWhere('pcc.createdAt >= :date1')
             ->setParameter('date1', $date1.' 00:00:00');
             $countQuery->andWhere('pcc.createdAt >= :date1')
             ->setParameter('date1', $date1.' 00:00:00');
         }
         $query->andWhere('cmd.deletedAt IS  NULL')->andWhere('cmd.estSup IS  NULL');
         $countQuery->andWhere('cmd.deletedAt IS  NULL')->andWhere('cmd.estSup IS  NULL');
         if ($date2){
            $query->andWhere('pcc.createdAt <= :date2')
            ->setParameter('date2', $date2.' 23:59:59');
            $countQuery->andWhere('pcc.createdAt <= :date2')
            ->setParameter('date2', $date2.' 23:59:59');
         }

         if ($client != ""){
            $query->andWhere('cl.id = :client')
            ->setParameter('client', $client);
            $countQuery->andWhere('cl.id = :client')
            ->setParameter('client', $client);
         }

         if ($produit != ""){
            $query->andWhere('p.id = :produit')
            ->setParameter('produit', $produit);
            $countQuery->andWhere('p.id = :produit')
            ->setParameter('produit', $produit);
         }
         if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
    
        if($search != null){
             if (is_array($search))
                 $searchItem = trim($search["value"]);
             else
                $searchItem = trim($search);
    
            $searchQuery = "";
            if($searchItem != ""){
                $searchQuery .= 'pcc.createdAt LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'p.nomProd LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= "CONCAT(CASE WHEN cl.nom IS NULL THEN '' ELSE cl.nom END,' ',CASE WHEN cl.prenom IS NULL THEN '' ELSE cl.prenom END,' ',CASE WHEN cl.raisonSociale IS NULL THEN '' ELSE cl.raisonSociale END,' ',CASE WHEN cl.denomination IS NULL THEN '' ELSE cl.denomination END) LIKE '%".$searchItem."%' OR ";
                $searchQuery .= 'pc.prixDeVente LIKE \'%'.$searchItem.'%\'';
            }
             
           
             if($searchQuery !== null && $searchQuery != ""){
                $query->andWhere($searchQuery);
                $countQuery->andWhere($searchQuery);
             }
        }
    
        
        // Order
        if ($orders!= null) {
             foreach($orders as $key => $order)
             {
                 // $order['name'] is the name of the order column as sent by the JS
                 if ($order['name'] != '')
                 {
                     $orderColumn = null;
                 
                     switch($order['name'])
                     {
                         case 'nomProd':
                         {
                             $orderColumn = 'p.nomProd';
                             break;
                         }
                         
                         case 'date':
                         {
                             $orderColumn = 'pcc.createdAt';
                             break;
                         }
                         case 'client':
                         {
                            $orderColumn = "cl.id";
                            break;
                         }
                         case 'produit':
                        {
                            $orderColumn = "p.id";
                            break;
                        }
                         
                     }
             
                     if ($orderColumn !== null)
                     {
                         $query->orderBy($orderColumn, $order['dir']);
                     }
                 }
             }
        }
        // Limit
        if ($start != '') {
             $query->setFirstResult((int)$start)->setMaxResults((int)$length);
         }
        // Execute
        //dd($query->getDQL());
        if ($start != null && $length != null) {
            $results = $this->librairieService->reformats($query->getQuery()->getArrayResult());
        }else {
            $results = $query->getQuery()->getResult();
        }
       
        $countResult = $countQuery->getQuery()->getSingleScalarResult();
       
        return array(
            "results" 		=>$results ,
            "countResult"	=> $countResult
        );  
    
    }

    public function prodretourneImp($point,$search,$date1, $date2,$produit,$client)
    {
        $query = $this->createQueryBuilder('pcc')
        ->select(" pcc.createdAt as date ,pc.prixDeVente, CONCAT(p.nomProd, '  [', c.codeCond , ']') as nomProd, pcc.qtite,
        CONCAT(CASE WHEN cl.nom IS NULL THEN '' ELSE cl.nom END,' ',CASE WHEN cl.prenom IS NULL THEN '' ELSE cl.prenom END,' ',CASE WHEN cl.denomination IS NULL THEN '' ELSE cl.denomination END) as client");
        // Create Count Query

        
        $query->InnerJoin('pcc.produit', 'pc')
        ->InnerJoin("pc.produit", 'p')
        ->innerJoin('pc.conditionnement','c')
        ->innerJoin("pcc.commandeClit","cmd")
        ->innerJoin("cmd.acheteur","cl")
        ->innerJoin('p.pointVente','pv')
        ->andWhere("cmd.statut = :statu")
        ->setParameter('statu',"Annuler")
        ->andWhere("cmd.motifAnnulation IS NOT NULL");;
        
         if ($date1) {
             $query->andWhere('pcc.createdAt >= :date1')
             ->setParameter('date1', $date1.' 00:00:00');
         }

         if ($date2){
            $query->andWhere('pcc.createdAt <= :date2')
            ->setParameter('date2', $date2.' 23:59:59');
         }

         if ($client != ""){
            $query->andWhere('cl.id = :client')
            ->setParameter('client', $client);
         }

         if ($produit != ""){
            $query->andWhere('p.id = :produit')
            ->setParameter('produit', $produit);
         }
         if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point); 
        }

        $query->andWhere('cmd.deletedAt IS  NULL')->andWhere('cmd.estSup IS  NULL');
        
    
        if($search != null){
            $searchItem = trim($search);
            $searchQuery = "";
            if($searchItem != ""){
                $searchQuery .= 'pcc.createdAt LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'p.nomProd LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= "CONCAT(CASE WHEN cl.nom IS NULL THEN '' ELSE cl.nom END,' ',CASE WHEN cl.prenom IS NULL THEN '' ELSE cl.prenom END,' ',CASE WHEN cl.raisonSociale IS NULL THEN '' ELSE cl.raisonSociale END,' ',CASE WHEN cl.denomination IS NULL THEN '' ELSE cl.denomination END) LIKE '%".$searchItem."%' OR ";
                $searchQuery .= 'pc.prixDeVente LIKE \'%'.$searchItem.'%\'';
            }
             
           
             if($searchQuery !== null && $searchQuery != ""){
                $query->andWhere($searchQuery);
             }
        }
       
        return  $query->getQuery()->getResult();
    
    }

    public function prodacheteImp($point,$search,$date1, $date2,$produit,$client)
    {
        $query = $this->createQueryBuilder('pcc')
        ->select(" pcc.createdAt as date ,pcc.prix as prixDeVente,cmd.refCom, CONCAT(p.nomProd, '  [', c.codeCond , ']') as nomProd, pcc.qtite, 
        CONCAT(CASE WHEN cl.nom IS NULL THEN '' ELSE cl.nom END,' ',CASE WHEN cl.prenom IS NULL THEN '' ELSE cl.prenom END,' ',CASE WHEN cl.denomination IS NULL THEN '' ELSE cl.denomination END) as client");
        
        // Create inner joins
        $query->InnerJoin('pcc.produit', 'pc')->InnerJoin("pc.produit", 'p')->innerJoin('pc.conditionnement','c')->innerJoin("pcc.commandeClit","cmd")->innerJoin("cmd.acheteur","cl")->innerJoin('p.pointVente','pv');
        
         if ($date1) {
             $query->andWhere('pcc.createdAt >= :date1')
             ->setParameter('date1', $date1.' 00:00:00');
        }

         if ($date2){
            $query->andWhere('pcc.createdAt <= :date2')
            ->setParameter('date2', $date2.' 23:59:59');
         }

         if ($client != ""){
            $query->andWhere('cl.id = :client')
            ->setParameter('client', $client);
         }

         if ($produit != ""){
            $query->andWhere('p.id = :produit')
            ->setParameter('produit', $produit);
         }
         if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
        
        $query->andWhere('cmd.deletedAt IS  NULL')->andWhere('cmd.estSup IS  NULL');
    
        if($search != null){
            $searchItem = trim($search);
            $searchQuery = "";
            if($searchItem != ""){
                $searchQuery .= 'pcc.createdAt LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'p.nomProd LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'cmd.refCom LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= "CONCAT(CASE WHEN cl.nom IS NULL THEN '' ELSE cl.nom END,' ',CASE WHEN cl.prenom IS NULL THEN '' ELSE cl.prenom END,' ',CASE WHEN cl.raisonSociale IS NULL THEN '' ELSE cl.raisonSociale END,' ',CASE WHEN cl.denomination IS NULL THEN '' ELSE cl.denomination END) LIKE '%".$searchItem."%' OR ";
                $searchQuery .= 'pc.prixDeVente LIKE \'%'.$searchItem.'%\'';
            }
             
           
             if($searchQuery !== null && $searchQuery != ""){
                $query->andWhere($searchQuery);
             }
        }
    
       
        return  $query->getQuery()->getResult();
    
    }




   public function prodVendus($point, $start, $length, $orders, $search,$date1, $date2)
   {

        //dd($date1, $date2);
        $query = $this->createQueryBuilder('pcc')
        ->select(" MAX(pcc.createdAt) as date ,pc.prixDeVente, CONCAT(p.nomProd, '  [', c.codeCond , ']') as nomProd, COUNT(pc.id) as nmbre, SUM(pcc.qtite) as qteVendu, SUM(pcc.montantTtcp) as Ca");
        // Create Count Query
        $countQuery = $this->createQueryBuilder('pcc');
        $countQuery->select('COUNT(pcc)');
        // Create inner joins
        $countQuery->InnerJoin('pcc.produit', 'pc')->InnerJoin("pc.produit", 'p')->innerJoin('pc.conditionnement','c')->innerJoin('p.pointVente','pv')->innerJoin("pcc.commandeClit","cmd");
        $query->InnerJoin('pcc.produit', 'pc')->InnerJoin("pc.produit", 'p')->innerJoin('pc.conditionnement','c')->innerJoin('p.pointVente','pv')->innerJoin("pcc.commandeClit","cmd");
        
        if ($date1) {
            $query->andWhere('pcc.createdAt >= :date1')
            ->setParameter('date1', $date1." 00:00:00");
            $countQuery->andWhere('pcc.createdAt >= :date1')
            ->setParameter('date1', $date1." 00:00:00");
        }
        if($point){
            $query->andWhere('pv.id = :id')
            ->setParameter('id', $point);
            $countQuery->andWhere('pv.id = :id')
            ->setParameter('id', $point);  
        }
        if ($date2){
            $query->andWhere('pcc.createdAt <= :date2')
            ->setParameter('date2', $date2." 23:59:59");
            $countQuery->andWhere('pcc.createdAt <= :date2')
            ->setParameter('date2', $date2." 23:59:59");
        }

        $query->andWhere('cmd.deletedAt IS  NULL')->andWhere('cmd.estSup IS  NULL');
        $countQuery->andWhere('cmd.deletedAt IS  NULL')->andWhere('cmd.estSup IS  NULL');

        if($search != null){
            if (is_array($search))
                $searchItem = trim($search["value"]);
            else
            $searchItem = trim($search);

            $searchQuery = 'pcc.createdAt LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'p.nomProd LIKE \'%'.$searchItem.'%\' OR ';
            $searchQuery .= 'pc.prixDeVente LIKE \'%'.$searchItem.'%\'';
        
            if($searchQuery !== null){
                $query->andWhere($searchQuery);
                $countQuery->andWhere($searchQuery);
            }
        }

    
    
        // Order
        if ($orders!= null) {
            foreach($orders as $key => $order)
            {
                // $order['name'] is the name of the order column as sent by the JS
                if ($order['name'] != '')
                {
                    $orderColumn = null;
                
                    switch($order['name'])
                    {
                        case 'nomProd':
                        {
                            $orderColumn = 'p.nomProd';
                            break;
                        }
                        case 'Ca':
                            {
                                $orderColumn = 'Ca';
                                break;
                            }
                        
                        case 'date':
                        {
                            $orderColumn = 'date';
                            break;
                        }
                        case 'qteVendu':
                        {
                            $orderColumn = 'qteVendu';
                            break;
                        }
                        case 'prixDeVente':
                        {
                            $orderColumn = 'pc.prixDeVente';
                            break;
                        }
                        
                    }
            
                    if ($orderColumn !== null)
                    {
                        $query->orderBy($orderColumn, $order['dir']);
                    }
                }
            }
        }
        // Limit
        if ($start != '') {
            $query->setFirstResult((int)$start)->setMaxResults((int)$length);
        }
        $query->groupBy('pc.id')->orderBy("nmbre","DESC");
        // Execute
        if ($start != null && $length != null) {
            $results = $this->librairieService->reformats($query->getQuery()->getArrayResult());
        }else {
            $results = $query->getQuery()->getResult();
        }
    
        $countResult = $countQuery->getQuery()->getSingleScalarResult();
        //dump($results);
        return array(
            "results" 		=>$results ,
            "countResult"	=> $countResult
        );  

    }


    public function prodVendusImp($point, $search,$date1, $date2)
    {
         //dd($date1, $date2);
         $query = $this->createQueryBuilder('pcc')
         ->select(" MAX(pcc.createdAt) as date ,pc.prixDeVente, CONCAT(p.nomProd, '  [', c.codeCond , ']') as nomProd, COUNT(pc.id) as nmbre, SUM(pcc.qtite) as qteVendu, SUM(pcc.montantTtcp) as Ca");
         // Create inner joins
        $query->InnerJoin('pcc.produit', 'pc')->InnerJoin("pc.produit", 'p')->innerJoin('pc.conditionnement','c')->innerJoin('p.pointVente','pv')->innerJoin("pcc.commandeClit","cmd");
         
         if ($date1) {
             $query->andWhere('pcc.createdAt >= :date1')
             ->setParameter('date1', $date1." 00:00:00");
         }
         if($point){
             $query->andWhere('pv.id = :id')
             ->setParameter('id', $point);
         }
         if ($date2){
             $query->andWhere('pcc.createdAt <= :date2')
             ->setParameter('date2', $date2." 23:59:59");
         }
         
         $query->andWhere('cmd.deletedAt IS  NULL')->andWhere('cmd.estSup IS  NULL');

            if($search != null){
                $searchItem = trim($search);
    
                $searchQuery = 'pcc.createdAt LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'p.nomProd LIKE \'%'.$searchItem.'%\' OR ';
                $searchQuery .= 'pc.prixDeVente LIKE \'%'.$searchItem.'%\'';
            
                if($searchQuery !== null){
                    $query->andWhere($searchQuery);
                }
            }
         
         $query->groupBy('pc.id')->orderBy("nmbre","DESC");
         
         return $query->getQuery()->getResult();
 
     }

    /*
    public function findOneBySomeField($value): ?ProduitCondComClit
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
