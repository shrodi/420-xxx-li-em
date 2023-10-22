@echo off

:: Script de démarrage automatique des notes de cours TiddlyWiki.
:: Pour que ce script fonctionne, il doit être situé dans le dossier
:: des notes de cours, et Git pour Windows doit être installé.

:: UTF-8
chcp 65001

:: Redémarre minimisé (donc on ne devrait voir que très brièvement la fenêtre MS-DOS)
if not DEFINED IS_MINIMIZED set IS_MINIMIZED=1 && start "" /min "%~dpnx0" %* && exit

:: Ferme si Git pas présent
set GIT_ABSENT=%1
if "%GIT_ABSENT%"=="true" echo "Quitte car Git est absent" && exit

:: Affiche un pop-up et quitte si Git est absent
set commande="if (!(Get-Command git -ErrorAction SilentlyContinue)) {Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('Impossible de mettre les notes à jour car git n''est pas disponible sur ce système.','Erreur',0,16); .\DemarrerNotes.cmd true;} else {.\DemarrerNotes.cmd false;}"
if "%GIT_ABSENT%"=="" powershell -ExecutionPolicy bypass -Command "& {%commande%}" && exit

:: Met à jour le dépôt Git (nécessite que «Git for Windows» soit installé: https://gitforwindows.org/)
echo git checkout .
git checkout .

echo git pull
git pull

echo Ouvre notes
:: Démarre les notes de cours avec le fureteur par défaut
for %%I in (*.html) do start %%~nxI

exit
