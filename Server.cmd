@echo off

title NodeJS

cls
echo.
echo Node
node --version
echo.

:: Contiendra le premier port libre; part à 8000 par défaut
set portLibre=8000

:CHERCHERPORT
:: Regarde si portLibre est déjà à l'écoute
netstat -o -n -a | find "LISTENING" | find ":%portLibre% " > NUL

if "%ERRORLEVEL%" equ "0" (
  :: Si pas d'erreur (ERRORLEVEL=0), alors c'est que le port est déjà sous écoute => on incrémente portLibre de 1
  set /a portLibre += 1
  GOTO :CHERCHERPORT
) ELSE (
  :: Si erreur (ERRORLEVEL!=0), alors c'est que le port n'est pas déjà sous écoute => on sort de la boucle
  GOTO :TIDDLY
)

:TIDDLY
:: La variable dossierCours est définie dans le script DemarrerNotes.cmd
cd %dossierCours%
:: Démarre TiddlyWiki en mode serveur
start tiddlywiki NotesDeCours --server %portLibre%

:: Attend un peu que le serveur soit démarré
timeout 5

:: Ouvre les notes dans le fureteur par défaut
start http://localhost:%portLibre%/
