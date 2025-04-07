# -------------------------------------------
# Afficher une page en fonction d'une requête
# -------------------------------------------

# composer :
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '<hash_d_intégrité>') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

# Nouveau projet :
symfony new <nom_du_dossier>

# Arborescence projet :
biblios/
├── assets
│   ├── …
├── bin
│   ├── console
│   └── …
├── config
│   ├── packages
│   ├── …
│   ├── routes.yaml
│   └── services.yaml
├── migrations
├── public
│   └── index.php
├── src
│   ├── Controller
│   ├── Entity
│   ├── Repository
│   └── Kernel.php
├── templates
│   └── base.html.twig
├── tests
├── translations
├── var
│   ├── cache
│   └── log
├── vendor
│   ├── bin
│   ├── composer
│   ├── …
├── composer.json
├── composer.lock
├── …
└── symfony.lock

# Serveur interne de tests :
symfony serve -d

# serveur de test en HTTPS :
symfony server:ca:install

#  barre du Profiler de Symfony, la toolbar.

# requête et réponse :
Les deux ont la même structure – une première ligne descriptive, une série d’en-têtes sous forme de paires clé-valeur, une ligne vide, puis un corps de message – mais un contenu différent.

# Requête :
- une méthode HTTP (ou verbe HTTP, “GET”),

