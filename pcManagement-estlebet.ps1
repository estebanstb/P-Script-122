<#
.NOTES
Nom du fichier 		: pcManagement-estlebet.ps1
Prerequis 			: PowerShell 7.4.0
Version du script 	: 1.0
Auteur 				: LEBET Esteban
Date de creation 	: 15.12.2023
Lieu 				: ETML, Sebeillion

.SYNOPSIS
Gestion de PC connectes sur la même infrastructure reseau

.DESCRIPTION
Ce projet nous demande de creer notre propre cahier des charges sur un projet en PowerShell qu’on choisit.
Je suis parti sur un petit projet de gestion des differents composants du PC permettant de voir les composants d’ordinateurs connectes au reseau.

•	Menu à 5 fonctionnalites.

•	Voir le statut du processeur.
•	Voir combien de RAM le PC possède en GiB.
•	Voir combien d’espace disk il y a en tout et combien il en reste.
•	Voir les utilisateurs locaux.
•	Voir la version actuelle de Windows.

.INPUTS
-
 
.OUTPUTS
-
 
.EXAMPLE
PS> .\C:\Users\EtmlPowershell\Documents\GitHub\P-Script-122\pcManagement-estlebet.ps1

Menu de selection :  
1. Statut du processeur
2. Combien de RAM
3. Combien d'espace disque
4. Utilisateurs locaux
5. Version de Windows
0. Sortie
Veuillez saisir un numero entre 0 et 5 : ...

.LINK
-

#>
function mainMenu {
    Clear-Host
    Write-Host "Menu de selection :"
    Write-Host "1. Statut du processeur"
    Write-Host "2. Combien de RAM"
    Write-Host "3. Combien d'espace disque"
    Write-Host "4. Utilisateurs locaux"
    Write-Host "5. Version de Windows"
    Write-Host "0. Sortie"
}

do {
    # Montrer à l'utilisateur les options
    mainMenu

    # Lui demander son choix
    $choice = Read-Host "`nVeuillez saisir un numero entre 0 et 5"

    # Si il a entre un chiffre entre 0 et 5 faire ce qu'il y a faire dans l'enonce des choix
    switch ($choice) {
        1 # Statut du processeur
        { 
            Get-WmiObject Win32_Processor | Format-Table Name, LoadPercentage, MaxClockSpeed -AutoSize
        }

        2 # Combien de RAM
        { 
            # Variable qui cree un raccourci à partir d'une commande PS pour aller chercher la ram
            $ram = Get-WmiObject Win32_ComputerSystem
            
            # Variable faisant le calcul pour obtenir la ram total en GB
            $totalRAM = [math]::Round($ram.TotalPhysicalMemory / 1GB, 2)
            
            # Variable faisant le calcul pour obtenir la ram libre en GB
            $freeRAM = [math]::Round($ram.FreePhysicalMemory / 1GB, 2)
            Write-Host "Quantite totale de RAM : $totalRAM GiB"
            Write-Host "Quantite de RAM libre : $freeRAM GiB"
        }

        3 # Combien d'espace disque
        { 
            # Variable qui cree un raccourci à partir d'une commande PS pour aller chercher le disque de stockage
            $disk = Get-WmiObject Win32_LogicalDisk -Filter "DriveType = 3"
            
            # Variable faisant le calcul pour obtenir l'espace disque total en GB
            $totalSpace = [math]::Round($disk.Size / 1GB, 2)
            
            # Variable faisant le calcul pour obtenir l'espace disque libre en GB
            $freeSpace = [math]::Round($disk.FreeSpace / 1GB, 2)
            Write-Host "Espace disque total : $totalSpace GiB"
            Write-Host "Espace disque libre : $freeSpace GiB"
        }
        
        4 # Utilisateurs locaux
        { 
            # Commande PS allant chercher les utilisateurs présents sur la machine
            Get-WmiObject Win32_UserAccount | Where-Object { $_.LocalAccount -eq $true } | Format-Table Name, Caption -AutoSize
        }

        5 # Version de Windows
        { 
            # Commande PS allant cherche la version de Windows de la machine
            Get-WmiObject Win32_OperatingSystem | Format-Table Caption, Version -AutoSize        
        }
        
        0 
        { 
            Write-Host "Sortie du programme" ; break 
        }
        
        default { Write-Host "Choix non valide. Veuillez reessayer." } 
    }
    # Pause pour permettre à l'utilisateur de voir le resultat avant de revenir au menu
    Read-Host "`nAppuyez sur Entree pour continuer"

} while ($choice -ne 0)

