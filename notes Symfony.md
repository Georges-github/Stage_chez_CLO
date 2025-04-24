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

# EntityManager.
Le point d’entrée unique de toutes vos opérations d’écriture en base de données.

# L'injection de dépendances.
Dans Symfony, nous n’instancions plus les dépendances dont nous avons besoin, nous les demandons.

Plus simple, car nos dépendances ont souvent elles-mêmes des dépendances, qui ont des dépendances, etc.

Pas avoir deux connexions à la base de données en même temps.

Plutôt que d’instancier une classe concrète, nous allons demander un objet qui réponde à une interface. Comme ça, si la classe concrète change de nom, ça ne changera pas notre code, du moment que la nouvelle respecte l’interface.

Demander n’importe quel objet disponible dans l'application simplement en typant les arguments des méthodes.

Dans n’importe quelle méthode d’une classe de controller, ou même dans son constructeur, demander un objet et Symfony le donne.


# Sauvegarder les changements en BD.
Pour indiquer à l'EntityManager qu’il doit prendre en compte une nouvelle entité, il suffit de la passer à sa méthode "persist".
Indiquer à l’EntityManager que le travail est fini grâce à la méthode "flush".

L’EntityManager dispose d’une méthode "remove". Elle s’utilise comme "persist", en lui passant l’objet à supprimer, et appeler "flush"  pour valider le changement.

Lorsque l’utilisateur soumet son formulaire, une nouvelle ligne est ajoutée en base de données, et la page du formulaire est affichée à nouveau… avec les données préremplies dans le formulaire, qui peut être de nouveau soumis avec les mêmes données. Pour éviter cela, envoyer une redirection à l’utilisateur, quitte à le rediriger vers la même page. Cela forcera son navigateur à effectuer une nouvelle requête, vierge de toute donnée, ce qui videra le formulaire. $this->redirectToRoute() à laquelle on fournit un nom de route.

??? : Notre relation Book-Author est une ManyToMany. Dans le cadre de ces relations un peu spéciales, si vous avez défini la relation côté Author, ajouter un auteur côté Book risque de ne produire aucun effet. Pour corriger ce problème, rendez-vous dans le FormType de votre entité non propriétaire, et ajoutez une option by_reference définie à  false  sur le champ représentant la relation :

```php
<?php
class BookType extends AbstractType
{
public function buildForm(FormBuilderInterface $builder, array $options): void
{
$builder
// …
->add('authors', EntityType::class, [
'class' => Author::class,
'choice_label' => 'name',
'multiple' => true,
'by_reference' => false,
])
// …
```

# En résumé.
- l’EntityManager de Doctrine est l’objet qui sert de point d’entrée pour toutes les écritures en base de données,
- il fonctionne par transaction : les entités doivent être passées à "persist" avant de pouvoir "flush" toutes los opérations,
- pour l’utiliser dans un controller, demander un argument typé "Doctrine\Orm\EntityManagerInterface".


# -------------------
# Valider des données
# -------------------

# Composant Validator.
Peut fonctionner seul de manière totalement indépendante, en mode standalone, OU BIEN incorporé au composant "Form".

## Utilisation en standalone :
Ajouter un argument typé avec l’interface "Symfony\Component\Validator\Validator\ValidatorInterface" au controller.
Appeler la méthode "validate" sur l'objet à valider. Vous recevez une liste d’erreurs. Si elle est vide, c’est que tout va bien. 

```php
<?php
    #[Route('/validate', name: 'app_admin_book_validate')]
    public function validate(ValidatorInterface $validator): Response
    {
        // ...
        // $book est un objet Book que nous voulons valider, peu importe sa provenance
        $errors = $validator->validate($book);
        if (0 < \count($errors)) {
            // Gérer les erreurs
        }
        // ...
    }
```

 $form->isValid() n’est rien d’autre qu’un appel au composant "Validator".

Appliquer des contraintes de validation sur les données à valider. Ce sont des classes qui ne contiennent pas de logique, seulement un message d’erreur. Toutes associées à un "ConstraintValidator" qui leur est spécifique.
Appliquer des contraintes sur les objets. Puis, quand on demande au Validator de valider un objet, il va lire les contraintes associées, et va appeler les "ConstraintValidator" correspondants.

