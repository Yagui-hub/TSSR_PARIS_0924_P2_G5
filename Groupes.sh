#!/bin/bash

# --- Script avec Menu interactif pour gérer les utilisateurs et les groupes ---

while true; do
    # Affichage du menu
    echo "=============================="
    echo "Menu de gestion des utilisateurs"
    echo "=============================="
    echo "1. Ajouter un utilisateur à un groupe d'administration"
    echo "2. Ajouter un utilisateur à un groupe local"
    echo "3. Retirer un utilisateur d'un groupe"
    echo "4. Quitter"
    echo -n "Choisissez une option [1-4] : "
    read choice

    case $choice in
        1)
            # --- Ajouter un utilisateur à un groupe d'administration ---
            echo "=== Ajouter un utilisateur à un groupe d'administration ==="
            read -p "Entrez le nom de l'utilisateur : " username
            read -sp "Entrez le mot de passe de l'utilisateur : " password
            echo
            read -p "Entrez le groupe d'administration (par défaut 'sudo') : " admin_group
            admin_group=${admin_group:-sudo}

            # Ajouter l'utilisateur au groupe d'administration
            if getent group "$admin_group" &>/dev/null; then
                usermod -aG "$admin_group" "$username"
                echo "L'utilisateur $username a été ajouté au groupe $admin_group."
            else
                echo "Le groupe $admin_group n'existe pas. Veuillez vérifier."
            fi
            ;;
        
        2)
            # --- Ajouter un utilisateur à un groupe local ---
            echo "=== Ajouter un utilisateur à un groupe local ==="
            read -p "Entrez le nom de l'utilisateur : " username
            read -sp "Entrez le mot de passe de l'utilisateur : " password
            echo
            read -p "Entrez le groupe local auquel ajouter l'utilisateur : " group

            # Ajouter l'utilisateur au groupe local
            if getent group "$group" &>/dev/null; then
                usermod -aG "$group" "$username"
                echo "L'utilisateur $username a été ajouté au groupe local $group."
            else
                echo "Le groupe $group n'existe pas. Veuillez vérifier."
            fi
            ;;
        
        3)
            # --- Retirer un utilisateur d'un groupe ---
            echo "=== Retirer un utilisateur d'un groupe ==="
            read -p "Entrez le nom de l'utilisateur : " username
            read -p "Entrez le nom du groupe duquel retirer l'utilisateur : " group

            # Vérification si l'utilisateur et le groupe existent
            if ! id "$username" &>/dev/null; then
                echo "L'utilisateur $username n'existe pas."
                continue
            fi

            if ! getent group "$group" &>/dev/null; then
                echo "Le groupe $group n'existe pas."
                continue
            fi

            # Vérification si l'utilisateur est membre du groupe
            if ! groups "$username" | grep -q "\b$group\b"; then
                echo "L'utilisateur $username n'est pas membre du groupe $group."
                continue
            fi

            # Retirer l'utilisateur du groupe
            gpasswd -d "$username" "$group"
            echo "L'utilisateur $username a été retiré du groupe $group."
            ;;
        
        4)
            # Quitter le script
            echo "Au revoir!"
            exit 0
            ;;
        
        *)
            # Option invalide
            echo "Option invalide. Veuillez choisir une option entre 1 et 4."
            ;;
    esac

    # Demander de revenir au menu principal après chaque action
    echo
    read -p "Appuyez sur [Entrée] pour revenir au menu principal..."
done
