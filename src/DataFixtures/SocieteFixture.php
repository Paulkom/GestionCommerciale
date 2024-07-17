<?php

namespace App\DataFixtures;

use App\Entity\Societe;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker;

class SocieteFixture extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // $faker = Faker\Factory::create("fr_FR");
        // $var="COTONOU RCCM-RB-";
        // $soci = new Societe();
        // $soci->setDenomination('Société missi mawu');
        // $soci->setSigle('SOMIMAS');
        // $soci->setRaisonSociale('Société missi mawu');
        // $soci->setIfu(785366335635);
        // $soci->setRccm($var.$faker->phoneNumber);
        // $soci->setAdresse('Cotonou stainte Rita');
        // $manager->persist($soci);
        // $manager->flush();
    }
}
