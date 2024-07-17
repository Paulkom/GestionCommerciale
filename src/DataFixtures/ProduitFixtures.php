<?php

namespace App\DataFixtures;

use App\Entity\Conditionnement;
use App\Entity\Famille;
use App\Entity\Produit;
use App\Entity\ProduitConditionnement;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;
class ProduitFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // $faker = Factory::create('fr_FR');
        // \Bezhanov\Faker\ProviderCollectionHelper::addAllProvidersTo($faker);

        // $familles = $manager->getRepository(Famille::class)->findAll();
        // $conds = [];
        // for ($i = 0; $i < 100; $i++) {
        //     $cond = new Conditionnement();
        //     $cond->setCodeCond("C00".($i+1));
        //     $cond->setLibelleCond("Conditionnement " . ($i+1));
        //     $manager->persist($cond);
        //     array_push($conds, $cond);
        // }

        // for ($i = 0; $i < 100; $i++) {
        //    $produit = new Produit();
        //    $produit->setNomProd($faker->name);
        //    $produit->setDescProd($faker->sentence());
        //    $produit->setRefProd("REF 00" . ($i+1));
        //    $produit->setEstTaxable(mt_rand(0, 1));
        //    $produit->setPrixVenteProd(mt_rand(1500, 15000));
        //    $produit->setSeuilAppro(mt_rand(20, 100));
        //    $produit->setFamille($faker->randomElement($familles));
        //    $manager->persist($produit);

        //    $produitCond = new ProduitConditionnement();
        //    $produitCond->setProduit($produit);
        //    $produitCond->setConditionnement($faker->randomElement($conds));
        //    $produitCond->setPrixDeVente(mt_rand(1500, 15000));
        //    $produitCond->setQteStockCond(0);
        //    $produit->addProduitConditionnement($produitCond);
        // }
        // $manager->flush();
    }
}
