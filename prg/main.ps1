# Script pour récupérer ou mettre à jour des notes de cours
# (nécessite que «Git for Windows» soit installé: https://gitforwindows.org/)

# Commande git
$cmd = 'git'

# Si la commande git est présente...
if (Get-Command $cmd -ErrorAction SilentlyContinue)
{
    # Action différente selon que dossier .git existe ou non
    if (Test-Path './.git' -PathType Container) {
        #Met à jour le dépôt Git
        git checkout .
        git pull
    }
    else {
        # Affiche un pop-up avec message d'erreur
        Add-Type -AssemblyName PresentationFramework
        [System.Windows.MessageBox]::Show(
            "Impossible de mettre les notes à jour car le présent dossier n'est pas révisionné Git (dossier «.git» absent).",
            'Erreur', # Titre de la fenêtre
            0, # bouton OK seulement
            16 # icône d'erreur
        );
    }

    # Démarre les notes de cours avec le fureteur par défaut
    Get-ChildItem "./prg/" -Filter *.html |
    Foreach-Object {
        Start-Process $_.FullName
    }
}
# Si pas de git...
else
{
    # Affiche un pop-up avec message d'erreur
    Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show(
        "Impossible de mettre les notes à jour car la commande «$cmd» n'est pas disponible sur ce système.",
        'Erreur', # Titre de la fenêtre
        0, # bouton OK seulement
        16 # icône d'erreur
    );
}
