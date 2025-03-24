Madame,

De nombreux sites internet de ventes de services offrent une rubrique "compte client" permettant à leurs clients de renseigner ou modifier diverses informations, d'accéder aux contrats qu'ils ont signés, etc.

Il semblerait que le site internet de votre société CLO n'en offre pas.

A moins que vous ayez un besoin particulier de développement web dont vous voudriez que nous discutions, je vous propose d'ajouter au site de votre société une telle rubrique.

L'ensemble du code HTML, CSS, Javascript, PHP ainsi que la base de données pourraient être hébergés soit chez votre hébergeur actuel (si c'est possible), soit chez un hébergeur supplémentaire (et très bon marché).

Pour des raisons évidentes de sécurité et de cohérence des données, vous auriez à charge d'ajouter vous même chaque compte client.

Il faudrait décider quelles informations client pourraient apparaître dans cette rubrique.

Il faudrait déterminer quelles informations client pourraient être modifiables directement par vos clients, une fois connecté à son compte.


Votre client pourrait également avoir accès à diverses fonctionnalités qu'il reste à déterminer.

L'une d'elles pourrait être le suivi d'avancement d'un chantier acheté par le client. Je détail dans la suite de ce document à quoi pourrait ressembler cette fonctionnalité.

Une fois ces évolutions développées, testées et ajoutées au site actuel de votre société, libre à vous de les garder ou non.



# Fonctionnalité "Avancement chantier" (S'adapte à la taille de l'écran.)

Objectif : informer un client de l'avancement de son chantier.


## Vocabulaire :

    fiche d'avancement,

    publication d'avancement,

    commentaire.

    ( bien distinguer "fiche d'avancement" de "publication d'avancement" )


## Fiche d'avancement

Une fiche d'avancement est constituée :

    d'un en-tête,
    
    d'une suite de publications d'avancement,
    
    d'éventuels commentaires de chaque publication d'avancement,
    
    d'éventuels commentaires de chaque commentaire.

En-tête de la fiche d'avancement :

    logo CLO

    nom client
    adresse client
    identifiant chantier
    intitulé chantier
    date de début
    date fin prévue


## Actions sur une fiche d'avancement

CLO et client peuvent consulter en même temps une même fiche d'avancement.

CLO et client peuvent modifier en même temps une même fiche d'avancement.


Pour accéder à une fiche d'avancement, CLO et client doivent :

    s'identifier via un identifiant et un mot de passe;

    s'il s'agit d'un client, une liste de noms de fiches d'avancement est affichée (car le client peut avoir plusieurs chantiers en cours); le client clique sur l'un de ces noms;

    s'il s'agit d'un employé de CLO, il doit d'abord indiquer un identifiant de chantier pour lequel il y a une fiche d'avancement.


Les publications d'avancement sont exclusivement rédigées par un employé de CLO.

Une publication d'avancement a une date et une heure précises.

Une publication d'avancement est un texte plus ou moins court, et plus ou moins riche (italiques, gras, tailles de fonte, etc).

Une publication d'avancement peut intégrer des photos, ou être seulement des photos.

Une publication d'avancement peut être supprimée par un employé de CLO. Pas nécessairement celui qui l'a rédigée.

Lorsqu'une publication d'avancement est supprimée, l'ensemble des commentaires qui lui sont liés sont aussi supprimés.

Une publication d'avancement préalablement rédigée peut être annulée, auquel cas elle apparaitra en grisé sur la fiche d'avancement. Ses commentaires également apparaitront en grisé. (Cela correspond au cas où l'action annoncée dans la publication d'avancement à bien été réalisée mais "dé-faite" par la suite.)

Chaque publication d'avancement est séparée de la suivante par plusieurs lignes vides.


A chaque publication d'avancement plusieurs commentaires peuvent être ajoutés (d'ordinaire par le client; mais aussi par un employé de CLO).

Un employé de CLO ou le client peut "répondre" à un commentaire par un autre commentaire.

Un commentaire peut être supprimé par son auteur uniquement.

Lorsqu'un commentaire est supprimé, les commentaires "réponse" à ce commentaire sont aussi supprimés.


Lorsqu'une publication d'avancement est ajoutée, le client peut éventuellement être averti par courriel ou SMS.


Lorsqu'un commentaire concernant une publication d'avancement est ajouté par le client, l'employé de CLO qui a rédigé la publication peut être averti par courriel ou SMS.

Lorsqu'un commentaire est ajouté par un employé de CLO, le client peut être averti par courriel ou SMS.


Une fiche d'avancement peut être exportée à tout moment dans un fichier PDF imprimable.


Une fiche d'avancement n'est jamais clôturée. Il faut tout de même qu'une publication d'avancement indique clairement que le chantier est terminé. Si ce chantier reprend à l'avenir, la fiche d'avancement pourra être utilisée et complétée.

