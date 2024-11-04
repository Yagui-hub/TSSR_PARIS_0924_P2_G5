
#!/bin/bash 

# Définir les couleurs avec des variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Création de Mot de Passe 
PASSWORD='MotDePasse'  # Consider hashing for security

# Fonction de vérification du mot de passe
function verification_passwd {
    read -sp "Entrez le mot de passe: " input_password
    echo
    [[ "$input_password" == "$PASSWORD" ]]
}

# Fonctions pour les actions utilisateurs
function creer_compte {
    echo "Création d'un compte utilisateur..."
    # Logique pour créer un compte
    echo "Compte créé avec succès."
}

function changer_mot_de_passe {
    echo "Changement de mot de passe..."
    # Logique pour changer le mot de passe
    echo "Mot de passe changé avec succès."
}

function supprimer_compte {
    echo "Suppression d'un compte utilisateur..."
    # Logique pour supprimer un compte
    echo "Compte supprimé avec succès."
}

while true; do 
    echo -e "${GREEN}---Menu Principal---${NC}" 
    echo "1. Choix utilisateur" 
    echo "2. Choix ordinateur" 
    echo "3. Quitter" 

    read -p "Veuillez choisir une option: " choix

    case $choix in 
        1) 
            echo "Vous avez choisi : Choix utilisateur" 
            if verification_passwd; then 
                echo "Accès accordé à l'utilisateur."

                while true; do
                    echo "1. Création d'un compte utilisateur"
                    echo "2. Changement de mot de passe"
                    echo "3. Suppression d'un compte utilisateur"
                    echo "4. Retour au menu principal"

                    read -p "Choisissez une action: " user_action
                    
                    case $user_action in
                        1) creer_compte ;;
                        2) changer_mot_de_passe ;;
                        3) supprimer_compte ;;
                        4) break ;;
                        *) echo -e "${RED}Action invalide.${NC}" ;;
                    esac
                done
            else
                echo -e "${RED}Accès refusé. Mot de passe incorrect.${NC}"
            fi
            ;;

        2) 
            echo "Vous avez choisi : Choix ordinateur"
            # Logique pour le choix ordinateur
            ;;

        3) 
            echo "Au revoir!"
            exit 0
            ;;

        *) 
            echo -e "${RED}Option invalide. Veuillez réessayer.${NC}" 
            ;;
    esac
done
