# Nom du PC sur lequel on va executer le programme
$pcChoice = Read-Host "Entrez le nom du PC sur lequel vous voulez vous connecter (Entrer nom exact). "

# Chemin complet du programme à lancer
$filePath = Read-Host "Entrez le chemin complet du fichier que vous voulez executer "

# Nom du PC depuis lequel on va executer le programme
$thisPC = $env:username

# Commande pour executer la programme sur le PC cible
Invoke-Command -ComputerName $thisPC, $pcChoice -FilePath $filePath
