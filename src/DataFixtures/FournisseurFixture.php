<?php

namespace App\DataFixtures;

use App\Entity\Fournisseur;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker;

class FournisseurFixture extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // $faker = Faker\Factory::create("fr_FR");
        // for($i=0; $i<9; $i++)
        // {
        //     $frs = new Fournisseur();
        //     $frs->setNom($faker->lastName);
        //     $frs->setPrenoms($faker->firstName);
        //     $frs->setAdresse($faker->address);
        //     $frs->setEmail($faker->email);
        //     $frs->setTel1($faker->phoneNumber());
        //     $frs->setTel2($faker->phoneNumber());
        //     $frs->setDateNais($faker->dateTimeBetween('-50 years', '-20 days'));
        //     $frs->setDenomination($faker->company);
        //     $frs->setRaisonSociale($faker->company);
        //     $frs->setIfu($faker->phoneNumber);
        //     $frs->setRccm($faker->city." ".$faker->phoneNumber());
        //     $frs->setSigle(strtoupper($faker->word));
        //     $frs->setStatut($faker->randomElement(['Physique','Moral']));
        //    /* $frs>setCreatedAt($faker->dateTimeBetween('-50 years', '-20 days'));
        //     $frs->setUpdatedAt($faker->dateTimeBetween('-15 days', '-2 days'));*/
        //     $manager->persist($frs);
        // }

        // $manager->flush();
    }
}
