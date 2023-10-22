@echo off
:: Script de démarrage automatique des notes de cours TiddlyWiki.
:: Pour que ce script fonctionne, il doit être situé dans le dossier
:: des notes de cours, et Git pour Windows doit être installé.

:: Redémarre minimisé (donc on ne devrait voir que très brièvement la fenêtre MS-DOS)
if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start "" /min "%~dpnx0" %* && exit

:: Reçoit argument true ou false selon que Git est absent ou non
set GIT_ABSENT=%1

:: Commande dont tester la présence
set CMD=git

:: UTF-8
chcp 65001

:: Si absence de git indéfinie, alors teste absence:
::    si git absent, affiche un pop-up et redémarre avec 'true', sinon redéarre avec 'false'
set commande="if (!(Get-Command %CMD% -ErrorAction SilentlyContinue)) {Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('Impossible de mettre les notes à jour car la commande «%CMD%» n''est pas disponible sur ce système.','Erreur',0,16); .\DemarrerNotes.cmd true;} else {.\DemarrerNotes.cmd false;}"
if "%GIT_ABSENT%"=="" powershell -ExecutionPolicy bypass -Command "& {%commande%}" && exit

:: Quitte si Git absent
if "%GIT_ABSENT%"=="true" exit

:: Met à jour le dépôt Git (nécessite que «Git for Windows» soit installé: https://gitforwindows.org/)
echo git checkout .
git checkout .

echo git pull
git pull

echo Ouvre notes
:: Démarre les notes de cours avec le fureteur par défaut
for %%I in (*.html) do start %%~nxI

exit