- une ressource (le chemin auquel on tente d’accéder, “/request”; il s’agit d’une adresse relative à celle de votre site. C’est-à-dire que si quelqu’un tape https://www.votresite.com/une-certaine-page dans son navigateur, la ressource sera /une-certaine-page),

- la version du protocole HTTP qui a été utilisée (ici “HTTP/2”).

## GET
Récupérer les informations disponibles à cette adresse.

## POST
Envoyer des données en laissant le serveur se charger de les traiter.

## PUT
Remplacer toutes les données à l’adresse indiquée.

## DELETE
Effacer toutes les données à l’adresse indiquée.

# Réponse :
A la même structure que la requête, mais le contenu est différent.

- la version du protocole HTTP utilisée en premier,

- un code de réponse,

- suivi de sa version textuelle.

## catégorie 1xx
Informations, généralement pour des réponses temporaires, ou suivies d’autres réponses

## catégorie 2xx
Succès, tout s’est bien passé et la réponse comporte l’information demandée

## catégorie 3xx
Redirection, lorsque la ressource a changé d’adresse

## catégorie 4xx
Erreur dans la requête, lorsque le format est mauvais, ou que la ressource demandée n’existe pas, par exemple

## catégorie 5xx
Erreur serveur, si l’application a planté, par exemple

200 OK,
404 Not Found,
500 Internal Server Error.

# Symfony est un framework HTTP :
Son but est de vous permettre de recevoir des requêtes et de renvoyer les réponses adéquates.

# objet Request :
cet objet se trouve dans le composant HttpFoundation.
Le contenu des variables superglobales de PHP ( $_GET , $_POST , $_SERVER , $_COOKIE , ...) accessible dans cet objet.

````php
<?php
// les trois propriétés suivantes sont des objets qui contiennent tous une méthode all() qui renvoie tout leur contenu et une méthode get($key) pour récupérer une valeur
$request->query; // données envoyées dans l’URL, contenu de $_GET
$request->query->get(‘param’); // renverra la valeur “foo” passée dans le paramètre d’URL “param”, par exemple avec “www.monsite.com/une-route?param=foo”
$request->request; // données envoyées dans $_POST
$request->attributes; // données ajoutées par Symfony
$request->getMethod(); // renvoie la méthode HTTP de la requête
$request->getPathInfo(); // renvoie la ressource demandée
$request->getContent(); // renvoie le contenu brut de la requête
````

# Suivez la requête dans Symfony :

- le front controller est tout simplement le fichier qui sert de point d’entrée à notre application. Toutes les requêtes qui arrivent transitent par lui, et c’est lui qui est chargé de démarrer …

- le Kernel de Symfony, c’est le centre de notre application. C’est lui qui sera chargé de gérer la configuration de l’application, prendre en charge la requête, et récupérer la réponse adéquate.

- Vous ne coderez ou ne toucherez cependant pas à tout dans cette liste, l’essentiel de votre travail se cantonnera aux controllers.

Les différents environnements fournis par Symfony sont : dev , test , prod .

Savoir quelle est la demande, grâce au Routing .

Les controllers, chargés de renvoyer une réponse, un objet de la classe Response.

# Les routes :
Peuvent être définies grâce à plusieurs formats : dans des fichiers YAML, dans des fichiers XML, en simple PHP, ou grâce à des attributs PHP sur vos controllers .

Une route est définie par plusieurs choses, dont deux sont obligatoires : un nom, qui doit lui être unique dans l’application, et un chemin, qui est la ressource à laquelle la requête doit correspondre.

```php
<?php
// …
use Symfony\Component\Routing\Attribute\Route;

class SomeController extends AbstractController
{
    #[Route(‘/some-page’, name: ‘app_some_page’)]
    public function somePage(): Response
{
// …
```
Restreindre les méthodes HTTP auxquelles votre route répondra; argument "methods", un array dans lequel vous mettrez la ou les méthodes autorisées par votre route.

```php
<?php
#[Route(‘/some-page’, name: ‘app_some_page’, methods: [‘GET’])]
```

# Les Controllers.
Un controller est un callable qui renvoie une réponse.
"callable" : désigne un type utilisable en PHP. Vous pouvez typer des propriétés, des arguments ou des retours de fonction avec ce type. Ce type désigne tout ce qui peut être appelé par PHP : fonction anonyme, nom de fonction, méthode au sein d’une classe, classe disposant d’une méthode  __invoke , ...

Règles et conventions à respecter pour que vos controllers fonctionnent facilement : 

- se trouver dans le dossier src/Controller et avoir un nom qui se termine par  Controller,

- étendre la classe Symfony\Bundle\FrameworkBundle\Controller\AbstractController,

- garder vos classes de controllers les plus courtes possibles. Ne mettez dedans qu’un nombre limité de routes avec leurs controllers, et ne mettez que le strict minimum de logique dans ces controllers.


# MakerBundle
symfony console list
symfony console list make

# Générer un Controller avec MakerBundle :
symfony console make:controller

```php
<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AwesomeController extends AbstractController
{
    #[Route('/awesome', name: 'app_awesome')]
    public function index(): Response
    {
        return $this->render('awesome/index.html.twig', [
            'controller_name' => 'AwesomeController',
        ]);
    }
}
```

## Nous avons associé une requête avec une route et un controller, qui a renvoyé une réponse !

# En résumé :
- Les routes sont un moyen d’autoriser certaines requêtes dans notre application.
- Les routes doivent avoir un chemin auquel faire correspondre les requêtes, et un nom unique.
- Les routes sont associées à des controllers, qui sont chargés de renvoyer une réponse.
- Vous pouvez facilement créer des fichiers comme les classes de controller grâce au MakerBundle.



# ----------------------------------------------------
# Générer des pages dynamiques réutilisables avec Twig
# ----------------------------------------------------

# Le moteur de template twig.
Faire une base de design pour l’application, que nous pourrons réutiliser sur toutes les pages.

Faire des modèles de pages ("templates") dans lesquels insérer nos données de manière dynamique, en réagissant aux requêtes du client.

Mutualiser toutes les parties communes de nos pages grâce à un système d’héritage très performant.

# La syntaxe de twig.
Découper les pages et les composer, ce qui permet d’avoir plusieurs petits fichiers assez lisibles.

```twig
{# commenter quelque chose #}
{% faire quelque chose %}
{{ afficher quelque chose }}
```

index.html.twig
```html
{% extends 'base.html.twig' %}

{% block title %}Hello MainController!{% endblock %}

{% block body %}
    <style>
        .example-wrapper { margin: 1em auto; max-width: 800px; width: 95%; font: 18px/1.5 sans-serif; }
        .example-wrapper code { background: #F5F5F5; padding: 2px 6px; }
    </style>
    
    <div class="example-wrapper">
        <h1>Hello {{ controller_name }}! ✅</h1>
        This friendly message is coming from:
        <ul>
            <li>Your controller at <code><a href="{{ '/home/benjamin/Dev/sl/biblios/src/Controller/MainController.php'|file_link(0) }}">src/Controller/MainController.php</a></code></li>
            <li>Your template at <code><a href="{{ '/home/benjamin/Dev/sl/biblios/templates/main/index.html.twig'|file_link(0) }}">templates/main/index.html.twig</a></code></li>
        </ul>
    </div>
{% endblock %}
```

# Gérer des templates de page et de fragment.
{% extends 'base.html.twig' %}
Cette ligne indique que notre template en étend un autre. Beaucoup de choses manquent dans ce fichier pour en faire une page HTML complète. C’est dans le fichier "base.html.twig" que vous trouverez toutes ces informations, qui seront donc communes à toutes les pages.

base.html.twig : la structure des pages html.
```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>{% block title %}Welcome!{% endblock %}</title>
        <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 128 128%22><text y=%221.2em%22 font-size=%2296%22>⚫️</text></svg>">
        
        {% block stylesheets %}
        {% endblock %}
        
        {% block javascripts %}
            {% block importmap %}{{ importmap('app') }}{% endblock %}
        {% endblock %}
    </head>
    <body>
        {% block body %}{% endblock %}
    </body>
</html>
```

À chaque fois que vous demanderez l’affichage d’un template qui étend "base.html.twig", Twig ira chercher cette base, et remplacera les blocs qui s’y trouvent par le contenu des blocs portant le même nom.

Ce fonctionnement va vous permettre de faire un layout, c'est-à-dire une base de design unique pour tout votre site.
En profiter pour mettre dans votre base tout le CSS qui sera utilisé sur votre site. Le fichier CSS par défaut se trouve dans "assets/styles/app.css" .

# Gérer les fichiers de ressources avec les ImportMap.
Laisser un nouveau composant de Symfony gérer l’import des fichiers JavaScript et CSS. Ce composant s’appelle AssetMapper. Permet de faire le lien entre vos fichiers et vos templates Twig. Il tire parti d’un nouveau type HTML : importmap.

"AssetMapper", ce composant est installé par défaut avec Symfony lorsque vous utilisez l’option  --webapp; vous n’avez donc rien de plus à faire à part ajouter des dépendances. Une commande spécifique existe pour ça, et elle fait tout à votre place :
symfony console importmap:require


# Ajouter Bootstrap :
symfony console importmap:require bootstrap

Cette commande va ajouter Bootstrap à la liste des imports JavaScript qui seront ajoutés dans le template de base; il va aussi gérer la dépendance. 

Pour ajouter le CSS associé et pouvoir l’utiliser dans les pages, aller dans le fichier "assets/app.js" et ajouter la ligne suivante juste avant  import ‘./styles/app.css’; :

import './vendor/bootstrap/dist/css/bootstrap.min.css';

# Renvoyer un template depuis un Controller :
 $this->render();
premier argument, le chemin d’un template (relatif au dossier  templates),

second argument (optionnel), un tableau des variables que vous souhaitez rendre disponibles dans ce template.

# En résumé :

- Un moteur de template nous permet de dynamiser nos pages et de les composer plus facilement.
- Twig est le moteur de template officiel de Symfony.
- Grâce à une syntaxe simple, Twig nous permet de bénéficier d’un système d’héritage performant pour mutualiser notre design.
- Le composant "AssetMapper" et les "importmaps" HTML nous permettent de gérer nos assets JavaScript et CSS sans s’encombrer des outils habituels.


# ----------------------------------
# Récolter des données à sauvegarder
# ----------------------------------

# Récolter des données avec un formulaire. Composant Form :

- nos champs de formulaire sont représentés par des objets qui implémentent "Symfony\Component\Form\FormTypeInterface" (appelés aussi "FormType" ),
- classes qui implémentent  FormTypeInterface  pour représenter les champs que nous désirons dans notre formulaire,
- "createForm" , en lui passant le nom de notre classe de "FormType" et un objet à remplir avec les données envoyées par l’utilisateur,
- les données envoyées par l'utilisateur seront insérées dans notre objet "FormInterface" (et dans l'objet sur lequel il se base le cas échéant) en passant l'objet "Request" à sa méthode "handleRequest",
- afficher notre formulaire grâce à des fonctions Twig spécifiques. En interne, Symfony appellera la méthode "createView" de la "FormInterface" pour générer la représentation visuelle de notre formulaire.

