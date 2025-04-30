Parfait ! Voici un **récapitulatif clair et organisé** de ce que tu as mis en place aujourd’hui dans ton projet Symfony 👇

---

## 🧱 **Objectif**

Afficher des **contrats** dont les **utilisateurs ont le rôle `ROLE_CLIENT`**, en utilisant Doctrine, Twig et un `Voter` personnalisé.

---

## 🧩 1. **Voter personnalisé basé sur des expressions régulières**

### Fichier : `src/Security/Voter/DynamicRoleRegexVoter.php`

```php
namespace App\Security\Voter;

use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Authorization\Voter\Voter;
use Symfony\Component\Security\Core\User\UserInterface;

class DynamicRoleRegexVoter extends Voter
{
    protected function supports(string $attribute, mixed $subject): bool
    {
        return str_starts_with($attribute, 'REGEX:');
    }

    protected function voteOnAttribute(string $attribute, mixed $subject, TokenInterface $token): bool
    {
        $user = $token->getUser();

        if (!$user instanceof UserInterface) {
            return false;
        }

        $regex = substr($attribute, strlen('REGEX:'));

        foreach ($user->getRoles() as $role) {
            if (preg_match('/' . $regex . '/', $role)) {
                return true;
            }
        }

        return false;
    }
}
```

### Et dans `services.yaml` :

```yaml
services:
    App\Security\Voter\DynamicRoleRegexVoter:
        tags: ['security.voter']
```

---

## 🔐 2. **Utilisation du Voter dans un contrôleur**

```php
#[IsGranted('REGEX:^ROLE_EMPLOYE')]
public function listeDesComptesClients(ContratRepository $repo): Response
```

---

## 🔍 3. **Doctrine : récupérer les contrats des utilisateurs ayant `ROLE_CLIENT`**

### Dans `ContratRepository.php` :

```php
public function findContratsDesClients(): array
{
    return $this->createQueryBuilder('c')
        ->join('c.utilisateur', 'u')
        ->andWhere('JSON_CONTAINS(u.roles, :role) = 1')
        ->setParameter('role', json_encode('ROLE_CLIENT'))
        ->getQuery()
        ->getResult();
}
```

> ⚠️ Fonctionne si la base supporte `JSON_CONTAINS` (MySQL 5.7+, MariaDB 10.2+).

---

## 🖥️ 4. **Debug dans Twig**

### Afficher une variable dans Twig (dans la barre Symfony) :

```twig
{{ dump(variable) }}
```

### Tout afficher :

```twig
{{ dump() }}
```

### Pour voir directement dans la page :

```twig
<pre>{{ dump(variable)|raw }}</pre>
```

---

## ✅ Résultat attendu

Tu peux maintenant :
- Contrôler l’accès à une page avec un rôle dynamique (regex sur rôle),
- Récupérer uniquement les contrats des clients,
- Déboguer proprement dans Twig.

---

Souhaites-tu que je t’exporte ce résumé sous forme de fichier `.md` ou `.pdf` pour que tu le gardes avec toi ?