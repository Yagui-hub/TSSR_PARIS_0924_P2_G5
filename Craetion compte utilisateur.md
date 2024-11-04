# Sous-menu pour la création d'un compte utilisateur 
menu_creation_compte_utilisateur() { 
    clear
    echo "=== Création compte utilisateur ==="
    read -p "Donner un nom de compte à créer: " newUser

    if grep -q "^$newUser:" /etc/passwd; then
        # le compte $newUser existe
        echo -e "Utilisateur $newUser existe\nSortie du script"
        exit 1
    else
        # le compte $newUser n'existe pas
        echo "Création utilisateur $newUser"
        sudo useradd "$newUser" > /dev/null

        # Vérification création du compte
        if grep -q "^$newUser:" /etc/passwd; then
            echo "Utilisateur $newUser créé !"
        else
            echo "Utilisateur $newUser non créé ==> problème"
        fi
    fi

    menu_compte_utilisateur  # Retour au menu des comptes
}