Deux façons de faire : directement sur un objet, dans un FormType.
Mettre les contraintes en priorité sur les objets.

# Directement sur un objet.

namespace Symfony\Component\Validator\Constraints, qu’on a coutume d’aliaser en tant que Assert.

NotBlank : la contrainte par défaut de la plupart des champs de formulaires requis, elle vérifie que le champ n’est pas  null,  false , ni une chaîne de caractères vides (comme des espaces).

Length.

Email.

EqualTo / GreaterThan / LowerThan.

Choice.

AtLeastOneOf : prend en paramètre un array d’autres contraintes, et valide la donnée si au moins une de celles-ci est valide.

Si le champ est null, la plupart des contraintes ne vérifient pas la valeur et considèrent que tout va bien. Combinez-les avec NotBlank ou NotNull si le champ est obligatoire.

## Contraindre la validation d'une entité.
```php
<?php
// …
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\Validator\Constraints as Assert;

#[UniqueEntity(['name'])] // <--- CONTRAINTE
#[ORM\Entity(repositoryClass: AuthorRepository::class)]
class Author
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;
    
    #[Assert\Length(min: 10)] // <--- CONTRAINTE
    #[Assert\NotBlank()]
    #[ORM\Column(length: 255)]
    private ?string $name = null;
    
    #[Assert\NotBlank()] // <--- CONTRAINTE
    #[ORM\Column(type: Types::DATE_IMMUTABLE)]
    private ?\DateTimeImmutable $dateOfBirth = null;
    
    #[Assert\GreaterThan(propertyPath: 'dateOfBirth')] // <--- CONTRAINTE
    #[ORM\Column(type: Types::DATE_IMMUTABLE, nullable: true)]
    private ?\DateTimeImmutable $dateOfDeath = null;
    
    #[ORM\Column(length: 255, nullable: true)]
    private ?string $nationality = null;
    
    #[ORM\ManyToMany(targetEntity: Book::class, mappedBy: 'authors')]
    private Collection $books;
    // …
}
```

Pour des messages d'erreur en français :
config/packages/translations.yaml :
```yaml
framework:
    default_locale: fr
    translator:
        default_path: '%kernel.project_dir%/translations'
        fallbacks:
            - fr
        # …
```

# Dans un FormType.

- Il y a des FormTypes qui ne sont pas basés sur des entités.

- Dans un FormType basé sur une entité, il peut y avoir des champs qui ne correspondent pas aux propriétés de votre entité; iil faut l'indiquer à Symfony. Dans le tableau d'options à passer en troisième paramètre à la fonction $builder->add(), ajouter une option 'mapped' => false. Y ajouter ensuite des contraintes de validation, directement dans le FormType, grâce à l'option 'constraints' => []  qui prend comme valeur un tableau des contraintes, instanciées avec le mot-clé new .

```php
<?php
// …
use Symfony\Component\Validator\Constraints as Assert;
// …
class BookType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
        // …
            ->add('certification', CheckboxType::class, [
                'mapped' => false,
                'label' => "Je certifie l'exactitude des informations fournies",
                'constraints' => [
                    new Assert\IsTrue(message: "Vous devez cocher la case pour ajouter un livre."),
                ],
            ])
    // …
```

# En résumé :
- le composant Validator permet d’appliquer des contraintes de validation sur les entités et les formulaires.

- cette validation est indépendante de la validation HTML et plus sécurisée.

- la bonne pratique est de mettre les contraintes sur les entités.

- si c’est impossible, vous pouvez en mettre directement sur un "FormType".

- la méthode $form->isValid() permet d’appeler le Validator sur un formulaire et sur l’entité qui y est rattachée.

- le Validator peut aussi être utilisé seul si on ne valide pas un formulaire.



# ----------------------
# Lire les données en BD
# ----------------------

