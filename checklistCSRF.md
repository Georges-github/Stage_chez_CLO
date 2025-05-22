Avec plaisir ! Voici une **checklist simple et claire** pour bien gérer la **protection CSRF dans Symfony**, surtout dans le cadre d’une application web classique avec formulaires.

---

# ✅ **Checklist CSRF dans Symfony**

---

### 🛡️ 1. **Formulaires Symfony (`FormBuilder`)**

* [ ] ✅ Utiliser le composant Form Symfony ?
  → Le **CSRF est activé automatiquement** par défaut.

* [ ] ✅ Vérifier que le formulaire contient bien :

  ```php
  'csrf_protection' => true,
  'csrf_field_name' => '_token',
  'csrf_token_id' => 'nom_action_ou_type',
  ```

* [ ] ✅ Dans le template Twig, inclure `{{ form_widget(form) }}` pour que le champ CSRF soit bien rendu.

---

### 🗑️ 2. **Formulaire manuel (ex. : bouton de suppression)**

* [ ] ✅ Ajouter un champ `hidden` :

  ```twig
  <input type="hidden" name="_token" value="{{ csrf_token('delete_post_' ~ post.id) }}">
  ```
* [ ] ✅ Vérifier le token côté contrôleur :

  ```php
  if (!$this->isCsrfTokenValid('delete_post_' . $post->getId(), $request->request->get('_token'))) {
      throw $this->createAccessDeniedException('Jeton CSRF invalide.');
  }
  ```

---

### 🧾 3. **Formulaires en `GET`**

* [ ] ✅ Aucun token CSRF requis : lecture seule = pas de modification de données.

---

### 🧪 4. **Formulaires AJAX (JavaScript)**

* [ ] ✅ Si session utilisateur utilisée : inclure manuellement un CSRF token dans l'en-tête ou le corps de la requête.
* [ ] ✅ Récupérer le token CSRF via :

  ```twig
  <meta name="csrf-token" content="{{ csrf_token('ajax_action') }}">
  ```
* [ ] ✅ Envoyer ce token dans l’en-tête AJAX :

  ```js
  fetch('/some-url', {
    method: 'POST',
    headers: {
      'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').content
    },
    body: JSON.stringify({ ... })
  });
  ```

---

### 🧱 5. **API REST ?**

* [ ] ❌ Pas de token CSRF requis **si** :

  * Tu utilises **JWT**, OAuth2 ou autre token **dans l'en-tête Authorization**.
* [ ] ✅ CSRF toujours nécessaire **si l’API utilise les cookies de session Symfony** (par défaut).

---

### ⚠️ 6. **Ne jamais faire de modification via GET**

* [ ] ✅ Toutes les actions qui **modifient des données** doivent être faites en `POST`, `PUT`, `DELETE`, etc.
* [ ] ❌ Ne jamais appeler un `/delete?id=42` via GET sans protection.

---

### 🧰 7. **Test rapide**

* [ ] ❓ Tu peux tester une suppression manuelle sans le token CSRF dans l'URL ou via Postman ?
  → Si ça passe, la route **n’est pas protégée correctement**.

---

## 🟢 Tu es protégé si :

* ✅ Tu utilises `FormBuilder`
* ✅ Tu ajoutes manuellement des tokens pour les suppressions
* ✅ Tu n’acceptes pas de modification par GET
* ✅ Tu gères les cas AJAX ou API proprement

---

Souhaites-tu un **exemple complet** d’un mini module Symfony avec suppression sécurisée par CSRF ?