# Générer un FormTYpe.
- "MakerBundle" permet de générer rapidement des classes de formulaires appelées FormTypes avec sa commande make:form ,
- générer ces classes en les basant sur une classe,
- la commande préremplit le "FormType" avec des champs se basant sur les propriétés de la classe rattachée,
- les noms de classe de  FormType  se terminent toujours par "Type" .

 $builder->add(); de la "FormBuilderInterface". Un paramètre obligatoire, deux optionnels :

- paramètre obligatoire : le nom du champ,

- le nom de la classe qui représente ce champ (doit étendre "FormTypeInterface" ),

- un array d’options supplémentaires qui dépendent du type de champ sélectionné en second paramètre. Tous les champs ont des options en commun, comme  required"

# Afficher le formulaire.
symfony console make:controller

# Utiliser des routes directement sur les classes.
Attribut "Route" directement au-dessus du nom de la classe, en supprimant le chemin de la route par défaut.

```php
<?php
// …
#[Route('/admin/author')]
class AuthorController extends AbstractController
{
    #[Route('', name: 'app_admin_author_index')]
    public function index(): Response
    {
        // …
```

```php
<?php
// ...

    #[Route('/new', name: 'app_admin_author_new', methods: ['GET'])]
    public function new(): Response
    {
        $author = new Author();
        $form = $this->createForm(AuthorType::class, $author);
        
        return $this->render('admin/author/new.html.twig', [
            'form' => $form,
        ]);
    }
```

