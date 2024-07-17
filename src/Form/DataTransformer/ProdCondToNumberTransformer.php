<?php

namespace App\Form\DataTransformer;

use App\Entity\ProduitCondComClit;
use App\Entity\ProduitConditionnement;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Form\DataTransformerInterface;
use Symfony\Component\Form\Exception\TransformationFailedException;

class ProdCondToNumberTransformer implements DataTransformerInterface
{
    public function __construct(private EntityManagerInterface $entityManager)
    {
    }

    /**
     *
     * @param  ProduitConditionnement|null $produitConditionnement
     */
    public function transform($produitConditionnement): ?ProduitCondComClit
    {
        if (null === $produitConditionnement) {
            return '';
        }

      return $produitConditionnement->getId();
    }

    /**
     * Transforms a string (number) to an object (issue).
     *
     * @param  string $proNumber
     * @throws TransformationFailedException if object (issue) is not found.
     */
    public function reverseTransform($proNumber): ?ProduitConditionnement
    {
        // no issue number? It's optional, so that's ok
        if (!$proNumber) {
            return null;
        }

        $produitConditionnement = $this->entityManager
            ->getRepository(ProduitConditionnement::class)
            ->find($proNumber);

        if (null === $produitConditionnement) {
            throw new TransformationFailedException(sprintf(
                'Un produit avec le numéro "%s" n\'existe pas !',
                $proNumber
            ));
        }

        return $produitConditionnement;
    }
}