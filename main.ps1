# Commande git
$cmd = 'git';

# Si la commande git est présente...
if (Get-Command $cmd -ErrorAction SilentlyContinue)
{
    #Met à jour le dépôt Git (nécessite que «Git for Windows» soit installé: https://gitforwindows.org/)
    git checkout .;
    git pull;

    # Démarre les notes de cours avec le fureteur par défaut
    Get-ChildItem "./" -Filter *.html |
    Foreach-Object {
        Start-Process $_.FullName;
    }
}
# Sinon...
else
{
    # Affiche un pop-up avec message d'erreur
    Add-Type -AssemblyName PresentationFramework;
    [System.Windows.MessageBox]::Show(
        "Impossible de mettre les notes à jour car la commande «$cmd» n'est pas disponible sur ce système.",
        'Erreur', # Titre de la fenêtre
        0, # bouton OK seulement
        16 # icône d'erreur
    );
}
