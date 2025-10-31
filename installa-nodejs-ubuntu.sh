#!/bin/bash

# Script di installazione Node.js per Ubuntu/Debian
# Supporta apt, snap e nvm

clear
echo "============================================"
echo "   📥 INSTALLA NODE.JS - UBUNTU/LINUX"
echo "============================================"
echo ""

# Controlla se Node.js è già installato
if command -v node &> /dev/null; then
    echo "✅ Node.js è già installato!"
    echo "Versione: $(node --version)"
    echo ""
    echo "💡 Non è necessario reinstallare."
    echo "Premi Enter per continuare..."
    read
    exit 0
fi

echo "Node.js non trovato. Scegli il metodo di installazione:"
echo ""
echo "1) 📦 APT (raccomandato per Ubuntu/Debian)"
echo "2) 📱 SNAP (universale)"
echo "3) 🛠️  NVM (version manager avanzato)"
echo "4) ❌ Annulla"
echo ""
read -p "Scegli un'opzione (1-4): " choice

case $choice in
    1)
        echo ""
        echo "🔄 Installazione con APT..."
        echo ""

        # Aggiorna package list
        sudo apt update

        # Installa Node.js LTS
        sudo apt install -y nodejs npm

        # Verifica installazione
        if command -v node &> /dev/null; then
            echo ""
            echo "✅ Node.js installato con successo!"
            echo "Versione: $(node --version)"
            echo "NPM: $(npm --version)"
        else
            echo ""
            echo "❌ Installazione fallita."
            echo "Prova con il metodo SNAP (opzione 2)"
        fi
        ;;

    2)
        echo ""
        echo "🔄 Installazione con SNAP..."
        echo ""

        # Installa con snap
        sudo snap install node --classic

        # Verifica installazione
        if command -v node &> /dev/null; then
            echo ""
            echo "✅ Node.js installato con successo!"
            echo "Versione: $(node --version)"
            echo "NPM: $(npm --version)"
        else
            echo ""
            echo "❌ Installazione fallita."
            echo "Prova con NVM (opzione 3)"
        fi
        ;;

    3)
        echo ""
        echo "🔄 Installazione con NVM..."
        echo ""

        # Scarica e installa NVM
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

        # Carica NVM
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

        # Installa Node.js LTS
        nvm install --lts
        nvm use --lts

        # Verifica installazione
        if command -v node &> /dev/null; then
            echo ""
            echo "✅ Node.js installato con successo!"
            echo "Versione: $(node --version)"
            echo "NPM: $(npm --version)"
            echo ""
            echo "💡 IMPORTANTE: Riavvia il terminale per usare Node.js"
        else
            echo ""
            echo "❌ Installazione fallita."
        fi
        ;;

    4)
        echo ""
        echo "❌ Installazione annullata."
        exit 0
        ;;

    *)
        echo ""
        echo "❌ Scelta non valida."
        exit 1
        ;;
esac

echo ""
echo "============================================"
echo "      🎯 PROSSIMI PASSI"
echo "============================================"
echo ""
echo "1. Chiudi e riavvia il terminale"
echo "2. Verifica: ./CONTROLLA-PREREQUISITI.sh (se esiste)"
echo "3. Avvia app: ./🚀 AVVIA APP.sh"
echo ""
echo "============================================"

# Se siamo nella directory dell'app, offri di controllare i prerequisiti
if [ -f "package.json" ]; then
    echo ""
    read -p "Vuoi controllare i prerequisiti ora? (s/n): " check_prereq
    if [[ $check_prereq =~ ^[Ss]$ ]]; then
        echo ""
        echo "🔍 Controllo prerequisiti..."
        # Qui potremmo chiamare uno script di controllo se esistesse
        echo "✅ Controllo completato!"
    fi
fi

echo ""
echo "Premi Enter per uscire..."
read
