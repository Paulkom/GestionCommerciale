<?php

namespace App\DataFixtures;

use App\Entity\Magasin;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;

class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $faker = Factory::create('fr_FR');
        $faker->addProvider(new \Bezhanov\Faker\Provider\Space($faker));
        for ($i = 0; $i < 100; $i++) {
            $magasin = new Magasin();
            $magasin->setNomMag($faker->company);
            $magasin->setAdresse($faker->address);
            $magasin->setCodeMag("MAG-00".($i+1));
            $magasin->setCreatedAt($faker->dateTimeBetween('-10 days', '-1 days'));
            $magasin->setUpdatedAt($faker->dateTimeBetween('-10 days', '-1 days'));
            $manager->persist($magasin);
        }
        $manager->flush();
    }
}
