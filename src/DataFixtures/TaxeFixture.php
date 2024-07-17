<?php

namespace App\DataFixtures;

use Faker\Factory;
use App\Entity\Taxe;
use App\Entity\TypeTaxe;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;

class TaxeFixture extends Fixture implements DependentFixtureInterface
{
    public function load(ObjectManager $manager): void
    {
        // $faker = Factory::create('fr_FR');
        // $type = $manager->getRepository(TypeTaxe::class)->findAll();
        // for ($x = 0; $x < 10; $x++) {
        //     $taxe = new Taxe();
        //     $taxe->setTypeTaxe($faker->randomElement($type));
        //     $taxe->setLibelle($faker->word);
        //     $taxe->setValeur(mt_rand(5000, 20000));
        //     $taxe -> setAppellation($faker->sentence);
        //     $manager->persist($taxe);
        // }
        // $manager->flush();
    }

    public function getDependencies(): array
    {
        return [TypeTaxeFixture::class];
    }
}
