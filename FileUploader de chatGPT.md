Rebonjour à vous ! 😊 Bien sûr, je serais ravi de vous reparler du fichier `FileUploader.php` dans un projet Symfony.

---

### 📂 `FileUploader.php` — À quoi sert-il ?

Dans un projet Symfony, le fichier `FileUploader.php` est **un service personnalisé** que l’on crée pour **gérer l’upload de fichiers** (images, documents, etc.). Il permet d'encapsuler la logique d'enregistrement des fichiers dans un endroit centralisé et réutilisable.

---

### 🧱 Structure typique du fichier `FileUploader.php`

Voici un exemple simple d’un tel service :

```php
// src/Service/FileUploader.php
namespace App\Service;

use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\String\Slugger\SluggerInterface;

class FileUploader
{
    private string $targetDirectory;
    private SluggerInterface $slugger;

    public function __construct(string $targetDirectory, SluggerInterface $slugger)
    {
        $this->targetDirectory = $targetDirectory;
        $this->slugger = $slugger;
    }

    public function upload(UploadedFile $file): string
    {
        $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $safeFilename = $this->slugger->slug($originalFilename);
        $newFilename = $safeFilename.'-'.uniqid().'.'.$file->guessExtension();

        $file->move($this->getTargetDirectory(), $newFilename);

        return $newFilename;
    }

    public function getTargetDirectory(): string
    {
        return $this->targetDirectory;
    }
}
```

---

### ⚙️ Configuration du service

Dans `services.yaml` :

```yaml
# config/services.yaml
parameters:
    uploads_directory: '%kernel.project_dir%/public/uploads'

services:
    App\Service\FileUploader:
        arguments:
            $targetDirectory: '%uploads_directory%'
```

---

### 🧪 Utilisation dans un contrôleur

```php
use App\Service\FileUploader;
use Symfony\Component\HttpFoundation\Request;

public function upload(Request $request, FileUploader $fileUploader)
{
    $form = $this->createForm(DocumentType::class);
    $form->handleRequest($request);

    if ($form->isSubmitted() && $form->isValid()) {
        $uploadedFile = $form->get('file')->getData();
        if ($uploadedFile) {
            $filename = $fileUploader->upload($uploadedFile);
            // Sauvegarder le nom dans l'entité, etc.
        }
    }

    // ...
}
```

---

Souhaitez-vous que je vous génère un exemple complet avec le formulaire, l'entité, ou que je vous aide à l'adapter à un cas précis (comme des images de profil ou des PDF) ?


# ###################################################################
# -------------------------------------------------------------------
# ###################################################################

Est-ce que cette classe 'FileUploader' est dans Symfony "d'origine" ?

Excellente question : **non**, la classe `FileUploader` **n’est pas une classe native de Symfony**. Elle n’existe pas "d’origine" dans le framework.

---

### 🔍 D'où vient-elle alors ?

La classe `FileUploader` est une **création personnalisée** qu'on trouve souvent dans les **tutoriels Symfony** (comme la [doc officielle sur le téléchargement de fichiers](https://symfony.com/doc/current/controller/upload_file.html)). Elle sert de **bon exemple pour organiser proprement le code** lié aux uploads, mais Symfony ne la fournit pas par défaut.

---

### 📦 Ce que Symfony fournit réellement

Symfony fournit plutôt :