# Récupérer les entités avec les repositories.
 Lorsque vous récupérez une entité, Doctrine fait automatiquement les jointures avec les entités qui lui sont liées, et vous recevez tous vos objets.

 # Les méthodes des repositories.
 find : id en argument, entité en retour.

 findOneBy : tableau de critères en argument pour effectuer une requête WHERE.

 findAll : les entités d'un certain type.

 findBy :
 le même tableau de critères que findOneBy,
 tableau optionnel construit de la même manière pour ajouter une clause  ORDER BY,
 paramètre optionnel LIMIT,
 un paramètre optionnelS OFFSET.

 count(array $criteria): int : méthode de comptage.
 
# Aficher une liste d'objets.
{% for [valeur] in [array] %}...{% endfor %}

{% for [clé], [valeur] in [array] %} … {% endfor %}

{% else %}

Pour accéder aux propriétés d’un objet ou d’un tableau en Twig, utilisez un point.

# Utiliser le routing pour récupérer une entité spécifique.
Une nouvelle méthode dans Admin\AuthorController : show(). Le template templates/admin/author/show.html.twig .

```php
<?php
#[Route('/{id}', name: 'app_admin_author_show', methods: ['GET'])]
public function show(int $id): Response
```

Ajout de 'requirements' :
```php
<?php
#[Route('/{id}', name: 'app_admin_author_show', requirements: ['id' => '\d+'], methods: ['GET'])]
public function show(int $id): Response
```

Reste à demander en paramètre l'AuthorRepository  et à nous servir de sa méthode "find($id)" pour récupérer l’auteur qui correspond à cet identifiant …

OU BIEN : profiter de la puissance de Symfony et de "EntityValueResolver", qui va directement aller chercher notre entité en fonction de l’identifiant passé dans l’URL. Pour ce faire, remplacez votre argument id dans la méthode du controller par un argument typé de la classe de l'entité.

```php
<?php
#[Route('/{id}', name: 'app_admin_author_show', requirements: ['id' => '\d+'], methods: ['GET'])]
public function show(?Author $author): Response
```
Noter le point d’interrogation devant Author.

# Afficher l'entité grâce à twig.

passer notre variable $author à Twig pour aller l’afficher.
```php
<?php
#[Route('/{id}', name: 'app_admin_author_show', requirements: ['id' => '\d+'], methods: ['GET'])]
public function show(?Author $author): Response
{
    return $this->render('admin/author/show.html.twig', [
        'author' => $author,
    ]);
}
```

```php
<div class="example-wrapper">
    <h1>Auteur : </h1>
    {% if author is not null %}
        <div class="card mb-1 m-auto">
            <div class="card-body">
                <div class="card-title d-flex justify-content-between">
                    <h4 class="mb-1">{{ author.name }}</h4>
                    <small class="text-muted">Identifiant : {{ author.id }}</small>
                </div>
                <div class="d-flex justify-content-between card-text">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">Date de naissance : {{ author.dateOfBirth }}</li>
                        <li class="list-group-item">Date de décès : {{ author.dateOfDeath }}</li>
                    </ul>
                    <p><small>Nationalité : {{ author.nationality }}</small></p>
                </div>
            </div>
        </div>
    {% else %}
        <div>Auteur non trouvé</div>
    {% endif %}
</div>
```

# Utiliser les filtres et fonctions de twig pour afficher des données complexes.
Rajouter une barre verticale derrière le nom de la variable à filtrer, suivie du nom du filtre.

```php
<li class="list-group-item">Date de naissance : {{ author.dateOfBirth|date('d M Y') }}</li>
```

```php
<li class="list-group-item">Date de décès : {{ author.dateOfDeath is not null ? author.dateOfDeath|date('d M Y') : '-' }}</li>
```

# twig et internationalisation.
symfony composer require twig/intl-extra

```php
<p><small>Nationalité : {{ author.nationality|country_name }}</small></p>
```

# Utiliser la fonction path pour ajouter de la navigation.
Twig dispose d’une fonction spéciale, path :
en premier paramètre le nom d’une route de l'application,
en second paramètre optionnel les paramètres à passer à cette route.

```php
<div class="card-title d-flex justify-content-between">
    <a href="{{ path('app_admin_author_show', {id: author.id}) }}" class="stretched-link link-dark">
        <h4 class="mb-1">{{ author.name }}</h4>
    </a>
    <small class="text-muted">Identifiant : {{ author.id }}</small>
</div>
```

