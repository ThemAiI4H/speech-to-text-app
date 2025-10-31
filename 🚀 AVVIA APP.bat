@echo off
chcp 65001 > nul
echo.
echo ============================================
echo        🚀 SPEECH TO TEXT APP
echo ============================================
echo.
echo Avvio automatico dell'applicazione...
echo.
echo Assicurati di aver configurato il file .env
echo con la tua API key OpenAI
echo.
echo Premi un tasto per continuare...
pause > nul

echo.
echo [1/3] Controllo dipendenze...
where npm > nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ERRORE: npm non trovato. Installa Node.js
    echo 📥 Scarica da: https://nodejs.org
    pause
    exit /b 1
)
echo ✅ npm trovato

echo.
echo [2/3] Avvio server in background...
start /B npm start
timeout /t 2 /nobreak > nul

echo.
echo [3/3] Apertura applicazione...
start http://localhost:3000

echo.
echo ============================================
echo        ✅ APP AVVIATA CON SUCCESSO!
echo ============================================
echo.
echo 🌐 Browser aperto su: http://localhost:3000
echo 🔧 Server attivo in background
echo ❌ Chiudi questa finestra quando hai finito
echo.
echo Premi un tasto per chiudere...
pause > nul
