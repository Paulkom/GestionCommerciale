<?php

namespace App\DataFixtures;

use Faker\Factory;
use App\Entity\Personnel;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Bundle\FixturesBundle\Fixture;

class PersonnelFixture extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $faker = Factory::create('fr_FR');
        for ($i = 0; $i < 20; $i++) {
            $pers = new Personnel();
             $pers->setNom($faker->lastName);
             $pers->setPrenoms($faker->firstName);
             $pers->setTel($faker->phoneNumber);
             $pers->setEmail($faker->email);
             $pers->setAdresse($faker->address);
             $pers->setDateNais($faker->dateTimeBetween('-50 years', '-20 years'));
             $pers->setSexe($faker->randomElement(['Masculin','Féminin']));
             $pers->setCivilite($faker->randomElement(['M.','Mme','Mlle']));
             $pers->setCreatedAt($faker->dateTimeBetween('-10 days', '-1 days'));
             $pers->setUpdatedAt($faker->dateTimeBetween('-10 days', '-1 days'));
             $manager->persist($pers);

        $manager->flush();
    }
 }
}