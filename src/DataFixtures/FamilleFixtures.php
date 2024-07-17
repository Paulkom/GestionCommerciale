<?php

namespace App\DataFixtures;

use App\Entity\Famille;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Faker\Factory;
class FamilleFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // $faker = Factory::create('fr_FR');
        // $familles = [];
        // $lists = [
        //     'AUT' => 'AUTRESS',
        //     'ALVI' => 'ALUMINIUM ET VITRERIE',
        //     'CARO' => 'CARREUX',
        //     'CHME' => 'CHARPENTE ET MENUISERIE',
        //     'ELEC' => 'ELECTRICITE',
        //     'PEST' => 'PEINTURE ET STAFF',
        //     'PLOM' => 'PLOMBERIE',
        //     'FER'  => 'FERRAILLAGE',
        //     'MACO' => 'MAÇONNERIE',
        //     'SER'  => 'SERRURE',
        //     'SOUD' => 'SOUDURE',
        // ];

        // foreach ($lists as $key => $libelle)
        // {
        //     $famille = new Famille();
        //     $famille->setCodeFamille($key);
        //     $famille->setLibelleFamille($libelle);
        //     $famille->setFamilleParent($faker->randomElement($familles));
        //     $manager->persist($famille);
        //     array_push($familles, $famille);
        // }
        // $manager->flush();
    }
}
