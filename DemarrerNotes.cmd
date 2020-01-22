@echo off

:: Script de démarrage automatique des notes de cours TiddlyWiki.
:: Pour que ce script fonctionne, il doit être situé dans le dossier
:: des notes de cours, lui-même situé dans «NodeJSPortable\Data».

:: Met à jour le dépôt Git (nécessite que «Git for Windows» soit installé: https://gitforwindows.org/)
git pull

:: Définit comme variable d'environnement pour utilisation par Server.cmd
set dossierCours=%cd%

:: Fichier Server.cmd de NodeJSPortable à remplacer
set fichierServer=..\..\App\Server.cmd

:: Fait une copie de sauvegarde du fichier Server.cmd original si n'a pas déjà été fait
if not exist %fichierServer%.orig (
  copy %fichierServer% %fichierServer%.orig
)

:: Copie Server.cmd pour utilisation par NodeJSPortable
xcopy /y Server.cmd %fichierServer%

:: Lance NodeJSPortable
start ..\..\NodeJSPortable.exe
