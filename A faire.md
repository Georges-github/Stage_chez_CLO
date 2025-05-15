```php

Remettre les
Assert\PasswordStrength::STRENGTH_MEDIUM
dans
#[Assert\PasswordStrength(minScore: Assert\PasswordStrength::STRENGTH_MEDIUM, groups: [ValidationGroups::AJOUTER_UN_EMPLOYE])]
et dans
Validations::validerMotDePasse() { ... }


Responsive de : éditer un employé ET ajouter un employé.


Supprimer les 'use' inutiles. Ordonner ceux qui resteront.


Ajouter les messages 'flash'.


Eventuellement : inverser la valeur l'option 'edition' dans 'EditerUnEmployeType.php'  'AdministrateurController.php'.


Passer en revue les 'GET' et 'POST'.


Vérifier les titres des pages.
Notamment dans les cas où il y a :
{% block title %}{% if edition == true %}Editer{% else %}Ajouter{% endif %} un client{% endblock %}


Vérifier la navigation, en particulier les retours.


Inverser colonnes Nom et Prénom dans les Wireframes Figma.


Se décider pour les couleurs des boutons.


Boutons 'Précédente' et 'Suivante' des DataTables.


ListeDesComptesClients version mobile.


Wireframes Figma concernés : ajouter 'téléphone fixe et mobile'.


A propos des contrats : les termes 'Début effectif' et 'Fin effective' sont-ils correctes ?


Dans 'listeDesContrats' ne pas oublier la colonne 'état contrat'.


Voir où ajouter ce test : if ( $utilisateur instanceof Utilisateur ) {


Un client et un employé doivent pouvoir changer leur mot de passe.


Faut-il des courriels de confirmation lors de l'inscription et lors d'un changement de mot de passe ?


Pourquoi le nom du répertoire "templates" commnce t-il avec une minuscule ? et pas les doms des autres répertoires ?


Il faut pouvoir supprimer un employé, un client, un contrat. L'ajouter dans les wireframes.


Vérifier la cohérence lors du choix de plusieurs rôles.


Vérifier le renseignement des dates de mise à jour dans la BD.


Supprimer les répertoires 'Commun'.


Ajuster la taille des menus déroulants (genres).


Faire un bouton 'logout'.


Remplacer le 'Mettre à jour' des boutons des formulaires d'ajout.


Mettre les titres des pages.


Dans les WireFrames, le champ fichier de contrat ne sera probablement pas aussi large.


Générer le MPD (via phpmysql).


Dans le MLD, dans Contrat, le 'numéro de contrat' n'est pas indiqué comme PK.


FileUploader : Unable to guess the MIME type as no guessers are available (have you enabled the php_fileinfo extension?).


Dans la vue 'voir un contrat' ajouter le No de tel mobile du client.


Pour les dates en français dans twig :
composer require twig/intl-extra
et dans twig.yaml :
extra:
        twig/intl-extra: true


Mettre dans la documentation les fichiers de configuration de Symfony (.yaml, ...) .


Dans 'php.ini' décommenter : ;extension=intl .


Retirer les commentaires inutiles et ceux de chatGPT.


Lorsqu'un contrat est édité et le fichier contrat remplacé par un autre, penser à supprimer l'ancien.


Dans la ligne suivante de ContratController.php :
        return $this->render( 'FrontEnd/EditerUnContrat.html.twig' , [ 'form' => $form, 'edition' => false , 'pathContratActuel' => $pathContratActuel ] );
le champ 'edition' est certainement inutile.


Dans  $contrat->setDateHeureMAJ( new \DateTimeImmutable( 'now', new \DateTimeZone('Europe/Paris') ) ); l'heure n'est pas l'heure "actuelle".


Ajouter la colonne numéroContrat dans les wireframes de listeDesContrats .


Si possible faire un outil PERL pour aèrer le code php.


Maintenant que PileDePDFDansPublic est implémenté supprimer les occurrences du paramètre 'pathContratDansPublic'.


Ne pas oublier d'enlever les traces d'affichage de la pile_de_pdf_dans_public.


Juste pour ne pas oublier cette éventualité : navigator.sendBeacon("/log", donneesAnalytiques);


Ne pas oublier d'appeler forget() du service ContratActif.



```
