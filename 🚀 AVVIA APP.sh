#!/bin/bash

clear
echo ""
echo "============================================"
echo "       🚀 SPEECH TO TEXT APP"
echo "============================================"
echo ""
echo "Avvio automatico dell'applicazione..."
echo ""
echo "Assicurati di aver configurato il file .env"
echo "con la tua API key OpenAI"
echo ""
read -p "Premi Enter per continuare..."

echo ""
echo "[1/3] Controllo dipendenze..."

# Controlla se npm è installato
if ! command -v npm &> /dev/null; then
    echo "❌ ERRORE: npm non trovato. Installa Node.js"
    echo "📥 Scarica da: https://nodejs.org"
    echo ""
    read -p "Premi Enter per uscire..."
    exit 1
fi
echo "✅ npm trovato"

echo ""
echo "[2/3] Avvio server in background..."
# Avvia il server in background
npm start &
SERVER_PID=$!
sleep 2

echo ""
echo "[3/3] Apertura applicazione..."
# Apri il browser
if command -v xdg-open &> /dev/null; then
    xdg-open http://localhost:3000
elif command -v open &> /dev/null; then
    open http://localhost:3000
else
    echo "🌐 Apri manualmente: http://localhost:3000"
fi

echo ""
echo "============================================"
echo "      ✅ APP AVVIATA CON SUCCESSO!"
echo "============================================"
echo ""
echo "🌐 Browser aperto su: http://localhost:3000"
echo "🔧 Server attivo in background (PID: $SERVER_PID)"
echo "❌ Premi Ctrl+C per chiudere tutto"
echo ""

# Funzione di cleanup
cleanup() {
    echo ""
    echo "Spegnimento server..."
    kill $SERVER_PID 2>/dev/null
    echo "✅ Fatto! Arrivederci!"
    exit 0
}

# Imposta il trap per Ctrl+C
trap cleanup SIGINT

# Mantieni lo script attivo
echo "L'app è ora attiva. Premi Ctrl+C per chiudere."
wait $SERVER_PID