```php
<a href="{{ path('app_admin_author_index') }}" class="btn btn-primary">Retour</a>
```

# Le QueryBuilder de Doctrine.
Appeler des méthodes très expressives sur un objet QueryBuilder, comme where() ou même join(). Ensuite, lorsque nous demanderons à récupérer notre requête avec getQuery(), il construira la requête tout seul à partir de ce que nous avons demandé.

Une méthode de repository existe pour générer un objet QueryBuilder : createQueryBuilder( "première lettre de l'entité" );

```php
<?php
public function findByDateOfBirth(array $dates = []): array
{
    $qb = $this->createQueryBuilder('a');
    
    if (\array_key_exists('start', $dates)) {
        $qb->andWhere('a.dateOfBirth >= :start')
            ->setParameter('start', new \DateTimeImmutable($dates['start']));
    }
    
    if (\array_key_exists('end', $dates)) {
        $qb->andWhere('a.dateOfBirth <= :end')
            ->setParameter('end', new \DateTimeImmutable($dates['end']));
    }
    
    return $qb->orderBy('a.dateOfBirth', 'DESC')
            ->getQuery()
            ->getResult();
}
```

# Utiliser des méthodes de requêtes personnalisées.
Dans le controller on utilise la nouvelle méthode écrite du repository :

```php
<?php
#[Route('', name: 'app_admin_author_index', methods: ['GET'])]
public function index(Request $request, AuthorRepository $repository): Response
{
    $dates = [];
    if ($request->query->has('start')) {
        $dates['start'] = $request->query->get('start');
    }
    
    if ($request->query->has('end')) {
        $dates['end'] = $request->query->get('end');
    }
    
    $authors = $repository->findByDateOfBirth($dates);
    // Le reste ne change pas
```

# Pagination avec PagerFanta.

à revoir ...

# Formulaire d'édition pour les entités.

Combiner les routes dynamiques avec les formulaires.

```php
<?php
#[Route('/new', name: 'app_admin_author_new', methods: ['GET', 'POST'])]
#[Route('/{id}/edit', name: 'app_admin_author_edit', requirements: ['id' => '\d+'], methods: ['GET', 'POST'])]
public function new(?Author $author, Request $request, EntityManagerInterface $manager): Response
```
Deux routes pour le même controller : /admin/author/new, la variable $author vaudra null ; /admin/author/<identifiant>/edit, Symfony ira chercher en base de données l’auteur correspondant et le mettra dans $author.

```php
<?php
public function new(?Author $author, Request $request, EntityManagerInterface $manager): Response
{
    $author ??= new Author();
    // …
```

# La variable app.
Toujours disponible dans tous les templates.

```php
{% extends 'base.html.twig' %}

{% set action = app.current_route == 'app_admin_author_new' ? 'Ajout' : 'Édition' %}

{% block title %}{{ action }} d'auteur{% endblock %}

{% block body %}
    {# … #}
    <div class="example-wrapper">
        <h1>{{ action }} d'auteur</h1>
        {# … #}
```

# En résumé :
- les Repositories sont le point d’entrée pour les lectures en base de données.

- il en existe généralement un par entité de notre application.

- ils disposent de 5 méthodes de base pour lire notre base de données :  find  ,  findOneBy  ,  findBy  ,  findAll   et  count  .

- vous pouvez rajouter des méthodes personnalisées pour vos besoins spécifiques. Ces méthodes spécifiques utiliseront le plus souvent le QueryBuilder pour construire vos requêtes en base de données.



# ------------------------
# Définir les utilisateurs
# ------------------------

# La sécurité des applications web.
- la requête vise-t-elle une route de notre application ?
- cette route est-elle protégée ?
- authentification - HTTP 401 Unauthorized
- autorisation - HTTP 403 Forbidden

Le sujet de toutes les questions de sécurité, c’est l’utilisateur. L’objet central de la sécurité, et il va avoir besoin d’une représentation particulière dans notre application.

# Représenter les utilisateurs avec l'interface UserInterface.
Symfony\Component\Security\Core\User\UserInterface.

Définit les méthodes obligatoires qui seront utilisées par le système de sécurité, mais ne définit pas de moyen de gérer les mots de passe. Donc  implémenter une seconde interface la classe d’utilisateur : Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface.

