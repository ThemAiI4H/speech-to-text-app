@echo off
chcp 65001 > nul
echo.
echo ============================================
echo    📥 INSTALLA NODE.JS - WINDOWS
echo ============================================
echo.
echo Questo script installera' Node.js automaticamente
echo utilizzando il gestore di pacchetti Chocolatey
echo o scaricando direttamente il file MSI.
echo.

REM Controlla se Node.js è già installato
where node > nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Node.js è già installato!
    for /f "tokens=*" %%i in ('node --version') do echo Versione: %%i
    echo.
    echo 💡 Non è necessario reinstallare.
    pause
    exit /b 0
)

echo [1/2] Controllo Chocolatey...
where choco > nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Chocolatey trovato, installo Node.js...
    echo.
    choco install nodejs -y
    if %errorlevel% equ 0 (
        echo.
        echo ✅ Node.js installato con successo!
        echo Riavvia il terminale e riprova.
    ) else (
        echo.
        echo ❌ Errore nell'installazione con Chocolatey.
    )
) else (
    echo ❌ Chocolatey non trovato.
    echo.
    echo [2/2] Scarico installer MSI...
    echo.
    echo 💡 Verrà aperto il browser per scaricare Node.js
    echo 📥 Scarica la versione LTS da: https://nodejs.org
    echo.
    echo Dopo l'installazione:
    echo 1. Riavvia questo terminale
    echo 2. Esegui: CONTROLLA-PREREQUISITI.bat
    echo 3. Poi: 🚀 AVVIA APP.bat
    echo.
    start https://nodejs.org
)

echo.
echo ============================================
echo    💡 PROSSIMI PASSI:
echo ============================================
echo.
echo 1. Chiudi e riavvia il terminale
echo 2. Verifica: CONTROLLA-PREREQUISITI.bat
echo 3. Avvia app: 🚀 AVVIA APP.bat
echo.
pause
