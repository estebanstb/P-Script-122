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
•	Voir combien d’espace disk il y a en tout et combien il en reste.
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
PS> .\C:\Users\EtmlPowershell\Documents\GitHub\P-Script-122\pcManagement-estlebet.ps1

Menu de sélection :  
1. Statut du processeur
2. Combien de RAM
3. Combien d'espace disk
4. Utilisateurs locax
5. Version de Windows
0. Sortie
Veuillez saisir un numéro entre 0 et 5 : ......

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
    $choice = Read-Host "Veuillez saisir un numéro entre 0 et 5"

    # Si il a entré un chiffre entre 0 et 5 faire ce qu'il y a faire dans l'énoncé des choix
    switch ($choice) {
        1 
        { 
            Get-WmiObject Win32_Processor | Format-Table Name, LoadPercentage, MaxClockSpeed -AutoSize
        }

        2 
        { 
            $ram = Get-WmiObject Win32_ComputerSystem
            $totalRAM = [math]::Round($ram.TotalPhysicalMemory / 1GB, 2)
            $freeRAM = [math]::Round($ram.FreePhysicalMemory / 1GB, 2)
            Write-Host "Quantité totale de RAM : $totalRAM GiB"
            Write-Host "Quantité de RAM libre : $freeRAM GiB"
        }

        3 
        { 
            $disk = Get-WmiObject Win32_LogicalDisk -Filter "DriveType = 3"
            $totalSpace = [math]::Round($disk.Size / 1GB, 2)
            $freeSpace = [math]::Round($disk.FreeSpace / 1GB, 2)
            Write-Host "Espace disque total : $totalSpace GiB"
            Write-Host "Espace disque libre : $freeSpace GiB"
        }
        4 
        { 
            Get-WmiObject Win32_UserAccount | Where-Object { $_.LocalAccount -eq $true } | Format-Table Name, Caption -AutoSize
        }

        5 
        { 
            Get-WmiObject Win32_OperatingSystem | Format-Table Caption, Version -AutoSize        
        }

        0 { Write-Host "Sortie du programme" ; break }
        
        default { Write-Host "choice non valide. Veuillez réessayer." } 
    }
    # Pause pour permettre à l'utilisateur de voir le résultat avant de revenir au menu
    Read-Host "Appuyez sur Entrée pour continuer"

} while ($choice -ne 0)
