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




