Avec plaisir ! Voici une **palette de couleurs personnalisées** prête à l’emploi, à intégrer dans votre fichier CSS principal (`app.css`), dans une section `:root`. Elle suit les conventions Bootstrap (`--bd-*`) mais vous pouvez bien sûr adapter les noms.

---

## 🎨 **Palette de couleurs personnalisées – à placer dans `:root`**

```css
:root {
  /* Couleurs principales */
  --bd-primary: #6f42c1;     /* Violet Bootstrap */
  --bd-secondary: #6c757d;   /* Gris moyen */
  --bd-success: #198754;     /* Vert Bootstrap */
  --bd-danger: #dc3545;      /* Rouge vif */
  --bd-warning: #ffc107;     /* Jaune/orangé */
  --bd-info: #0dcaf0;        /* Bleu clair */
  --bd-light: #f8f9fa;       /* Presque blanc */
  --bd-dark: #212529;        /* Presque noir */

  /* Couleurs complémentaires */
  --bd-blue: #0d6efd;
  --bd-indigo: #6610f2;
  --bd-purple: #6f42c1;
  --bd-pink: #d63384;
  --bd-red: #dc3545;
  --bd-orange: #fd7e14;
  --bd-yellow: #ffc107;
  --bd-green: #198754;
  --bd-teal: #20c997;
  --bd-cyan: #0dcaf0;

  /* Utilitaires */
  --bd-white: #fff;
  --bd-black: #000;
  --bd-muted: #6c757d;
  --bd-border: #dee2e6;
  --bd-bg: #f5f5f5;
}
```

---

## ✅ Exemple d’utilisation

```css
.custom-tooltip {
  --bs-tooltip-bg: var(--bd-purple);
  --bs-tooltip-color: var(--bd-white);
}
```

Ou bien pour des boutons :

```css
.btn-custom-primary {
  background-color: var(--bd-primary);
  color: var(--bd-white);
  border: none;
}
```

---

## 💡 Astuce bonus : importer depuis un fichier dédié

Vous pouvez aussi mettre ces variables dans un fichier séparé :

```
assets/styles/utils/_variables.css
```

Puis les importer dans `app.css` :

```css
@import './utils/variables.css';
```

---

Souhaitez-vous aussi une suggestion pour des **couleurs adaptées aux thèmes sombre/clair** (mode dark/light) via media queries ?


# ===================================================================
# ###################################################################
# ===================================================================


Parfait, voici comment ajouter **un système de variables CSS adaptatives** pour prendre en charge automatiquement les **thèmes clair et sombre** (dark mode / light mode) grâce aux media queries natives de CSS.

---

## 🎨 Variables CSS pour thème clair et sombre

Placez ce bloc dans votre `:root`, par exemple dans `utils/_variables.css`, ou directement dans `app.css` :

```css
/* Valeurs par défaut : thème clair */
:root {
  --bd-bg: #ffffff;
  --bd-text: #212529;
  --bd-primary: #6f42c1;
  --bd-secondary: #6c757d;
  --bd-border: #dee2e6;
  --bd-surface: #f8f9fa;
}

/* Thème sombre automatiquement activé si l'OS l'utilise */
@media (prefers-color-scheme: dark) {
  :root {
    --bd-bg: #121212;
    --bd-text: #f8f9fa;
    --bd-primary: #bb86fc;
    --bd-secondary: #b0b0b0;
    --bd-border: #2c2c2c;
    --bd-surface: #1e1e1e;
  }
}
```

---

## ✅ Exemple d'utilisation dans vos composants

```css
body {
  background-color: var(--bd-bg);
  color: var(--bd-text);
}

.card {
  background-color: var(--bd-surface);
  border: 1px solid var(--bd-border);
}

.btn-primary {
  background-color: var(--bd-primary);
  color: var(--bd-text);
}
```

---

## 🌙 Activer un thème sombre **manuellement** (optionnel)

Si vous voulez **permettre à l’utilisateur de choisir** plutôt que de suivre le système, vous pouvez utiliser des classes (`.theme-dark`, `.theme-light`) en plus des media queries.

Exemple :

```css
.theme-dark {
  --bd-bg: #121212;
  --bd-text: #f8f9fa;
  --bd-primary: #bb86fc;
  --bd-secondary: #b0b0b0;
  --bd-border: #2c2c2c;
  --bd-surface: #1e1e1e;
}

.theme-light {
  --bd-bg: #ffffff;
  --bd-text: #212529;
  --bd-primary: #6f42c1;
  --bd-secondary: #6c757d;
  --bd-border: #dee2e6;
  --bd-surface: #f8f9fa;
}
```

Puis dans le HTML :

```html
<body class="theme-dark">
```

Et vous pouvez changer dynamiquement la classe avec JavaScript selon les préférences utilisateur.

---

## ✅ Résumé

| Objectif                       | Solution                        |
| ------------------------------ | ------------------------------- |
| Thème selon l’OS               | `@media (prefers-color-scheme)` |
| Thème choisi par l’utilisateur | `.theme-light` / `.theme-dark`  |
| Variables centralisées         | Définies dans `:root`           |

---

Souhaitez-vous un composant HTML simple avec un **bouton de bascule jour/nuit** en JavaScript ?


# ===================================================================
# ###################################################################
# ===================================================================


