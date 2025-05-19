Avec plaisir ! Voici un **exemple complet** (FormType, contrôleur, template Twig) pour illustrer comment utiliser un seul formulaire à la fois pour l’**ajout** et pour l’**édition**, avec un champ (`champSpecial`) :

* visible dans les deux cas (si on veut),
* mais **mappé uniquement à l’ajout** (ignoré en édition).

---

## 🧩 1. **L’Entité :** `Produit.php`

```php
namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Produit
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $nom = null;

    // Ce champ est persisté
    public function getId(): ?int { return $this->id; }
    public function getNom(): ?string { return $this->nom; }
    public function setNom(string $nom): self { $this->nom = $nom; return $this; }
}
```

---

## 🧾 2. **Le FormType :** `ProduitType.php`

```php
namespace App\Form;

use App\Entity\Produit;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ProduitType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $isEdit = $options['is_edit'];

        $builder
            ->add('nom', TextType::class, [
                'label' => 'Nom du produit',
            ])
            ->add('champSpecial', TextType::class, [
                'label' => 'Champ spécial (ajout seulement)',
                'mapped' => false,       // non mappé à l'entité
                'required' => !$isEdit,  // requis seulement à l'ajout
            ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Produit::class,
            'is_edit' => false,
        ]);
    }
}
```

---

## 🎮 3. **Le contrôleur :** `ProduitController.php`

```php
namespace App\Controller;

use App\Entity\Produit;
use App\Form\ProduitType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

class ProduitController extends AbstractController
{
    #[Route('/produit/nouveau', name: 'produit_ajout')]
    public function ajouter(Request $request, EntityManagerInterface $em): Response
    {
        $produit = new Produit();

        $form = $this->createForm(ProduitType::class, $produit, [
            'is_edit' => false,
        ]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // Le champSpecial est accessible via $form->get('champSpecial')->getData()
            $valeurChampSpecial = $form->get('champSpecial')->getData();
            // Tu peux l'utiliser ici comme tu veux
            $em->persist($produit);
            $em->flush();

            return $this->redirectToRoute('produit_liste');
        }

        return $this->render('produit/form.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    #[Route('/produit/{id}/modifier', name: 'produit_modifier')]
    public function modifier(Produit $produit, Request $request, EntityManagerInterface $em): Response
    {
        $form = $this->createForm(ProduitType::class, $produit, [
            'is_edit' => true,
        ]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // champSpecial n'est pas mappé, donc ignoré ici
            $em->flush();

            return $this->redirectToRoute('produit_liste');
        }

        return $this->render('produit/form.html.twig', [
            'form' => $form->createView(),
        ]);
    }
}
```

---

## 🖼️ 4. **Le template Twig :** `templates/produit/form.html.twig`

```twig
<h1>Formulaire Produit</h1>

{{ form_start(form) }}

    {{ form_row(form.nom) }}
    {{ form_row(form.champSpecial) }}

    <button class="btn btn-primary">Valider</button>

{{ form_end(form, { render_rest: false }) }}
```

---

## ✅ Résultat

| Champ          | Mode "Ajout"                         | Mode "Édition"                      |
| -------------- | ------------------------------------ | ----------------------------------- |
| `nom`          | Saisi, mappé                         | Saisi, mappé                        |
| `champSpecial` | Saisi, **non mappé** mais utilisable | Affiché, **ignoré** à la soumission |

Tu peux même **ne pas l'afficher du tout** en édition via un `if` Twig si tu veux pousser la logique plus loin.

---

Souhaites-tu qu’on ajoute une logique métier liée à `champSpecial` (ex : calculer quelque chose ou conditionner un champ masqué) ?
