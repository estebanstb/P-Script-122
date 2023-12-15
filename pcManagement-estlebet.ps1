<#
.NOTES
Nom du fichier 		: pcManagement-estlebet.ps1
Prérequis 			: PowerShell 7.4.0
Version du script 	: 1.0
Auteur 				: LEBET Esteban
Date de creation 	: 15.12.2023
Lieu 				: ETML, Sébeillion

.SYNOPSIS
Gestion de PC en connectés sur la même infrastructure

.DESCRIPTION
Ce projet nous demande de créer notre propre cahier des charges sur un projet en PowerShell qu’on choisit.
Je suis parti sur un petit projet de gestion des différents composants du PC permettant de voir les composants d’ordinateurs connectés au réseau.

•	Menu à 5 fonctionnalités.
•	Voir le statut du processeur.
•	Voir combien de RAM le PC possède en GiB.
•	Voir combien d’espace disque il y a en tout et combien il en reste.
•	Voir les utilisateurs locaux.
•	Voir la version actuelle de Windows.

.PARAMETER Name
Specifies the file name.
 
.PARAMETER Extension
Specifies the extension. "Txt" is the default.
 
.INPUTS
-
 
.OUTPUTS
-
 
.EXAMPLE
PS> extension -name "File"
File.txt
 
.EXAMPLE
PS> extension -name "File" -extension "doc"
File.doc
 
.EXAMPLE
PS> extension "File" "doc"
File.doc
 
.LINK
-

#>

function mainMenu {
    Clear-Host
    Write-Host "Menu de sélection :"
    Write-Host "1. Statut du processeur"
    Write-Host "2. Combien de RAM"
    Write-Host "3. Combien d'espace disque"
    Write-Host "4. Utilisateurs locax"
    Write-Host "5. Version de Windows"
    Write-Host "0. Sortie"
}

do {
    # Montrer à l'utilisateur les options
    mainMenu

    # Lui demander son choix
    $choix = Read-Host "Veuillez saisir un numéro entre 0 et 5"

    # Si il a entré un chiffre entre 0 et 5 faire ce qu'il y a faire dans l'énoncé des choix
    switch ($choix) {
        1 
        { 
            Get-CimInstance win32_processor ; break
        }

        2 
        { 
            $ram = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property TotalPhysicalMemory / 1GB
            
            $ram 
            break
        }

        3 
        { 
            Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" |
            Measure-Object -Property FreeSpace,Size -Sum |
            Select-Object -Property Property,Sum
            break
        }
        4 
        { 
            Write-Host "Vous avez choisi l'option 4" ; break 
        }

        5 
        { 
            Write-Host "Vous avez choisi l'option 5" ; break 
        }

        0 { Write-Host "Sortie du programme" ; break }
        
        default { Write-Host "Choix non valide. Veuillez réessayer." } 
    }
    # Pause pour permettre à l'utilisateur de voir le résultat avant de revenir au menu
    Read-Host "Appuyez sur Entrée pour continuer"

} while ($choix -ne 0)
