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


```
