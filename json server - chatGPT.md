Excellente question ! Si ton composant ReactJS fait un `fetch('http://localhost:3001/articles')`, alors \*\*au bout de cette URL, il doit y avoir une **API** qui retourne des **données JSON**, très probablement une **liste d’articles**.

---

## 🔎 Donc, que devrait-il y avoir à `http://localhost:3001/articles` ?

Typiquement :
🟢 Une **API REST** (locale) qui renvoie une réponse comme :

```json
[
  {
    "id": 1,
    "titre": "Premier article",
    "contenu": "Ceci est le contenu du premier article"
  },
  {
    "id": 2,
    "titre": "Deuxième article",
    "contenu": "Un autre article intéressant"
  }
]
```

---

## 🧰 Cas très courant : tu utilises **JSON Server** ?

Si tu travailles en local, il est probable que l’URL `http://localhost:3001/articles` pointe vers un **faux serveur API** démarré avec **[JSON Server](https://github.com/typicode/json-server)**.

### Exemple de fichier `db.json` utilisé avec JSON Server :

```json
{
  "articles": [
    {
      "id": 1,
      "titre": "Article 1",
      "contenu": "Texte de l'article 1"
    },
    {
      "id": 2,
      "titre": "Article 2",
      "contenu": "Texte de l'article 2"
    }
  ]
}
```

Tu lances ensuite JSON Server avec :

```bash
npx json-server --watch db.json --port 3001
```

Et alors :
✅ `GET http://localhost:3001/articles` te donne un tableau JSON
✅ `POST`, `PUT`, `DELETE` fonctionnent aussi automatiquement

---

## 🧪 Pour vérifier

Dans ton navigateur ou via un outil comme Postman ou `curl` :

```bash
curl http://localhost:3001/articles
```

Si tu obtiens une réponse JSON, alors tout est OK ✅
Si tu obtiens une erreur (connexion refusée, 404...), alors l'API ne tourne pas encore.

---

Souhaites-tu que je t’aide à configurer rapidement `JSON Server` si ce n’est pas encore en place ?




Parfait, allons-y étape par étape pour **mettre en place JSON Server**, un faux backend très pratique pour tester des appels API dans une app ReactJS.

---

## 🧰 Objectif

Simuler une API REST locale accessible à `http://localhost:3001/articles`.

---

## ✅ Étapes pour installer et lancer JSON Server

---

### 📦 1. Installer JSON Server

Si tu ne l’as pas encore :

```bash
npm install -g json-server
```

> Le `-g` signifie que tu l’installes globalement, accessible depuis n’importe quel projet.

---

### 🗃 2. Créer un fichier `db.json`

Dans ton dossier de projet (ou ailleurs), crée un fichier `db.json` :

```json
{
  "articles": [
    {
      "id": 1,
      "titre": "Bonjour React",
      "contenu": "Ceci est un article de test"
    },
    {
      "id": 2,
      "titre": "Deuxième article",
      "contenu": "Un autre article sympa"
    }
  ]
}
```

---

### 🚀 3. Lancer le serveur JSON

Dans le dossier où se trouve `db.json` :

```bash
json-server --watch db.json --port 3001
```

✅ Le serveur écoute sur `http://localhost:3001`

---

### 📌 4. Vérifie dans ton navigateur

Va ici :
🔗 `http://localhost:3001/articles`

Tu devrais voir un tableau JSON :

```json
[
  { "id": 1, "titre": "...", "contenu": "..." },
  { "id": 2, "titre": "...", "contenu": "..." }
]
```

---

## 🧪 Bonus : utiliser avec React

Dans ton code React, tu peux faire :

```js
fetch('http://localhost:3001/articles')
  .then(res => res.json())
  .then(data => setArticles(data));
```

Et voilà : ton appli récupère dynamiquement les articles simulés 🎉

---

Souhaites-tu que je t’aide à écrire un composant React qui affiche les articles de cette fausse API ?
