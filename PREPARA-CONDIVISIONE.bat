@echo off
chcp 65001 > nul
echo.
echo ============================================
echo    📦 PREPARAZIONE APP PER CONDIVISIONE
echo ============================================
echo.
echo Questo script prepara l'app per essere condivisa
echo con colleghi o altri utenti.
echo.
pause

echo.
echo [1/4] Controllo struttura progetto...
if not exist "package.json" (
    echo ❌ ERRORE: package.json non trovato!
    echo 💡 Esegui questo script dalla cartella speech-to-text-app
    pause
    exit /b 1
)
if not exist "node_modules" (
    echo ❌ ERRORE: node_modules non trovato!
    echo 💡 Esegui prima: npm install
    pause
    exit /b 1
)
echo ✅ Struttura OK

echo.
echo [2/4] Controllo file essenziali...
if not exist ".env" (
    echo ⚠️  ATTENZIONE: File .env non trovato
    echo 💡 Ricorda al collega di creare .env con la sua API key
    echo.
)
if exist "🚀 AVVIA APP.bat" (
    echo ✅ File di avvio Windows trovato
) else (
    echo ❌ ERRORE: File 🚀 AVVIA APP.bat mancante
    pause
    exit /b 1
)
echo ✅ File essenziali OK

echo.
echo [3/4] Pulizia file temporanei...
if exist "*.log" del *.log 2>nul
if exist ".DS_Store" del .DS_Store 2>nul
for /d /r . %%d in (node_modules) do (
    if exist "%%d\.DS_Store" del "%%d\.DS_Store" 2>nul
)
echo ✅ Pulizia completata

echo.
echo [4/4] Creazione istruzioni per il collega...
echo.
echo ============================================
echo    📋 ISTRUZIONI PER IL COLLEGA
echo ============================================
echo.
echo 1️⃣  Estrai il file ZIP in una cartella
echo 2️⃣  Apri il file "AVVIA QUI.txt" e leggi le istruzioni
echo 3️⃣  Modifica ".env" con la tua API key OpenAI
echo 4️⃣  Fai DOPPIO CLICK su "🚀 AVVIA APP.bat"
echo 5️⃣  L'app si aprirà automaticamente!
echo.
echo ⚠️  IMPORTANTE:
echo    - Assicurati di avere Node.js installato
echo    - L'API key è personale e segreta
echo.
echo ============================================
echo.
echo ✅ PREPARAZIONE COMPLETATA!
echo.
echo 💡 Ora puoi comprimere la cartella in ZIP
echo    e condividerla con il tuo collega.
echo.
echo 📁 File da includere nel ZIP:
echo    - Tutta la cartella speech-to-text-app/
echo.
pause
