<?php

namespace App\DataFixtures;

use App\Entity\Personnel;
use App\Entity\Fonction;
use App\Entity\FonctionPersonnel;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Faker\Factory;


class FonctionPersonnelFixture extends Fixture implements DependentFixtureInterface
{
    public function load(ObjectManager $manager)
    {
        $faker  = Factory::create("fr_FR");
        $pers = $manager->getRepository(Personnel::class)->findAll();
        $fonc = $manager->getRepository(Fonction::class)->findAll();

        for ($i = 0; $i < count($pers); $i++) {
            $fonpers = new FonctionPersonnel();
            $fonpers->setEstActif(1);
            $fonpers->setDateDebutFonc($faker->dateTimeBetween('-10 days', '-1 days'));
            $fonpers->setDateFinFonc($faker->dateTimeBetween('1 years', '10 years'));
            $fonpers->setFonction($faker->randomElement($fonc));
            $fonpers->setPersonnel($pers[$i]);
            $manager->persist($fonpers);
        }
        $manager->flush();
    }

    public function getDependencies(): array
    {
        return [
            //FonctionFixture::class,
            PersonnelFixture::class];
    }
}
