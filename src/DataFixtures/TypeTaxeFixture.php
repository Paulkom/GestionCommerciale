<?php

namespace App\DataFixtures;
use App\Entity\TypeTaxe;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;

class TypeTaxeFixture extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // $faker =  Factory::create("fr_FR");
        // for($a=0; $a<10; $a++)
        // {
        //     $type = new TypeTaxe();
        //     $type->setCode('Type'.($a+1));
        //     $type->setLibelle($faker->sentence);
        //     $manager->persist($type);
        // }

        // $manager->flush();
    }
}
