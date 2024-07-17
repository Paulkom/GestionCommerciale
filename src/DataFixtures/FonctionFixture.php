<?php

namespace App\DataFixtures;

use Faker\Factory;
use App\Entity\Fonction;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Bundle\FixturesBundle\Fixture;

class FonctionFixture extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $fonctions = [
            'MAGASINIER' => 'MAG',
            'GERANT' => 'GER',
            'COMPTABLE' => 'COMP',
            'CAISSIERE' => 'CAIS',
            'DG' => 'DG'
        ];
        foreach ($fonctions as $key => $fonc) {
            $fonction = new Fonction();
            $fonction->setCode($key);
            $fonction->setIntitule($fonc);
            $manager->persist($fonction);
        }

        $manager->flush();
    }
}