UserInterface :
- getUserIdentifier retourne la chaîne de caractères qui identifie l'utilisateur quand il se connecte.
- getRoles retourne un array de chaînes de caractères appelées rôles, qui permet d’aider à déterminer les droits de l’utilisateur.
- eraseCredentials sert à éviter de garder en mémoire le mot de passe de l’utilisateur avant hachage, mais ce n’est pas obligatoire.

PasswordAuthenticatedUserInterface :
- getPassword récupère le mot de passe haché.

Rien n'empêche d’implémenter ces interfaces sur une entité, c’est même tout à fait classique.

# Générer une classe User.
- MakerBundle propose une commande make:user pour générer une classe qui implémente  UserInterface.
- Grâce à cette commande, on peut implémenter PasswordAuthenticatedUserInterface ou non.
- On peut aussi choisir de faire de votre classe une entité ou non.
- Gère les changements à apporter à la configuration de sécurité dans config/packages/security.yaml .

Ne pas oublier d'effectuer une nouvelle migration (symfony console make:migation) , et d'appliquer cette migration (symfony console doctrine:migrations:migrate).

# Récupérer les utilisateurs en BD.
config/packages/security.yaml :

```yaml
security:
# …
    providers:
    # used to reload user from session & other features (e.g. switch_user)
        app_user_provider: # Un provider,
            entity: # qui est de type entité;
                class: App\Entity\User # c'est celui-ci,
                property: username # et username est la propriété de l'entité pour retrouver l'utilisateur.
            # …
```

## Provider.
Authentification, autorisation.

Authentification en deux temps :
- vérifier qu'un utilisateur ayant l'identifiant spécifié dans la requête, existe dans la BD : UserProvider cherchent dans leur source de données l'utilisateur ayant l'identifiant spécifié.
- vérifier le mot de passe.

Quatre types de providers dans Symfony.

Clef providers: on peut spécifier un provider pour chaque source de données.

```php
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 180, nullable: true)]
    private ?string $username = null;

    /**
     * @var list<string> The user roles
     */
    #[ORM\Column]
    private array $roles = [];

    #[Assert\NotCompromisedPassword()]
    #[Assert\PasswordStrength(minScore: Assert\PasswordStrength::STRENGTH_STRONG)]
    #[Assert\Regex('/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.*\s).{8,32}$/')]
    #[ORM\Column]
    private ?string $password = null;

    #[Assert\NotBlank()]
    #[ORM\Column(length: 255)]
    private ?string $firstname = null;

    #[Assert\NotBlank()]
    #[ORM\Column(length: 255)]
    private ?string $lastname = null;

    #[Assert\Email()]
    #[Assert\NotBlank()]
    #[ORM\Column(length: 255, unique: true)]
    private ?string $email = null;
```

```yaml
security:
    # https://symfony.com/doc/current/security.html#registering-the-user-hashing-passwords
    password_hashers:
        Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface: 'auto'
    # https://symfony.com/doc/current/security.html#loading-the-user-the-user-provider
    providers:
        # used to reload user from session & other features (e.g. switch_user)
        app_user_provider:
            entity:
                class: App\Entity\User
                property: email
```


# En résumé :
- Authentification. Autorisation.
- Pour représenter l’utilisateur qui déclenche une requête, Symfony a besoin d’un objet qui implémente UserInterface.
- UserProvider.
- Symfony embarque nativement plusieurs types de UserProviders, dont le type entité qui cherche les utilisateurs en base de données.


# ----------------------------------
# Mettre en place l'authentification
# ----------------------------------

# Le point d'entrée d'authentification.
UserProvider.
Authenticator.

Le firewall est donc l’objet qui appellera d’abord notre UserProvider, puis un Authenticator.

```yaml
security:
# …
    firewalls:
        dev:
            pattern: ^/(_(profiler|wdt)|css|images|js)/
            security: false # Aucune vérification de sécurité ne sera effectué sur les routes correpondantes au pattern.
        main:
            lazy: true
            provider: app_user_provider
            # activate different ways to authenticate
            # https://symfony.com/doc/current/security.html#the-firewall
            # https://symfony.com/doc/current/security/impersonating_user.html
            # switch_user: true
```

 Chaque firewall s’applique uniquement aux URL correspondant à la clé pattern de sa configuration. Si vous ne renseignez pas de pattern, le firewall s’applique à toute l’application.

