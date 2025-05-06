```php
src
    Controller
        BackEnd
            Administrateur

                /administrateur
                IS_AUTHENTICATED_FULLY
                ROLE_EMPLOYE_ADMINISTRATEUR
                AdministrateurController
                
                    app_accueil_administrateur
                    accueilAdministrateur()
                        BackEnd/Administrateur/accueilAdministrateur.html.twig

                    /listeDesEmployes , app_liste_des_employes
                    listeDesEmployes()
                        BackEnd/Administrateur/listeDesEmployes.html.twig

                    /voirUnEmploye/{id} , app_voir_un_employe
                    voirUnEmploye()
                        BackEnd/Administrateur/voirUnEmploye.html.twig

                    /editerUnEmploye/{id} , app_editer_un_employe
                    editerUnEmploye()
                        EditerUnEmployeType
                        BackEnd/Administrateur/editerUnEmploye.html.twig
                        app_liste_des_employes
                        BackEnd/Administrateur/editerUnEmploye.html.twig

                    /ajouterUnEmploye , app_ajouter_un_employe
                    ajouterUnEmploye()
                        EditerUnEmployeType
                        app_liste_des_employes
                        BackEnd/Administrateur/editerUnEmploye.html.twig

            /employe
            IS_AUTHENTICATED_FULLY
            EmployeController

                    REGEX:^ROLE_EMPLOYE
                    /listeDesComptesClients , app_liste_des_comptes_clients
                    listeDesComptesClients()
                        BackEnd/listeDesComptesClients.html.twig

        FrontEnd

            /client
            IS_AUTHENTICATED_FULLY
            ClientController

                /listeDesContrats/{id} , app_liste_des_contrats
                listeDesContrats()
                    FrontEnd/listeDesContrats.html.twig

        /etatcontrat
        EtatContratController
                app_etat_contrat_index
                index()
                /new , app_etat_contrat_new
                new()
                /{id} , app_etat_contrat_show
                show()
                /{id}/edit , app_etat_contrat_edit
                edit()
                /{id} , app_etat_contrat_delete
                delete()

        RegistrationController
            /register , app_register
            register()
            /verify/email , app_verify_email
            verifyUserEmail()

        SecurityController
            /login , app_login
            login()

        UtilisateurController
            #[Route(name: 'app_utilisateur_index', methods: ['GET'])]
            index()
            #[Route('/new', name: 'app_utilisateur_new', methods: ['GET', 'POST'])]
            new()
            #[Route('/{id}', name: 'app_utilisateur_show', methods: ['GET'])]
            show()
            #[Route('/{id}/edit', name: 'app_utilisateur_edit', methods: ['GET', 'POST'])]
            edit()
            #[Route('/{id}', name: 'app_utilisateur_delete', methods: ['POST'])]
            delete()

    Form
        BackEnd
            Administrateur

                EditerUnEmployeType

        FrontEnd

                EtatContratType

                RegistrationFormType

                UtilisateurType

    Security

        Voter

            DynamicRoleRegexVoter

        AppAuthenticator

            authenticate()

            onAuthenticationSuccess()

            getLoginUrl()

        EmailVerifier
        
            sendEmailConfirmation

            handleEmailConfirmation

    Validation

        ContraintesDuMotDePasse

        ValidationGroups

        Validations

            validerMotDePasse()

    templates

        BackEnd

            Administrateur

                accueilAdministrateur.html.twig

                EditerUnEmploye.html.twig.twig

                listeDesEmployes.html.twig

                voirUnEmploye.html.twig

            listeDesComptesClients.html.twig

        etat_contrat

        FrontEnd

            listeDesContrats.html.twig

        registration

            confirmation_email.html.twig

            register.html.twig

        Security

            login.html.twig

        utilisateur

        base.html.twig






```