@echo off
chcp 65001 > nul
echo.
echo ============================================
echo    🔍 CONTROLLO PREREQUISITI
echo ============================================
echo.
echo Verifico che tutto sia pronto per l'app...
echo.

set ERROR_COUNT=0

echo [1/4] Controllo Node.js...
where node > nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo ✅ Node.js trovato: %NODE_VERSION%
) else (
    echo ❌ Node.js NON trovato!
    echo 📥 Scarica da: https://nodejs.org
    set /a ERROR_COUNT+=1
)

echo.
echo [2/4] Controllo npm...
where npm > nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
    echo ✅ npm trovato: %NPM_VERSION%
) else (
    echo ❌ npm NON trovato!
    echo 💡 npm è incluso con Node.js
    set /a ERROR_COUNT+=1
)

echo.
echo [3/4] Controllo dipendenze progetto...
if exist "package.json" (
    echo ✅ package.json trovato
    if exist "node_modules" (
        echo ✅ node_modules trovato (dipendenze installate)
    ) else (
        echo ⚠️  node_modules NON trovato
        echo 💡 Esegui: npm install
    )
) else (
    echo ❌ package.json NON trovato!
    echo 💡 Assicurati di essere nella cartella speech-to-text-app
    set /a ERROR_COUNT+=1
)

echo.
echo [4/4] Controllo configurazione API...
if exist ".env" (
    echo ✅ File .env trovato
    findstr /C:"OPENAI_API_KEY=" .env > nul
    if %errorlevel% equ 0 (
        echo ✅ API key configurata in .env
    ) else (
        echo ⚠️  API key NON trovata in .env
        echo 💡 Aggiungi: OPENAI_API_KEY=sk-your-key-here
    )
) else (
    echo ❌ File .env NON trovato!
    echo 💡 Copia .env.example in .env e configura
    set /a ERROR_COUNT+=1
)

echo.
echo ============================================
if %ERROR_COUNT% equ 0 (
    echo    ✅ TUTTO OK! Puoi avviare l'app
    echo.
    echo 💡 Prossimo passo:
    echo    Fai doppio click su "🚀 AVVIA APP.bat"
) else (
    echo    ❌ TROVATI %ERROR_COUNT% ERRORI
    echo.
    echo 💡 Risolvi i problemi sopra, poi riprova
)
echo ============================================
echo.
pause