Symfony applique le premier firewall qui correspond au chemin et n’applique pas les suivants.

"lazy: true" le firewall forcera l'authentification que si on demande une vérification de droits quelque part. Sinon, le firewall ne fera rien.

"make:user" a rajouté le nom du UserProvider à la clé provider du firewall main.

# Sécuriser les mots de passe avec les hacheurs.
- Générer rapidement une ébauche de formulaire d'enregistrement grâce à la commande "make:registration-form".
- La commande ajoute un attribut pour s'assurer de l'unicité de chaque utilisateur en base de données.
- La commande génère aussi un FormType adapté qui prend en paramètre le mot de passe de l'utilisateur en clair.
- Le controller généré fait ensuite appel à un objet pour hacher ce mot de passe.

 Générer rapidement une ébauche de formulaire d'enregistrement grâce à la commande "make:registration-form" .
 La commande ajoute un attribut pour s'assurer de l'unicité de chaque utilisateur en BD.
 La commande génère aussi un FormType adapté qui prend en paramètre le mot de passe de l'utilisateur en clair.

Dans le fichier "src/Form/RegistrationFormType.php" qui a été généré, supprimer la case à cocher agreeTerms; le formulaire ne sera pas public.
plainPassword n'est pas mappé.

```php
$pwd = $form->get('plainPassword')->getData()
UserPasswordHasherInterface $userPasswordHasher->hashPassword( $utilisateur , $pswd );
$user->setPassword();
```

config/packages/security.yaml
```yaml
security:
    # https://symfony.com/doc/current/security.html#registering-the-user-hashing-passwords
    password_hashers:
        Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface: 'auto'
```
L’endroit où choisir de quelle façon hacher les mots de passe de chaque classe d'utilisateur.
'auto' : laisser Symfony choisir l'algorithme de hachage pour toutes les classes qui implémentent PasswordAuthenticatedUserInterface.

Symfony choisit par défaut un algorithme appelé BCRYPT, car il offre le meilleur rapport sécurisation versus temps de génération.

# Authentifier les utilisateur via un formulaire.
Symfony embarque nativement un nombre assez important d’Authenticators.

La commande "make:security:form-login" vous permet de créer facilement une page de login et un logout.
Elle met à jour la configuration dans "config/packages/security.yaml".
Vous devez tout de même compléter la configuration du logout avec le nom d'une route vers laquelle rediriger les utilisateurs déconnectés.

# En résumé :
Les Firewalls gèrent l’authentification dans nos applications.
Ils agissent en deux temps : les UserProviders récupèrent l’utilisateur, et l’Authenticator vérifie son identité.
Les UserPasswordHashers permettent de transformer les mots de passe utilisateur en les rendant illisibles pour plus de sécurité.


# -----------------------------------------
# Gérer les authorisations des utilisateurs
# -----------------------------------------

# Accorder des droits avec AccessControl.
Demander à vérifier des conditions pour que l’application réponde à des requêtes spécifiques.

Mécanisme des Voters : petits services qui ne peuvent répondre qu’à une seule question de sécurité bien précise.

# Demander un contrôle d'accès : isGranted.

```php
Depuis un Controller :
$this->isGranted( [ ... ] )
$this->denyAccessUnlessGranted( [ ... ] ) lance une exception si l’utilisateur n’a pas le droit.
#[ IsGrante( [ ... ] ) ] sur la méthode de Controller; lance une exception si l’utilisateur n’a pas le droit.
```

Depuis une autre classe :
    Injecter dans le constructeur __construct un objet :
```php
        Symfony\Component\Security\Core\Authorization\AuthorizationCheckerInterface $checker;
        $this->checker->isGranted([...]);
```
```php
        Symfony\Bundle\SecurityBundle\Security $security;
        $this->security->isGranted([...]);

        Aussi pour récupérer l’utilisateur actuellement connecté : $security->getUser();
```

Depuis un template :
is_granted( [ ... ] ) renvoie true ou false.