# Utiliser les fonctions twig d'affichage des formulaires.
Pour afficher un formulaire dans un template, passer la variable "form" à plusieurs fonctions :

- form_start(form) génère l’affichage de la balise d’ouverture du formulaire,

- form_widget(form) génère l’affichage des champs de formulaire, avec leurs labels et erreurs éventuelles,

- form_row( form.[ nom_d_un_champ ] ) pour afficher un seul champ avec son label et son erreur éventuelle,

- form_end(form) génère l’affichage de la balise de fin du formulaire, ainsi que l’affichage de tous les champs évntuellement oubliés.

Symfony génère automatiquement un champ <input type=”hidden”> qui contient un jeton de protection contre les attaques CSRF.

Symfony et Twig protègent aussi automatiquement des failles XSS.


```html
{% extends 'base.html.twig' %}

{% block title %}Ajout d'auteur{% endblock %}

{% block body %}
    <style>
        .example-wrapper { margin: 1em auto; max-width: 800px; width: 95%; font: 18px/1.5 sans-serif; }
        .example-wrapper code { background: #F5F5F5; padding: 2px 6px; }
    </style>
    
    <div class="example-wrapper w-50 m-auto">
        <h1>Ajout d'auteur</h1>
        
        {{ form_start(form) }}
        {{ form_widget(form) }}
        {{ form_end(form) }}
    </div>
{% endblock %}
```

Dans le fichier "config/packages/twig.yaml" :
```yaml
twig:
// …
    form_themes:
        - 'bootstrap_5_layout.html.twig'
// …
```

## Bouton submit :
pourrait être ajouté directement dans le "FormType" en ajoutant un champ de type "SubmitType". Mais les bonnes pratiques Symfony recommandent de mettre ce bouton en tant que bon vieux bouton HTML directement dans vos templates afin de favoriser la réutilisation de vos "FormType".
Dans "templates/admin/author/new.html.twig" :

```html
// …
    {{ form_start(form) }}
        {{ form_widget(form) }}
        <button type="submit" class="btn btn-primary">Envoyer</button>
    {{ form_end(form) }}
// …
```

## Label des champs :
Ajouter une option "label" sur tous les champs du "FormType" :
```php
<?php
// …
    $builder
        ->add('name', TextType::class, [
            'label' => 'Nom',
        ])
// …
```

OU BIEN :
```html
// …
    {{ form_start(form) }}
        {{ form_row(form.name, {label: 'Nom'}) }}
        {{ form_row(form.dateOfBirth, {label: 'Date de Naissance'}) }}
// …
```

# Traiter les données renvoyées par le formulaire.
Dans la méthode new du controller :
- demander à Symfony de recevoir l’objet Symfony\Component\HttpFoundation\Request comme argument,
- autoriser la méthode  POST, pour recevoir les données du formulaire.

# En résumé :
- le composant Form sert à générer, gérer et afficher nos formulaires,
  
- les formulaires sont représentés sous forme de classes étendant "AbstractType",
  
- ces objets peuvent être utilisés dans les controllers pour récupérer les données envoyées par l’utilisateur dans la requête et hydrater les entités,

- twig dispose de fonctions pour faciliter l’affichage de formulaires.


# Sauvegarder des données en base.

# EntityManager



