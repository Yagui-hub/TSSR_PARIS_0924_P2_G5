
#!/bin/bash 

# Définir les couleurs avec des variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Création de Mot de Passe 
PASSWORD='MotDePasse'

# Fonction de vérification du mot de passe
function verification_passwd {
    read -sp "Entrez le mot de passe: " input_password
    echo
    if [ "$input_password" == "$PASSWORD" ]; then
        return 0
    else
        return 1
    fi
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
                # Ici, ajouter les actions de l'utilisateur. 

                echo "1. Création d'un compte utilisateur"
                echo "2. Changement de mot de passe"
                echo "3. Suppression d'un compte utilisateur"
                
                read -p "Choisissez une action: " user_action
                
                case $user_action in
                    1)
                        echo "Création d'un compte utilisateur..."
                        # Logique pour créer un compte
                        ;;
                    2)
                        echo "Changement de mot de passe..."
                        # Logique pour changer le mot de passe
                        ;;
                    3)
                        echo "Suppression d'un compte utilisateur..."
                        # Logique pour supprimer un compte
                        ;;
                    *)
                        echo -e "${RED}Action invalide.${NC}"
                        ;;
                esac
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