Les vérifications les plus simples :
    l'utilisateur est-il connecté
        IS_AUTHENTICATED vérifie qu'un utilisateur est connecté.
        IS_AUTHENTICATED_REMEMBERED
        IS_AUTHENTICATED_FULLY ne laisse passer que les utilisateurs qui se sont connectés activement au cours de cette session.
        IS_REMEMBERED ne laisse passer que les utilisateurs connectés depuis une session de cookie “remember me”.
        PUBLIC_ACCESS

    l'utilisateur a t-il un rôle spécifique

 Les attributs #[IsGranted] et #[Route], peuventt s’utiliser sur l’ensemble d’une classe de controller. Ceci permet de restreindre l’ensemble des routes de la classe d’un coup.

 Un rôle est une chaîne de caractères en majuscules et qui commence par  ROLE_ .
 Les rôles sont stockés sur les utilisateurs dans une propriété 'roles', qui est un array de chaînes de caractères.


# Personnaliser les droits d'accès.

## La hiérarchie des rôles.

```yaml
config/packages/security.yaml

security:
# …
    role_hierarchy:
        ROLE_USER: ~
        ROLE_MODERATEUR: ROLE_USER
        ROLE_AJOUT_DE_LIVRE: ROLE_USER
        ROLE_EDITION_DE_LIVRE: ROLE_AJOUT_DE_LIVRE
        ROLE_ADMIN: [ROLE_MODERATEUR, ROLE_EDITION_DE_LIVRE]
```

```php
<?php
if ($this->isGranted(‘ROLE_AJOUT_DE_LIVRE’) {
//…
}
```

Les utilisateurs qui ont le rôle ROLE_ADMIN pourront passer, même si on ne leur a pas explicitement ajouté le rôle ROLE_AJOUT_DE_LIVRE.


# Les Voters personnalisés.

```php
Implémenter l’interface Symfony\Component\Security\Core\Authorization\Voter\VoterInterface .

Ou, étendre la classe abstraite Symfony\Component\Security\Core\Authorization\Voter\Voter qui implémente déjà l’interface et nous offre deux méthodes à implémenter obligatoirement :

supports(string $attribute, mixed $subject): bool . Elle reçoit l’attribut qui a été passé en premier argument à isGranted ainsi qu’un éventuel second argument, et renvoie true si le Voter peut prendre une décision, false s'il s'abstient.

voteOnAttribute(string $attribute, mixed $subject, TokenInterface $token): bool)  . Elle reçoit aussi l’attribut, le sujet éventuel, et l’objet  TokenInterface contenant notre utilisateur. Elle renvoie ensuite true pour autoriser l’accès, false pour le refuser.
```

OrganiseR le code en mettant les classes dans des dossiers sémantiques (des dossiers dont le nom évoque la fonction des classes qu'ils contiennent).

Vérifier systématiquement que l'utilisateur qu'on récupère n'est pas null.

# Restreindre les schémas de route grâce à la configuration.

Mécanisme permettant de restreindre un grand nombre de routes très facilement et rapidement.

```yaml
config/packages/security.yaml  et regardez en bas du fichier, en dessous des firewalls :

security:
# …
    # Easy way to control access for large sections of your site
    # Note: Only the *first* access control that matches will be used
    access_control:
    # - { path: ^/admin, roles: ROLE_ADMIN }
    # - { path: ^/profile, roles: ROLE_USER }
```
Pour pouvoir accéder à toutes les routes qui commencent par /admin, il faudra être un utilisateur qui possède le rôle ROLE_ADMIN.

Les règles n’ont pas forcément à se baser sur des chemins uniquement. De nombreuses autres options sont disponibles, comme les restrictions par adresse ip, par host, et bien d’autres encore.

# En résumé.
- Demander des contrôles d’accès grâce aux nombreuses versions de la méthode isGranted.
- Ensuite, Symfony appelle des Voters, qui peuvent s’abstenir, accorder l'accès ou le refuser.
- Le comportement par défaut vérifie des rôles. (?)
- On peut faire ses propres Voters pour implémenter des restrictions spécifiques.
- La section access_control du fichier security.yaml permet de restreindre des sections entières de l'application.


