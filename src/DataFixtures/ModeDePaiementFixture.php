<?php

namespace App\DataFixtures;

use Faker\Factory;
use App\Entity\ModePaiement;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Bundle\FixturesBundle\Fixture;

class ModeDePaiementFixture extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // $faker = Factory::create("fr_FR");
        // for ($j=0; $j<10; $j++)
        // {
        //     $mode = new ModePaiement();
        //     $mode->setCode('M00'.($j+1));
        //     $mode->setLibelle($faker->randomElement(['Virement Bancaire', 'Chèque', 'Espèce']));
        //     $manager->persist($mode);
        // }

        // $manager->flush();
    }
}
