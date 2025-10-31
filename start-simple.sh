#!/bin/bash

echo "============================================"
echo "   SPEECH TO TEXT APP - Avvio Semplice"
echo "============================================"
echo ""
echo "Questa versione apre automaticamente il browser"
echo "dopo aver avviato il server in background."
echo ""
echo "Assicurati di aver configurato il file .env"
echo "con la tua API key OpenAI"
echo ""
read -p "Premi Enter per continuare..."

echo ""
echo "Avvio del server..."

# Avvia il server in background
npm start &
SERVER_PID=$!

echo "Attesa avvio server..."
sleep 3

echo "Apertura browser..."
if command -v xdg-open &> /dev/null; then
    xdg-open http://localhost:3000
elif command -v open &> /dev/null; then
    open http://localhost:3000
else
    echo "Apri manualmente: http://localhost:3000"
fi

echo ""
echo "============================================"
echo "App avviata! Il server gira in background."
echo "PID del server: $SERVER_PID"
echo "============================================"
echo ""
echo "Premi Ctrl+C per fermare il server quando hai finito."

# Mantieni lo script attivo
wait $SERVER_PID
