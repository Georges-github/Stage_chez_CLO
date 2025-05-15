from fpdf import FPDF

# Fonction pour remplacer les caractères spéciaux
def sanitize_text(text):
    # Remplacer les apostrophes typographiques et autres caractères spéciaux
    return text.replace("’", "'").replace("“", '"').replace("”", '"')

class PDF(FPDF):
    def header(self):
        # Utilisation de la police Arial qui supporte mieux les caractères spéciaux
        self.set_font("Arial", "B", 12)
        self.cell(0, 10, "Contrats types - Architecture d'intérieur", ln=True, align="C")
        self.ln(10)

    def add_contract(self, title, content):
        self.set_font("Arial", "B", 12)
        self.cell(0, 10, title, ln=True)
        self.ln(2)
        self.set_font("Arial", "", 11)
        # Appliquer la fonction sanitize_text pour nettoyer le contenu avant de l'ajouter
        sanitized_content = sanitize_text(content)
        self.multi_cell(0, 8, sanitized_content)
        self.ln(5)

# Création d'un PDF
pdf = PDF()
pdf.set_auto_page_break(auto=True, margin=15)
pdf.add_page()

# Contrats à inclure
contrats = [
    ("1. Contrat de mission de conseil en architecture d’intérieur",
     """Entre les soussignés :
L’entreprise : [Nom de l’entreprise], [Adresse], représentée par [Nom du représentant], ci-après dénommée « le Prestataire »
Et le Client : [Nom du client], [Adresse], ci-après dénommé « le Client »

Objet du contrat :
Le Prestataire est chargé de fournir un avis professionnel sur l’aménagement intérieur du logement/bureau situé à [adresse du lieu].

Durée de la mission :
La mission débutera le [date] et s’achèvera le [date ou durée estimée].

Modalités :
Le Prestataire remettra un compte-rendu écrit et/ou des croquis à la fin de la visite. Aucun suivi de chantier n’est prévu.

Rémunération :
Le Client s’engage à régler la somme forfaitaire de [Montant €] TTC, payable [conditions, ex : à la signature / à la remise du compte-rendu].

Fait à [lieu], le [date]

Signatures :
Le Prestataire _______________________
Le Client ___________________________"""),

    ("2. Contrat de conception d’un projet d’aménagement (Sans suivi de travaux)",
     """Entre :
Le Prestataire : [Nom de l’entreprise]
Et le Client : [Nom du client]

Objet :
Le Prestataire conçoit un projet d’aménagement intérieur pour [type de lieu, ex : un appartement de 60 m²], situé à [adresse].
Cela comprend :
- Une planche d’ambiance
- Un plan d’aménagement
- Une liste de mobilier ou matériaux

Délais :
Le projet sera remis au Client au plus tard le [date].

Prix et modalités de paiement :
Montant total : [Montant €] TTC
Versement : 50% à la commande, 50% à la remise des livrables.

Propriété intellectuelle :
Les créations restent la propriété du Prestataire jusqu’au paiement intégral. Toute reproduction ou usage commercial non autorisé est interdit.

Fait à [lieu], le [date]

Signatures :
Le Prestataire _______________________
Le Client ___________________________"""),

    ("3. Contrat complet avec suivi de chantier",
     """Entre :
[Entreprise d’architecture d’intérieur], ci-après « le Prestataire »
Et [Client], ci-après « le Client »

Objet :
Conception et suivi de la réalisation d’un projet d’aménagement intérieur pour le bien situé à [adresse]. Le Prestataire intervient pour :
- Conception
- Sélection des artisans
- Suivi de chantier
- Réception des travaux

Durée estimée :
De [date de début] à [date de fin prévue]

Budget et paiements :
- Honoraires de conception : [montant €] TTC
- Suivi de chantier : [montant ou % du coût des travaux]
- Modalités : 30% à la signature, 40% en cours, 30% à la réception

Responsabilités :
Le Prestataire ne se substitue pas aux entreprises exécutantes. Il agit en tant que coordinateur et conseil.

Fait en deux exemplaires originaux à [lieu], le [date]

Signatures :
Le Prestataire _______________________
Le Client ___________________________""")
]

# Ajouter les contrats au PDF
i = 1
for title, content in contrats:
    i += 1
    pdf.add_contract(title, content)
    pdf.output("a_" + str( i ) + ".pdf");

# Sauvegarder le fichier
#pdf.output("Contrats_types_architecture_interieur.pdf")

