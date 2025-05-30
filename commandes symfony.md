symfony server:status
    Web server listening on http://127.0.0.1:8000

symfony console cache:clear

symfony console make:registration-form
    Next:
    1) Install some missing packages:
        composer require symfonycasts/verify-email-bundle
    2) In RegistrationController::verifyUserEmail():
        * Customize the last redirectToRoute() after a successful email verification.
        * Make sure you're rendering success flash messages or change the $this->addFlash() line.
    3) Review and customize the form, controller, and templates as needed.
    4) Run "symfony console make:migration" to generate a migration for the newly added Utilisateur::isVerified property.

    Then open your browser, go to "/register" and enjoy your new form!

composer require symfonycasts/verify-email-bundle

symfony console make:migration

symfony console doctrine:migrations:migrate

symfony console doctrine:fixtures:load

symfony console make:security:form-login

Symfony s’appuie sur l’autoloading PSR-4 géré par Composer. Parfois, si tu as déplacé ou renommé un fichier sans relancer l'autoloader, Symfony ne le trouve plus. Exécute :
composer dump-autoload



🚀 1. Symfony Notifier (composant natif) + Provider

Symfony a son propre composant pour ça : symfony/notifier, qui gère les notifications via SMS, email, chat, etc. Tu peux l’utiliser avec plusieurs fournisseurs (providers) comme Twilio, Nexmo (Vonage), ou d'autres.
✅ Avantages :

    Intégré au framework Symfony

    Unifié pour SMS, email, Slack, etc.

    Bien documenté

📦 Installation de base :

composer require symfony/notifier

➕ Exemple avec Twilio (pour SMS & WhatsApp) :

composer require symfony/twilio-notifier

Dans ton .env :

TWILIO_DSN=twilio://SID:TOKEN@default?from=TON_NUMÉRO

Ensuite, dans ton code :

use Symfony\Component\Notifier\NotifierInterface;
use Symfony\Component\Notifier\Notification\Notification;
use Symfony\Component\Notifier\Recipient\SmsRecipient;

$notification = new Notification('Hello from Symfony!', ['sms']);
$recipient = new SmsRecipient('+33612345678');

$notifier->send($notification, $recipient);

    ⚠️ Pour WhatsApp avec Twilio, il faut activer leur sandbox, et les messages s’envoient vers des numéros vérifiés. DSN WhatsApp ressemble à :

TWILIO_DSN=twilio://SID:TOKEN@default?from=whatsapp:+14155238886




