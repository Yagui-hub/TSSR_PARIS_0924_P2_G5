
#!/bin/bash

# Function to display the main menu
main_menu() {
    clear
    echo "=== Menu Principal ==="
    echo "1. Créer un compte utilisateur"
    echo "2. Modifier le mot de passe d'un compte utilisateur"
    echo "3. Supprimer un compte utilisateur"
    echo "4. Désactiver un compte utilisateur"
    echo "5. Quitter"
    read -p "Choisissez une option: " choice

    case $choice in
        1) menu_creation_compte_utilisateur ;;
        2) menu_modification_mot_de_passe ;;
        3) menu_suppression_dun_compte_utilisateur ;;
        4) menu_désactiver_un_compte_utilisateur_local ;;
        5) exit 0 ;;
        *) echo "Choix invalide ! Veuillez réessayer." && main_menu ;;
    esac
}

# Sous-menu pour la création d'un compte utilisateur 
menu_creation_compte_utilisateur() { 
    clear
    echo "=== Création compte utilisateur ==="
    read -p "Donner un nom de compte à créer: " newUser

    if grep -q "^$newUser:" /etc/passwd; then
        echo -e "Utilisateur $newUser existe\nSortie du script"
        exit 1
    else
        echo "Création utilisateur $newUser"
        sudo useradd "$newUser" > /dev/null

        if grep -q "^$newUser:" /etc/passwd; then
            echo "Utilisateur $newUser créé !"
        else
            echo "Utilisateur $newUser non créé ==> problème"
        fi
    fi
    read -p "Appuyez sur Entrée pour revenir au menu principal..."
    main_menu  # Retour au menu principal
}

# Fonction pour la modification du mot de passe
menu_modification_mot_de_passe() {
    clear
    echo "Modification du mot de passe compte utilisateur"
    read -s -p "Nouveau mot de passe : " mdp 
    echo ""

    if test -z "$mdp"; then
        echo "Le mot de passe ne peut pas être vide."
        exit 1
    fi

    read -s -p "Retapez le mot de passe (vérification) : " mdp2  
    echo ""

    if [ "$mdp" != "$mdp2" ]; then 
        echo "Les mots de passe saisis ne correspondent pas." 
        exit 1
    fi

    echo "Modification du mot de passe avec succès."
    read -p "Appuyez sur Entrée pour revenir au menu principal..."
    main_menu  # Retour au menu principal
}

# Sous-menu pour la suppression d'un compte utilisateur 
menu_suppression_dun_compte_utilisateur() { 
    clear 
    echo "=== Suppression d'un compte utilisateur ===" 
    read -p "Donner un nom de compte utilisateur à supprimer : " delUser
    
    if grep -qw "$delUser" /etc/passwd > /dev/null 2>&1; then
        echo -e "Utilisateur $delUser existe\nGo SUPPRESSION !"
        sudo userdel -r -f "$delUser" 2> /dev/null
        
        if ! grep -qw "$delUser" /etc/passwd; then
            echo "Utilisateur $delUser supprimé."
        else
            echo "! Erreur : Utilisateur $delUser non-supprimé."
        fi
    else
        echo -e "Utilisateur $delUser non existant.\nSortie du script."
        exit 1
    fi

    read -p "Appuyez sur Entrée pour revenir au menu principal..."
    main_menu  # Retour au menu principal
}

# Sous-menu pour désactiver un compte utilisateur local 
menu_désactiver_un_compte_utilisateur_local() { 
    clear 
    echo "=== Désactivation d'un compte utilisateur local ===" 
    read -p "Donner un nom de compte utilisateur à désactiver : " userToDisable
    
    if grep -qw "$userToDisable" /etc/passwd > /dev/null 2>&1; then
        echo -e "Utilisateur $userToDisable existe\nDésactivation en cours..."
        
        # Désactiver le compte
        sudo usermod -L "$userToDisable"  # Lock the account
        
        # Vérification de la désactivation
        if passwd -S "$userToDisable" | grep -q "L"; then  # Check if account is locked
            echo "Utilisateur $userToDisable désactivé."
        else
            echo "! Erreur : Utilisateur $userToDisable non désactivé."
        fi
    else
        echo -e "Utilisateur $userToDisable non existant.\nSortie du script."
        exit 1
    fi

    read -p "Appuyez sur Entrée pour revenir au menu principal..."
    main_menu  # Retour au menu principal
}

# Lancer le menu principal
main_menu
