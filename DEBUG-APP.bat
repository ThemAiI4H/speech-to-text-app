@echo off
chcp 65001 > nul
echo.
echo ============================================
echo    🔍 DEBUG SPEECH TO TEXT APP
echo ============================================
echo.
echo Questo script diagnostica tutti i possibili problemi
echo e ti guida nella risoluzione.
echo.
pause

echo.
echo [FASE 1] Controllo ambiente di base...
echo.

echo Verifica sistema operativo...
ver
echo.

echo Verifica architettura...
wmic os get osarchitecture
echo.

echo [FASE 2] Controllo Node.js...
echo.

where node > nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Node.js trovato
    for /f "tokens=*" %%i in ('node --version') do echo Versione: %%i
) else (
    echo ❌ Node.js NON trovato!
    echo.
    echo 💡 SOLUZIONE:
    echo 1. Esegui INSTALLA-NODEJS.bat
    echo 2. O scarica da: https://nodejs.org
    echo 3. Riavvia questo script
    echo.
    pause
    exit /b 1
)

echo.
echo [FASE 3] Controllo npm...
echo.

where npm > nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ npm trovato
    for /f "tokens=*" %%i in ('npm --version') do echo Versione: %%i
) else (
    echo ❌ npm NON trovato!
    echo 💡 npm dovrebbe essere incluso con Node.js
)

echo.
echo [FASE 4] Controllo cartella progetto...
echo.

if exist "package.json" (
    echo ✅ package.json trovato
) else (
    echo ❌ package.json NON trovato!
    echo 💡 Assicurati di essere nella cartella speech-to-text-app
    pause
    exit /b 1
)

if exist "server.js" (
    echo ✅ server.js trovato
) else (
    echo ❌ server.js NON trovato!
    pause
    exit /b 1
)

if exist "public" (
    echo ✅ Cartella public trovata
) else (
    echo ❌ Cartella public NON trovata!
    pause
    exit /b 1
)

echo.
echo [FASE 5] Controllo dipendenze...
echo.

if exist "node_modules" (
    echo ✅ node_modules trovato (dipendenze installate)
) else (
    echo ⚠️  node_modules NON trovato
    echo.
    echo 💡 SOLUZIONE: Esegui "npm install"
    echo Vuoi che lo faccia automaticamente? (s/n)
    set /p choice=
    if /i "!choice!"=="s" (
        echo.
        echo Installazione dipendenze in corso...
        npm install
        if %errorlevel% equ 0 (
            echo ✅ Dipendenze installate con successo!
        ) else (
            echo ❌ Errore nell'installazione delle dipendenze
        )
    )
)

echo.
echo [FASE 6] Controllo configurazione API...
echo.

if exist ".env" (
    echo ✅ File .env trovato
    findstr /C:"OPENAI_API_KEY=" .env > nul
    if %errorlevel% equ 0 (
        echo ✅ API key configurata in .env
        echo.
        echo 🔐 Test API key...
        echo.
        echo Test 1: Connessione di base...
        curl -s --connect-timeout 5 https://api.openai.com/v1/models -H "Authorization: Bearer %OPENAI_API_KEY%" -H "Content-Type: application/json" | findstr /C:"list" > nul
        if %errorlevel% equ 0 (
            echo ✅ API key valida - connessione OK
        ) else (
            echo ❌ API key NON valida o problemi di connessione
            echo 💡 Verifica che l'API key sia corretta
            echo 💡 Controlla la connessione internet
        )
    ) else (
        echo ❌ API key NON trovata in .env
        echo.
        echo 💡 SOLUZIONE:
        echo 1. Apri .env con un editor
        echo 2. Aggiungi: OPENAI_API_KEY=sk-tua-chiave
        echo 3. Salva il file
    )
) else (
    echo ❌ File .env NON trovato!
    echo.
    echo 💡 SOLUZIONE:
    echo 1. Copia .env.example in .env
    echo 2. Modifica con la tua API key
)

echo.
echo [FASE 7] Test avvio server...
echo.

echo Avvio server di test...
start /B node server.js > server_test.log 2>&1
timeout /t 3 /nobreak > nul

tasklist /FI "IMAGENAME eq node.exe" | findstr /C:"node.exe" > nul
if %errorlevel% equ 0 (
    echo ✅ Server avviato con successo
    echo 🔍 Controllo se risponde...
    curl -s --connect-timeout 3 http://localhost:3000/health | findstr /C:"OK" > nul
    if %errorlevel% equ 0 (
        echo ✅ Server risponde correttamente
    ) else (
        echo ❌ Server non risponde su localhost:3000
    )

    echo Arresto server di test...
    taskkill /F /IM node.exe > nul 2>&1
) else (
    echo ❌ Server NON si avvia
    echo.
    echo 💡 Controlla server_test.log per errori
    type server_test.log
)

echo.
echo ============================================
echo    📊 RISULTATI DIAGNOSTICA
echo ============================================
echo.
echo Se vedi errori sopra, risolvi prima di continuare.
echo Se tutto è ✅, puoi provare ad avviare l'app.
echo.
echo 💡 Prossimo passo: 🚀 AVVIA APP.bat
echo.
pause
