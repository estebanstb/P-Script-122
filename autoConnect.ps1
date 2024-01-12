<#
.NOTES
Nom du fichier 		: autoConnect.ps1
Prérequis 			: PowerShell 7.4.0
Version du script 	: 1.0
Auteur 				: LEBET Esteban
Date de creation 	: 10.01.2024
Lieu 				: ETML, Sébeillion

.SYNOPSIS
Fichier qui permet de se connecter et executer un script sur une autre machine

.DESCRIPTION
Ce fichier permet de se connecter à une machine sur le meme reseau et qui est en TrustedHosts. 
Le fichier permet de choisir quel script sera execute en indiquant un chemin.
 
.INPUTS
-
 
.OUTPUTS
-
 
.EXAMPLE
PS> ./autoConnect.ps1
Entrez le nom du PC sur lequel vous voulez vous connecter (Entrer nom exact). : DESKTOP-6N215S

Entrez le chemin complet du fichier PowerShell que vous voulez executer : C:\Users\exempleAutrePc\Desktop\pcManagement.ps1

.LINK
-

#>

# Nom du PC sur lequel on va executer le programme
$pcChoice = Read-Host "Entrez le nom du PC sur lequel vous voulez vous connecter (Entrer nom exact). "

# Chemin complet du programme à lancer
$filePath = Read-Host "Entrez le chemin complet du fichier PowerShell que vous voulez executer (Sur ce PC). "

# Nom du PC depuis lequel on va executer le programme
$thisPC = $env:username

# Commande pour executer la programme sur le PC cible
Invoke-Command -ComputerName $thisPC, $pcChoice -FilePath $filePath
