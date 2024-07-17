<?php

namespace App\DataFixtures;

use App\Entity\Client;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Faker;

class ClientFixture extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $faker = Faker\Factory::create('fr_FR');
        for ($i = 0; $i < 20; $i++) {
            $cli = new Client();
            if (($i%2)==0) {
                $cli->setNom($faker->lastName);
                $cli->setPrenom($faker->firstName);
                $cli->setStatut('Physique');
            }else {
                $cli->setStatut('Moral');
                $cli->setRaisonSociale($faker->company);
                $cli->setRccm($faker->city." ".$faker->phoneNumber);
                $cli->setSigle(strtoupper($faker->word));
                $cli->setDenomination($faker->company);
            }
             $cli->setIfu($faker->phoneNumber);
             $cli->setAdresse($faker->address);
             $cli->setEmail($faker->email);
             $cli->setTelephone1($faker->phoneNumber);
             $cli->setTelephone2($faker->phoneNumber);
             $cli->setDateNais($faker->dateTimeBetween('-50 years', '-20 years'));
             $manager->persist($cli);
         }

         $manager->flush();

    }
}