* La classe [`UploadedFile`](https://symfony.com/doc/current/components/http_foundation.html#file-uploads), via le composant **HttpFoundation**.
* Les composants pour les formulaires (`Form`, `FileType`) qui vous permettent d’intégrer des champs de type fichier.
* Le service `SluggerInterface` (dans le composant `String`) pour générer des noms de fichiers "safe".

Mais toute la logique de :

* Renommer proprement le fichier,
* Le déplacer dans un répertoire cible,
* Gérer les doublons ou erreurs,
  … est à votre charge. C’est pour ça qu’on crée souvent un petit service comme `FileUploader`.

Souhaitez-vous que je vous montre une version plus avancée ou sécurisée de cette classe, ou bien que je vous aide à l’intégrer dans votre propre projet ?


# ###################################################################
# -------------------------------------------------------------------
# ###################################################################


Très bien ! Voici une **version avancée et sécurisée** de la classe `FileUploader`, avec les améliorations suivantes :

---

### ✅ **Améliorations apportées :**

1. **Validation d’extension et de taille** (en option).
2. **Génération d’un nom de fichier aléatoire + conservé dans un sous-répertoire optionnel.**
3. **Gestion propre des erreurs (try/catch + exceptions).**
4. **Possibilité de supprimer un fichier uploadé.**

---

### 🛡️ `FileUploader.php` — version avancée

```php
// src/Service/FileUploader.php
namespace App\Service;

use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\String\Slugger\SluggerInterface;
use Symfony\Component\Mime\MimeTypes;

class FileUploader
{
    private string $targetDirectory;
    private SluggerInterface $slugger;

    private array $allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'docx'];
    private int $maxFileSize = 5 * 1024 * 1024; // 5 Mo

    public function __construct(string $targetDirectory, SluggerInterface $slugger)
    {
        $this->targetDirectory = $targetDirectory;
        $this->slugger = $slugger;
    }

    public function upload(UploadedFile $file, string $subdirectory = ''): string
    {
        $this->validate($file);

        $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $safeFilename = $this->slugger->slug($originalFilename);
        $extension = $file->guessExtension() ?? 'bin';
        $newFilename = $safeFilename . '-' . uniqid() . '.' . $extension;

        $destination = $this->getTargetDirectory($subdirectory);

        try {
            $file->move($destination, $newFilename);
        } catch (FileException $e) {
            throw new \RuntimeException('Échec de l’envoi du fichier : ' . $e->getMessage());
        }

        return ($subdirectory ? $subdirectory . '/' : '') . $newFilename;
    }

    public function delete(string $filename): bool
    {
        $fullPath = $this->targetDirectory . '/' . $filename;
        if (file_exists($fullPath)) {
            return unlink($fullPath);
        }
        return false;
    }

    public function validate(UploadedFile $file): void
    {
        if ($file->getSize() > $this->maxFileSize) {
            throw new \RuntimeException('Fichier trop volumineux. Maximum autorisé : ' . $this->maxFileSize / 1024 / 1024 . ' Mo');
        }

        $extension = $file->guessExtension();
        if (!in_array($extension, $this->allowedExtensions)) {
            throw new \RuntimeException('Extension de fichier non autorisée : ' . $extension);
        }
    }

    private function getTargetDirectory(string $subdirectory = ''): string
    {
        $path = rtrim($this->targetDirectory, '/');
        if ($subdirectory) {
            $path .= '/' . trim($subdirectory, '/');
            if (!is_dir($path)) {
                mkdir($path, 0755, true);
            }
        }
        return $path;
    }
}
```

---

### 🛠️ Configuration dans `services.yaml`

```yaml
parameters:
    uploads_directory: '%kernel.project_dir%/public/uploads'

services:
    App\Service\FileUploader:
        arguments:
            $targetDirectory: '%uploads_directory%'
```

---

### 🧪 Exemple d'utilisation dans un contrôleur

```php
$uploadedFile = $form->get('file')->getData();

if ($uploadedFile) {
    try {
        $filename = $fileUploader->upload($uploadedFile, 'documents');
        $entity->setFileName($filename);
    } catch (\RuntimeException $e) {
        $this->addFlash('danger', 'Erreur lors de l\'upload : ' . $e->getMessage());
    }
}
```

---

Souhaitez-vous aussi une méthode pour **remplacer un fichier existant** (avec suppression de l’ancien fichier) ou gérer une **miniature automatique pour les images** ?


# ###################################################################
# -------------------------------------------------------------------
# ###################################################################


Parfait ! Voici une version complète et **encore plus robuste** de `FileUploader.php`, avec :

---

### ✅ NOUVELLES FONCTIONNALITÉS :

1. ✅ Remplacement d’un fichier existant (avec suppression automatique).
2. 🖼️ Création automatique de **miniatures pour les images** (JPEG, PNG).
3. 💡 Modularité : on peut activer ou désactiver chaque fonction selon les besoins.

---

## 📂 Fichier : `FileUploader.php`

```php
// src/Service/FileUploader.php
namespace App\Service;

use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\String\Slugger\SluggerInterface;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\Mime\MimeTypes;

class FileUploader
{
    private string $targetDirectory;
    private SluggerInterface $slugger;

    private array $allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'docx'];
    private int $maxFileSize = 5 * 1024 * 1024; // 5 Mo

    public function __construct(string $targetDirectory, SluggerInterface $slugger)
    {
        $this->targetDirectory = rtrim($targetDirectory, '/');
        $this->slugger = $slugger;
    }

    public function upload(UploadedFile $file, string $subdirectory = '', ?string $oldFilename = null, bool $generateThumbnail = false): string
    {
        $this->validate($file);

        $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $safeFilename = $this->slugger->slug($originalFilename);
        $extension = $file->guessExtension() ?? 'bin';
        $newFilename = $safeFilename . '-' . uniqid() . '.' . $extension;

        $destination = $this->getTargetDirectory($subdirectory);

        try {
            $file->move($destination, $newFilename);

            // Supprimer l'ancien fichier si présent
            if ($oldFilename) {
                $this->delete(($subdirectory ? $subdirectory . '/' : '') . $oldFilename);
            }

            // Générer une miniature si demandé
            if ($generateThumbnail && in_array(strtolower($extension), ['jpg', 'jpeg', 'png'])) {
                $this->generateThumbnail($destination . '/' . $newFilename, $destination . '/thumb_' . $newFilename);
            }

        } catch (FileException $e) {
            throw new \RuntimeException('Échec de l’envoi du fichier : ' . $e->getMessage());
        }

        return ($subdirectory ? $subdirectory . '/' : '') . $newFilename;
    }

    public function delete(string $relativePath): bool
    {
        $fullPath = $this->targetDirectory . '/' . $relativePath;
        if (file_exists($fullPath)) {
            return unlink($fullPath);
        }
        return false;
    }

    public function validate(UploadedFile $file): void
    {
        if ($file->getSize() > $this->maxFileSize) {
            throw new \RuntimeException('Fichier trop volumineux. Maximum autorisé : ' . $this->maxFileSize / 1024 / 1024 . ' Mo');
        }

        $extension = $file->guessExtension();
        if (!in_array($extension, $this->allowedExtensions)) {
            throw new \RuntimeException('Extension de fichier non autorisée : ' . $extension);
        }
    }

    private function getTargetDirectory(string $subdirectory = ''): string
    {
        $path = $this->targetDirectory;
        if ($subdirectory) {
            $path .= '/' . trim($subdirectory, '/');
            if (!is_dir($path)) {
                mkdir($path, 0755, true);
            }
        }
        return $path;
    }

    private function generateThumbnail(string $sourcePath, string $thumbPath, int $width = 200, int $height = 200): void
    {
        [$srcWidth, $srcHeight, $type] = getimagesize($sourcePath);

        switch ($type) {
            case IMAGETYPE_JPEG:
                $srcImage = imagecreatefromjpeg($sourcePath);
                break;
            case IMAGETYPE_PNG:
                $srcImage = imagecreatefrompng($sourcePath);
                break;
            default:
                throw new \RuntimeException('Type d\'image non supporté pour la miniature.');
        }

        $thumbImage = imagecreatetruecolor($width, $height);

        // Resize et crop (centré)
        $aspectRatioSrc = $srcWidth / $srcHeight;
        $aspectRatioThumb = $width / $height;

        if ($aspectRatioSrc > $aspectRatioThumb) {
            // Image plus large
            $newHeight = $height;
            $newWidth = intval($height * $aspectRatioSrc);
        } else {
            // Image plus haute
            $newWidth = $width;
            $newHeight = intval($width / $aspectRatioSrc);
        }

        $tempImage = imagecreatetruecolor($newWidth, $newHeight);
        imagecopyresampled($tempImage, $srcImage, 0, 0, 0, 0, $newWidth, $newHeight, $srcWidth, $srcHeight);

        // Crop au centre
        $x = intval(($newWidth - $width) / 2);
        $y = intval(($newHeight - $height) / 2);
        imagecopy($thumbImage, $tempImage, 0, 0, $x, $y, $width, $height);

        imagejpeg($thumbImage, $thumbPath, 90);

        imagedestroy($srcImage);
        imagedestroy($thumbImage);
        imagedestroy($tempImage);
    }
}
```

---

### 🧪 Exemple d’utilisation dans un contrôleur

```php
if ($uploadedFile) {
    try {
        $filename = $fileUploader->upload(
            $uploadedFile,
            'profiles',
            $user->getProfileImage(),   // ancien fichier à supprimer
            true                        // générer une miniature
        );
        $user->setProfileImage($filename);
    } catch (\RuntimeException $e) {
        $this->addFlash('danger', 'Erreur d’upload : ' . $e->getMessage());
    }
}
```

---

### 📁 Résultat :

* Image : `public/uploads/profiles/photo-abc123.jpg`
* Miniature : `public/uploads/profiles/thumb_photo-abc123.jpg`

---

Souhaitez-vous aussi que je vous fournisse une méthode pour **afficher la miniature dans Twig**, ou pour **paramétrer les tailles dynamiquement** ?


# ###################################################################
# -------------------------------------------------------------------
# ###################################################################


Parfait, poursuivons ! Voici comment **afficher les miniatures dans Twig** et éventuellement **rendre la taille configurable** de manière propre et souple.

---

## 🖼️ **Afficher une miniature dans Twig**

### 1. ✅ Structure de fichier prévue

Lorsque vous uploadez une image avec `FileUploader`, vous obtenez :

* L’image principale : `uploads/profiles/photo-abc123.jpg`
* La miniature : `uploads/profiles/thumb_photo-abc123.jpg`

### 2. 🧩 Exemple d'affichage Twig

```twig
{# templates/profile/show.html.twig #}
<img src="{{ asset('uploads/profiles/thumb_' ~ user.profileImage) }}" alt="Miniature de l'image" />
```

⚠️ Il faut bien sûr que `user.profileImage` retourne par exemple `photo-abc123.jpg`.

---

## ⚙️ **Taille dynamique des miniatures (optionnel)**

Si vous souhaitez créer des miniatures avec des **tailles différentes** selon le contexte, modifions le service pour accepter des dimensions dynamiques.

### 🔧 Modification dans `upload()` et `generateThumbnail()` :

```php
// Dans upload()
if ($generateThumbnail) {
    [$thumbWidth, $thumbHeight] = $thumbnailSize ?? [200, 200];
    $this->generateThumbnail(
        $destination . '/' . $newFilename,
        $destination . '/thumb_' . $newFilename,
        $thumbWidth,
        $thumbHeight
    );
}
```

Puis modifiez la signature du `upload()` :

```php
public function upload(
    UploadedFile $file,
    string $subdirectory = '',
    ?string $oldFilename = null,
    bool $generateThumbnail = false,
    ?array $thumbnailSize = null
): string
```

### ✅ Utilisation depuis un contrôleur avec tailles personnalisées

```php
$filename = $fileUploader->upload(
    $uploadedFile,
    'profiles',
    $user->getProfileImage(),
    true,
    [300, 300] // miniature 300x300 px
);
```

---

## 🔚 Résumé rapide

* ✅ Miniature générée et supprimée proprement
* ✅ Utilisable depuis Twig sans ajout de service
* ✅ Extensible pour plusieurs tailles
* ✅ Sécurisé contre les extensions interdites et les fichiers volumineux

---

Souhaitez-vous aussi un **command Symfony** pour nettoyer automatiquement les miniatures orphelines, ou un **service Twig** pour générer les URLs de miniature automatiquement ?


# ###################################################################
# -------------------------------------------------------------------
# ###################################################################


Excellent choix ✅ — stocker les fichiers **en dehors de `public/`** est **nettement plus sécurisé**, surtout si ces fichiers contiennent des données personnelles, des PDF confidentiels, ou tout ce qui ne doit pas être accessible librement via URL.

---

### 🛡️ Raisons de stocker hors de `public/` :

* Empêche un accès direct aux fichiers par URL (`https://example.com/uploads/...`)
* Permet de mieux **contrôler l’accès** aux documents via Symfony (ex : vérification d'identité avant envoi)
* Donne plus de liberté pour organiser, déplacer ou supprimer des fichiers sans exposer leur structure au navigateur

---

### ✅ Nouvelle version de la méthode `upload()` (hors `public/`)

Voici une version adaptée :

```php
public function upload(
    UploadedFile $file,
    int|string $userId,
    string $category = 'documents',
    ?string $oldFilename = null,
    bool $generateThumbnail = false,
    ?array $thumbnailSize = null
): string {
    $this->validate($file);

    $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
    $safeFilename = $this->slugger->slug($originalFilename);
    $extension = strtolower($file->guessExtension() ?? 'bin');
    $newFilename = $safeFilename . '-' . uniqid() . '.' . $extension;

    // Ex : 'users/42/documents'
    $relativePath = 'users/' . $userId . '/' . $category;

    // Dossier absolu en dehors de public/
    $destination = $this->getSecureStorageDirectory($relativePath);

    if (!is_dir($destination)) {
        if (!mkdir($destination, 0775, true) && !is_dir($destination)) {
            throw new \RuntimeException("Impossible de créer le répertoire : $destination");
        }
    }

    try {
        $file->move($destination, $newFilename);

        if ($oldFilename) {
            $this->delete($relativePath . '/' . $oldFilename);
        }

        if ($generateThumbnail && in_array($extension, ['jpg', 'jpeg', 'png'])) {
            [$thumbWidth, $thumbHeight] = $thumbnailSize ?? [200, 200];
            $this->generateThumbnail(
                $destination . '/' . $newFilename,
                $destination . '/thumb_' . $newFilename,
                $thumbWidth,
                $thumbHeight
            );
        }

    } catch (FileException $e) {
        throw new \RuntimeException('Échec de l’envoi du fichier : ' . $e->getMessage());
    }

    // Retourne le chemin RELATIF (pour stockage en base par exemple)
    return $relativePath . '/' . $newFilename;
}
```

---

### 🔧 `getSecureStorageDirectory()`

Défini comme :

```php
public function getSecureStorageDirectory(string $subdirectory = ''): string
{
    return $this->privateStorageDir . ($subdirectory ? '/' . trim($subdirectory, '/') : '');
}
```

Où `$this->privateStorageDir` pourrait être par exemple :

```php
$this->privateStorageDir = $projectDir . '/var/storage';
```

(NB : `$projectDir` est injecté par Symfony via `%kernel.project_dir%`)

---

### 📦 Pour servir les fichiers : utiliser une action Symfony

Exemple de contrôleur pour envoyer un fichier **de manière sécurisée** :

```php
#[Route('/download/{userId}/{category}/{filename}', name: 'secure_file_download')]
public function downloadFile(string $userId, string $category, string $filename): Response
{
    $this->denyAccessUnlessGranted('DOWNLOAD', $userId); // Ajoute ton contrôle ici

    $filePath = $this->storageService->getSecureStorageDirectory("users/$userId/$category") . '/' . $filename;

    if (!file_exists($filePath)) {
        throw $this->createNotFoundException();
    }

    return $this->file($filePath);
}
```

---

Souhaitez-vous que je vous fournisse un service complet `SecureStorageService` avec injection des chemins et méthodes pour la lecture, suppression, et téléchargement ?


# ###################################################################
# -------------------------------------------------------------------
# ###################################################################


Absolument, et vous faites bien de demander !

---

### 🧠 Ce que cela signifie

Dans Symfony, vous avez accès à certaines **variables spéciales** que Symfony injecte dans vos services ou vos classes — l’une d’elles est :

> 🔹 **`%kernel.project_dir%`** : c’est le chemin **absolu vers la racine de votre projet Symfony**.

Par exemple, si votre projet est situé dans :

```
/home/votre-nom/mes-projets/mon-site-symfony/
```

alors :

```yaml
%kernel.project_dir% = /home/votre-nom/mes-projets/mon-site-symfony
```

---

### 📂 Pourquoi `var/storage` ?

C’est un bon emplacement **hors de `public/`** pour stocker les fichiers **privés** (non accessibles directement depuis le navigateur).
Dans Symfony, on utilise souvent le répertoire `var/` pour :

* les logs,
* les caches,
* les fichiers temporaires,
* les fichiers persistants internes (comme ici).

Donc, si vous combinez :

```php
$projectDir . '/var/storage'
```

Vous obtenez un dossier comme :

```
/home/votre-nom/mes-projets/mon-site-symfony/var/storage
```

---

### ✅ Comment faire concrètement ?

Dans votre **service d'upload**, injectez le chemin depuis les paramètres Symfony :

```yaml
# config/services.yaml
parameters:
    app.private_upload_dir: '%kernel.project_dir%/var/storage'
```

Et dans votre service PHP :

```php
private string $privateStorageDir;

public function __construct(string $privateUploadDir)
{
    $this->privateStorageDir = $privateUploadDir;
}
```

Puis configurez l’injection dans `services.yaml` :

```yaml
services:
    App\Service\YourUploadService:
        arguments:
            $privateUploadDir: '%app.private_upload_dir%'
```

---

### 🎯 Résultat

Votre service connaît désormais le chemin absolu vers un dossier **non public**, sécurisé, et structuré proprement dans `var/storage`.

Souhaitez-vous que je vous donne un `SecureStorageService` complet basé sur ce principe ?
