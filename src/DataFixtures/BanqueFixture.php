<?php

namespace App\DataFixtures;

use Faker\Factory;
use App\Entity\Banque;
use App\Entity\Societe;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Bundle\FixturesBundle\FixtureGroupInterface;

class BanqueFixture
// class UserFixtures extends Fixture implements FixtureGroupInterface
{
    public function load(ObjectManager $manager): void
    {
        $faker = Factory::create("fr_FR");
        $soci = $manager->getRepository(Societe::class)->findAll();

        for($i=0; $i<10; $i++)
        {
            $banque = new Banque();
            $banque->setDenominationBanque($faker->company);
            $banque->setSigle($faker->randomElement(['BOA', 'NSIA', 'UBA', 'ECOBANK', 'CCEI']));
            $banque->setAdresse($faker->address);
            $manager->persist($banque);
        }

        $manager->flush();
    }
   
    
    // public static function getGroups(): array
    // {
    //     return ['group1'];
    // }
}
