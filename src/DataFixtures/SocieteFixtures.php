<?php

namespace App\DataFixtures;

use App\Entity\Conditionnement;
use App\Entity\Famille;
use App\Entity\Produit;
use App\Entity\ProduitConditionnement;
use App\Entity\Societe;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;
class SocieteFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // $faker = Factory::create('fr_FR');
        // \Bezhanov\Faker\ProviderCollectionHelper::addAllProvidersTo($faker);

        // for ($i = 0; $i < 100; $i++) {
        //    $societe = new Societe();
        //    $societe->setDenomination($faker->company);
        //    $societe->setRaisonSociale($faker->company);
        //    $societe->setIfu(substr(number_format(time() * mt_rand(),0,'',''),0,13));
        //    $societe->setAdresse($faker->address);
        //    $societe->setRccm("-");
        //    $societe->setSigle("-");
        //    $manager->persist($societe);
        // }
        // $manager->flush();
    }
}
