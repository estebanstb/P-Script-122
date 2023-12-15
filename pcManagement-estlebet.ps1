<#
.NOTES
Nom du fichier 		: pcManagement-estlebet.ps1
Prérequis 			: PowerShell 7.4.0
Version du script 	: 1.0
Auteur 				: LEBET Esteban
Date de creation 	: 15.12.2023
Lieu 				: ETML, Sébeillion

.SYNOPSIS
Adds a file name extension to a supplied name.
 
.DESCRIPTION
Adds a file name extension to a supplied name.
Takes any strings for the file name or extension.
 
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