#!/bin/sh

menu (){
    clear
    echo "Que voulez-vous faire ?"
    echo " 1- Créer une machine virtuelle"
    echo " 2- Quitter le script"
    echo "---------------------"
}
editor (){
    clear
    echo "Que voulez vous faire sur la machine :"
    pwd
    echo " 1- Modifier le dossier synchronisé"
    echo " 2- Modifier l'adresse IP du serveur"
    echo " 3- Modifier la box de la machine"
    echo " 4- Démarrer la machine"
    echo " 5- Modifier LAMP"
}

menu
while read -p "Votre choix : " choice; do
    case $choice in
        1)  
            clear
            echo " 1- Créer un dossier"
            echo " 2- Utiliser un dossier existant"
            echo " 3- Retour au menu"
            read -p "Votre choix : " createOrUseDir
            case $createOrUseDir in
                1)
                    read -p "Quel est le nom du dossier que vous voulez créer ? " makeDirName
                    mkdir $makeDirName && echo "Le dossier a été créé avec succès" || echo "Le dossier n'a pas pu être créé"
                    cd $makeDirName
                    echo "Vous êtes dans le dossier:"
                    pwd
                    echo "-----------------"
                    vagrant init && echo "Le fichier Vagrantfile a été généré" || echo "Le fichier Vagrantfile n'a pas pu être généré"
                    sed -i 's/# config.vm.synced_folder "..\/data", "\/vagrant_data"/config.vm.synced_folder ".\/data", "\/var\/www\/html"/g' Vagrantfile
                    mkdir data
                    read -p "On continue ?"
                    editor
                    while read -p "Votre choix : " editChoice; do
                        case $editChoice in
                            1)
                                read -p "Quel est le nom de dossier que vous voulez utiliser ?" fileName
                                sed -i 's/config.vm.synced_folder ".\/data", "\/var\/www\/html"/config.vm.synced_folder ".\/'$fileName'", "\/var\/www\/html"/g' Vagrantfile
                                mkdir $fileName
                                rm -rf data
                                read -p "On continue ?"
                            ;;
                            2)
                                read -p "Quel est l'adresse IP que vous voulez utiliser ?" address
                                sed -i 's/# config.vm.network "private_network", ip: "192.168.33.10"/config.vm.network "private_network", ip: "'$address'"/g' Vagrantfile
                                read -p "On continue ?"
                            ;;
                            3)
                                echo "Quelle box voulez-vous utiliser ?"
                                echo "1- ubuntu/xenial64"
                                echo "2- ubuntu/trusty64"
                                read -p "Alors ?" box
                                case $box in
                                1)
                                    sed -i 's/config.vm.box = "base"/config.vm.box = "ubuntu\/xenial64"/g' Vagrantfile && echo "La box a été appliquée" || echo "La box n'a pas été appliquée"
                                    read -p "On continue ?"
                                ;;
                                2)
                                    sed -i 's/config.vm.box = "base"/config.vm.box = "ubuntu\/trusty64"/g' Vagrantfile && echo "La box a été appliquée" || echo "La box n'a pas été appliquée"
                                    read -p "On continue ?"
                                ;;
                                *)
                                    echo "Erreur lors de la saisie" && sleep 2
                                ;;
                                esac
                            ;;
                            4)
                                vagrant up && echo "La machine est démarrée" || echo "La machine ne peut pas démarrer"
                                read -p "On continue ?"
                            ;;
                            5)
                                echo "Quel(s) packets voulez-vous installer ?"
                                echo "a- apache"
                                echo "m- mysql"
                                echo "p- php"
                                echo "amp- apache mysql php"
                                echo "am- apache mysql"
                                echo "ap- apache php"
                                echo "mp- mysql php"
                                read -p "Alors ?" packets

                                case $packets in
                                a)
                                    command="sudo apt install apache2"
                                ;;
                                m)
                                    command="sudo apt install mysql-server"
                                ;;
                                p)
                                    command="sudo apt install php7.0"
                                ;;
                                amp)
                                    command="sudo apt install php7.0 mysql-server apache2"
                                ;;
                                am)
                                    command="sudo apt install apache2 mysql-server"
                                ;;
                                ap)
                                    command="sudo apt install apache2 php7.0"
                                ;;
                                mp)
                                    command="sudo apt install mysql-server php7.0"
                                ;;
                                esac
                                vagrant ssh -c "$command -y"
                            ;;
                            *)
                                echo "Erreur lors de la saisie" && sleep 2
                            ;;
                        esac
                        editor
                    done
                ;;
                2)
                    echo "Ci-dessous la liste des dossiers existants : "
                    ls -d */ --color
                    read -p "Quel est le nom du dossier que vous voulez utiliser ? " useDirName
                    cd $useDirName
                    echo "Vous êtes dans le dossier:"
                    pwd
                    echo "-----------------"
                    vagrant init && echo "Le fichier Vagrantfile a été généré" || echo "Le fichier Vagrantfile n'a pas pu être généré"
                    sed -i 's/# config.vm.synced_folder "..\/data", "\/vagrant_data"/config.vm.synced_folder ".\/data", "\/var\/www\/html"/g' Vagrantfile
                    mkdir data
                    read -p "On continue ?"
                    editor
                    while read -p "Votre choix : " editChoice; do
                        case $editChoice in
                            1)
                                read -p "Quel est le nom de dossier que vous voulez utiliser ?" fileName
                                sed -i 's/config.vm.synced_folder ".\/data", "\/var\/www\/html"/config.vm.synced_folder ".\/'$fileName'", "\/var\/www\/html"/g' Vagrantfile
                                mkdir $fileName
                                rm -rf data
                                read -p "On continue ?"
                            ;;
                            2)
                                read -p "Quel est l'adresse IP que vous voulez utiliser ?" address
                                sed -i 's/# config.vm.network "private_network", ip: "192.168.33.10"/config.vm.network "private_network", ip: "'$address'"/g' Vagrantfile
                                read -p "On continue ?"
                            ;;
                            3)
                                echo "Quelle box voulez-vous utiliser ?"
                                echo "1- ubuntu/xenial64"
                                echo "2- ubuntu/trusty64"
                                read -p "Alors ?" box
                                case $box in
                                1)
                                    sed -i 's/config.vm.box = "base"/config.vm.box = "ubuntu\/xenial64"/g' Vagrantfile && echo "La box a été appliquée" || echo "La box n'a pas été appliquée"
                                    read -p "On continue ?"
                                ;;
                                2)
                                    sed -i 's/config.vm.box = "base"/config.vm.box = "ubuntu\/trusty64"/g' Vagrantfile && echo "La box a été appliquée" || echo "La box n'a pas été appliquée"
                                    read -p "On continue ?"
                                ;;
                                *)
                                    echo "Erreur lors de la saisie" && sleep 2
                                ;;
                                esac
                            ;;
                            4)
                                vagrant up && echo "La machine est démarrée" || echo "La machine ne peut pas démarrer"
                                read -p "On continue ?"
                            ;;
                            5)
                                echo "Quel(s) packets voulez-vous installer ?"
                                echo "a- apache"
                                echo "m- mysql"
                                echo "p- php"
                                echo "amp- apache mysql php"
                                echo "am- apache mysql"
                                echo "ap- apache php"
                                echo "mp- mysql php"
                                read -p "Alors ?" packets

                                case $packets in
                                a)
                                    command="sudo apt install apache2"
                                ;;
                                m)
                                    command="sudo apt install mysql-server"
                                ;;
                                p)
                                    command="sudo apt install php7.0"
                                ;;
                                amp)
                                    command="sudo apt install php7.0 mysql-server apache2"
                                ;;
                                am)
                                    command="sudo apt install apache2 mysql-server"
                                ;;
                                ap)
                                    command="sudo apt install apache2 php7.0"
                                ;;
                                mp)
                                    command="sudo apt install mysql-server php7.0"
                                ;;
                                *)
                                    echo "Erreur lors de la saisie" && sleep 2
                                ;;
                                esac
                                vagrant ssh -c "sudo apt update, $command -y"
                            ;;
                            *)
                                echo "Erreur lors de la saisie" && sleep 2
                            ;;
                        esac
                        editor
                    done
                ;;
                3)
                    menu
                ;;
                *)
                    echo "Erreur lors de la saisie" && sleep 2
                ;;
            esac
        ;;
        2)
            break ;;
        *)
            echo "Erreur lors de la saisie" && sleep 2;;
    esac
    menu
done
echo "Vous avez décidé de quitter le script"