@echo off
echo ============================================
echo    SPEECH TO TEXT APP - Avvio Semplice
echo ============================================
echo.
echo Questa versione apre automaticamente il browser
echo dopo aver avviato il server in background.
echo.
echo Assicurati di aver configurato il file .env
echo con la tua API key OpenAI
echo.
echo Premi un tasto per continuare...
pause > nul

echo.
echo Avvio del server...
start /B npm start

echo Attesa avvio server...
timeout /t 3 /nobreak > nul

echo Apertura browser...
start http://localhost:3000

echo.
echo ============================================
echo App avviata! Puoi chiudere questa finestra.
echo Il server continuera' a girare in background.
echo ============================================
echo.
echo Premi un tasto per chiudere...
pause > nul
