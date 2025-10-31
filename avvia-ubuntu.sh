#!/bin/bash

# Script semplificato per Ubuntu/Linux
# Questo script può essere eseguito con doppio click

echo "============================================"
echo "       🚀 SPEECH TO TEXT APP - UBUNTU"
echo "============================================"
echo ""
echo "Avvio semplificato per Ubuntu/Linux..."
echo ""

# Controlla se siamo nella directory giusta
if [ ! -f "package.json" ]; then
    echo "❌ ERRORE: Esegui questo script dalla cartella speech-to-text-app"
    echo "💡 Sposta il file nella cartella del progetto e riprova"
    echo ""
    read -p "Premi Enter per uscire..."
    exit 1
fi

# Controlla se .env esiste
if [ ! -f ".env" ]; then
    echo "❌ ERRORE: File .env non trovato"
    echo "💡 Copia .env.example in .env e configura la tua API key"
    echo ""
    read -p "Premi Enter per uscire..."
    exit 1
fi

echo "✅ Controlli passati, avvio applicazione..."
echo ""

# Avvia il server
echo "🔧 Avvio server..."
npm start &
SERVER_PID=$!

# Aspetta che il server si avvii
sleep 3

# Apri il browser
echo "🌐 Apertura browser..."
xdg-open http://localhost:3000 2>/dev/null || open http://localhost:3000 2>/dev/null || echo "💡 Apri manualmente: http://localhost:3000"

echo ""
echo "============================================"
echo "        ✅ APP AVVIATA!"
echo "============================================"
echo ""
echo "🌐 Vai su: http://localhost:3000"
echo "🔧 Server PID: $SERVER_PID"
echo ""
echo "💡 Premi Ctrl+C qui per chiudere tutto"
echo ""

# Gestisci la chiusura
cleanup() {
    echo ""
    echo "🔄 Chiusura server..."
    kill $SERVER_PID 2>/dev/null
    echo "✅ Fatto! Arrivederci!"
    exit 0
}

trap cleanup SIGINT
wait $SERVER_PID
