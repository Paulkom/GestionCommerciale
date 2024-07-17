<?php

namespace App\DataFixtures;

use App\Entity\Monnaie;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class MonnaieFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // $monnais=[5,10,25,50,100,200,250,500,1000,2000,5000,10000];
        // for ($i = 0; $i < count($monnais); $i++) {
        //     $monnaie = new Monnaie();
        //     $monnaie->setLibelle($monnais[$i].''.'F CFA'); 
        //     $monnaie->setValeur($monnais[$i]); 
        //     $manager->persist($monnaie);
        // }
        // $manager->flush();
    }
}
