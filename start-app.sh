#!/bin/bash

echo "Avvio Speech to Text App..."
echo ""
echo "Assicurati di aver configurato il file .env con la tua API key OpenAI"
echo ""

# Controlla se npm è installato
if ! command -v npm &> /dev/null; then
    echo "Errore: npm non è installato. Installa Node.js prima di continuare."
    exit 1
fi

# Controlla se il file .env esiste
if [ ! -f ".env" ]; then
    echo "Errore: file .env non trovato. Copia .env.example in .env e configura la tua API key."
    exit 1
fi

# Avvia l'app Electron
npm run electron
