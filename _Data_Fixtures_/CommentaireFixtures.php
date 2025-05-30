<?php

namespace App\DataFixtures;

use App\Entity\Commentaire;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;

use App\DataFixtures\Outils\ReferenceAccessorTrait;


class CommentaireFixtures extends Fixture implements DependentFixtureInterface
{
    use ReferenceAccessorTrait;

    private const MAX_NIVEAU = 5;

    private $references = [];

    public function load(ObjectManager $manager): void
    {
        $textes = [
            "Merci pour cette info.",
            "Très intéressant !",
            "Je suis d'accord avec vous.",
            "Pourriez-vous préciser ?",
            "Bonne idée, à approfondir.",
            "Cela mérite réflexion.",
            "Excellente proposition.",
            "Je reviendrai plus tard.",
            "Je ne suis pas convaincu.",
            "À revoir dans la prochaine réunion."
        ];

        $generateSousCommentaires = function (
            ObjectManager $manager,
            Commentaire $parent,
            int $niveau,
            int $utilisateurId,
            int $publicationId
        ) use (&$generateSousCommentaires, $textes) {
            if ($niveau >= self::MAX_NIVEAU) {
                return;
            }
            $nbSousCommentaires = rand(0, 3); // 0 à 3 sous-commentaires par commentaire

            for ($i = 0; $i < $nbSousCommentaires; $i++) {
                $commentaire = new Commentaire();
                $commentaire->setTexte($textes[array_rand($textes)]);
                $commentaire->setDateHeureInsertion(new \DateTimeImmutable());
                $commentaire->setDateHeureMAJ(null);
                $commentaire->setIdPublication($parent->getIdPublication());
                $commentaire->setIdCommentaireParent($parent);
                $commentaire->setIdUtilisateur($parent->getIdUtilisateur()); // même utilisateur que parent pour simplifier

                $manager->persist($commentaire);

                // On crée une référence pour ce commentaire, utile pour la photo par exemple
                $spl_object_hash = spl_object_hash($commentaire);
                $this->addReference('commentaire_' . $spl_object_hash, $commentaire);
                $references[] = [ $spl_object_hash => $commentaire ];

                // Appel récursif pour sous-commentaires plus profonds
                $generateSousCommentaires($manager, $commentaire, $niveau + 1, $utilisateurId, $publicationId);
            }
        };

        // Pour chaque publication on crée 3 à 7 commentaires de premier niveau
        // foreach ($this->getReferences() as $refName => $refObj) {
        foreach( $this->references as $refName => $refObj ) {
            if (strpos($refName, 'publication_') === 0) {
                /** @var \App\Entity\Publication $publication */
                $publication = $refObj;
                $utilisateur = $publication->getIdUtilisateur();

                $nbCommentaires = rand(3, 7);
                for ($i = 0; $i < $nbCommentaires; $i++) {
                    $commentaire = new Commentaire();
                    $commentaire->setTexte($textes[array_rand($textes)]);
                    $commentaire->setDateHeureInsertion(new \DateTimeImmutable());
                    $commentaire->setDateHeureMAJ(null);
                    $commentaire->setIdPublication($publication);
                    $commentaire->setIdCommentaireParent(null);
                    $commentaire->setIdUtilisateur($utilisateur);

                    $manager->persist($commentaire);

                    // Référence utile pour d'autres fixtures
                    $this->addReference('commentaire_' . spl_object_hash($commentaire), $commentaire);

                    // Génération récursive des sous-commentaires
                    $generateSousCommentaires($manager, $commentaire, 1, $utilisateur->getId(), $publication->getId());
                }
            }
        }
        // $publicationFixtures =  new PublicationFixtures();
        // $publicationRefs = $this->getReferencesStartingWith('publication_',$publicationFixtures);

        // foreach ($publicationRefs as $refName => $publication) {
        //     /** @var \App\Entity\Publication $publication */
        //     $utilisateur = $publication->getIdUtilisateur();

        //     $nbCommentaires = rand(3, 7);
        //     for ($i = 0; $i < $nbCommentaires; $i++) {
        //         $commentaire = new Commentaire();
        //         $commentaire->setTexte($textes[array_rand($textes)]);
        //         $commentaire->setDateHeureInsertion(new \DateTimeImmutable());
        //         $commentaire->setDateHeureMAJ(null);
        //         $commentaire->setIdPublication($publication);
        //         $commentaire->setIdCommentaireParent(null);
        //         $commentaire->setIdUtilisateur($utilisateur);

        //         $manager->persist($commentaire);
        //         $this->addReference('commentaire_' . spl_object_hash($commentaire), $commentaire);

        //         // Sous-commentaires
        //         $generateSousCommentaires($manager, $commentaire, 1, $utilisateur->getId(), $publication->getId());
        //     }
        // }

        $manager->flush();
    }

    public function getDependencies(): array
    {
        return [
            PublicationFixtures::class,
            UtilisateurFixtures::class,
        ];
    }
}
