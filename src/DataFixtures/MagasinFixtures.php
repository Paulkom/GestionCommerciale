<?php

namespace App\DataFixtures;

use App\Entity\Magasin;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;
class MagasinFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        /*$faker = Factory::create('fr_FR');
        for ($i = 0; $i < 2000000; $i++) {
           $magasin = new Magasin();
           $magasin->setNomMag($faker->name);
           $magasin->setAdresse($faker->address);
           $magasin->setCodeMag("MAG-00".($i+1));
           $magasin->setCreatedAt($faker->dateTimeBetween('-10 days', '-1 days'));
           $magasin->setUpdatedAt($faker->dateTimeBetween('-10 days', '-1 days'));
           $manager->persist($magasin);
        }
        $manager->flush();*/
    }
}
