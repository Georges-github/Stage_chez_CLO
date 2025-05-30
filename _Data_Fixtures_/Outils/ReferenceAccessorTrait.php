<?php

namespace App\DataFixtures\Outils;

use Doctrine\Common\DataFixtures\ReferenceRepository;

trait ReferenceAccessorTrait
{
    /**
     * Récupère le ReferenceRepository utilisé par la fixture.
     */
    private function getReferenceRepository(): ReferenceRepository
    {
        // Toutes les classes de fixtures Doctrine (héritées de Fixture) ont cette propriété protégée
        return $this->referenceRepository;
    }

    /**
     * Retourne toutes les références enregistrées sous forme de tableau [nom => objet]
     */
    protected function getAllReferences(Object $objet): array
    {
        $repository = $this->getReferenceRepository();
        $all = [];

        foreach ($repository->getReferenceNames($objet) as $name) {
            $all[$name] = $repository->getReference($name,$objet::class);
        }

        return $all;
    }

    /**
     * Retourne toutes les références dont le nom commence par un certain préfixe.
     */
    protected function getReferencesStartingWith(string $prefix, Object $objet): array
    {
        $filtered = [];

        foreach ($this->getAllReferences($objet) as $name => $ref) {
            if (str_starts_with($name, $prefix)) {
                $filtered[$name] = $ref;
            }
        }

        return $filtered;
    }
}
