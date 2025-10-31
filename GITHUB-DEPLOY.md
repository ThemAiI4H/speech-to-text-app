# 🚀 Deploy su GitHub Pages

Questa guida ti spiega come rendere la tua app accessibile online gratuitamente tramite GitHub Pages.

## 📋 Prerequisiti

- Account GitHub (gratuito)
- Repository creato su GitHub

## 🎯 Cosa Pubblichi

**GitHub Pages pubblicherà:**
- ✅ **Demo interattiva** (`demo.html`) - Interfaccia completa con simulazioni
- ✅ **Documentazione** (`README.md`)
- ✅ **Istruzioni** (`AVVIA QUI.txt`)

**NON pubblicherà:**
- ❌ Backend Node.js (richiede server dedicato)
- ❌ API reali OpenAI (solo simulazioni)

## 📝 Istruzioni Passo-Passo

### 1️⃣ Carica il Progetto su GitHub

```bash
# Inizializza git (se non già fatto)
git init
git add .
git commit -m "Prima versione Speech to Text App"

# Crea repository su GitHub, poi:
git remote add origin https://github.com/TUO-USERNAME/speech-to-text-app.git
git push -u origin main
```

### 2️⃣ Attiva GitHub Pages

1. **Vai sul tuo repository** su GitHub
2. **Clicca su "Settings"** (tab in alto)
3. **Scorri fino a "Pages"** (menu laterale sinistro)
4. **Seleziona:**
   - **Source:** `Deploy from a branch`
   - **Branch:** `main`
   - **Folder:** `/ (root)`
5. **Clicca "Save"**

### 3️⃣ Attendi il Deploy

- GitHub impiegherà **2-3 minuti** per pubblicare
- Riceverai una notifica email quando pronto
- **URL finale:** `https://TUO-USERNAME.github.io/speech-to-text-app`

## 🔧 Personalizzazioni (Opzionali)

### Cambia il Titolo della Repository
- Su GitHub: Settings → General → Repository name
- Questo cambia l'URL finale

### Aggiungi Dominio Personalizzato
- Settings → Pages → Custom domain
- Inserisci il tuo dominio (es: `mia-app.com`)

### Aggiorna Link nella Demo
- Modifica `public/demo.html`
- Sostituisci `TUO-USERNAME` con il tuo username GitHub

## 🌐 Cosa Vedranno i Visitatori

La pagina demo mostrerà:
- 🎨 Interfaccia completa con glassmorphism
- 🎭 Simulazioni di registrazione e trascrizione
- 📖 Link per scaricare la versione completa
- 📋 Istruzioni per l'installazione locale

## 🔄 Aggiornamenti Automatici

Ogni volta che fai push su `main`, GitHub Pages si aggiornerà automaticamente!

```bash
# Dopo modifiche:
git add .
git commit -m "Aggiornamento app"
git push
```

## 🚀 Alternative per Backend Completo

Se vuoi la **versione completa funzionante**, deploya il backend su:

### **Vercel (Gratuito)**
```bash
npm i -g vercel
vercel --prod
```

### **Railway (Gratuito)**
- Connetti repository GitHub
- Deploy automatico

### **Render (Gratuito)**
- Deploy da GitHub
- Supporto Node.js

## 📞 Supporto

- 📖 **Documentazione:** `README.md`
- 🐛 **Problemi:** Apri issue su GitHub
- 💬 **Domande:** Usa Discussions su GitHub

---

**🎉 Congratulazioni!** La tua app è ora online e accessibile a tutti! 🌐
