# Speech to Text App

A full-stack web application that converts speech to text using OpenAI's Audio API.

## Features

- **Audio Recording**: Record audio directly from your microphone
- **File Upload**: Upload audio files for transcription
- **Real-time Transcription**: Get instant text transcription using OpenAI's GPT-4o-transcribe model
- **Modern UI**: Clean, responsive interface with loading indicators

## Supported Audio Formats

- MP3
- MP4
- MPEG
- MPGA
- M4A
- WAV
- WebM

Maximum file size: 25MB

## Prerequisites

### 🔧 Software Richiesto:
- **Node.js** (versione 14 o superiore) - [Scarica qui](https://nodejs.org)
- **Browser web moderno** (Chrome, Firefox, Edge, Safari)
- **Connessione internet** (per le API OpenAI)

### 🔑 Account e API Key:
- **API Key OpenAI** gratuita - [Registrati qui](https://platform.openai.com)
  - Credito gratuito iniziale per testare
  - Pagamento solo per uso intensivo

## Installation

1. Clone or download this repository
2. Navigate to the project directory:
   ```bash
   cd speech-to-text-app
   ```

3. Install dependencies:
   ```bash
   npm install
   ```

4. Create a `.env` file in the root directory and add your OpenAI API key:
   ```
   OPENAI_API_KEY=your_api_key_here
   ```

## Usage

### Opzione 1: Applicazione Desktop (Raccomandata - Doppio Click)

1. **Installazione una tantum:**
   ```bash
   npm install
   ```

2. **Configura l'API Key:**
   Modifica il file `.env` e inserisci la tua chiave OpenAI:
   ```
   OPENAI_API_KEY=your_actual_openai_api_key_here
   ```

3. **Avvia l'app con DOPPIO CLICK:**

   **🚀 AVVIO RAPIDO (Raccomandato):**
   - **Windows:** Fai doppio click sul file `🚀 AVVIA APP.bat`
   - **macOS/Linux:** Fai doppio click sul file `🚀 AVVIA APP.sh`

   **📋 Altre Opzioni:**

   **Opzione A: App Desktop Electron:**
   ```bash
   npm run electron
   ```

   **Opzione B: Browser Automatico:**
   - Windows: Doppio click su `start-simple.bat`
   - Ubuntu/Linux: Doppio click su `avvia-ubuntu.sh`
   - macOS/Altro Linux: Doppio click su `start-simple.sh`

   **Opzione C: Avvio Manuale:**
   - Windows: Doppio click su `start-app.bat`
   - macOS/Linux: `./start-app.sh`

4. L'app si aprirà automaticamente con il frontend e il backend attivi in background.

### Opzione 2: Sviluppo Web (Browser)

1. Start the server:
   ```bash
   npm start
   ```

2. Open your browser and go to `http://localhost:3000`

3. Choose one of two options:
   - **Record Audio**: Click "Start Recording" and speak into your microphone, then click "Stop Recording"
   - **Upload File**: Select an audio file and click "Transcribe File"

4. The transcription will appear in the results section

## API Endpoints

- `GET /health` - Health check
- `POST /transcribe` - Transcribe audio file (expects multipart/form-data with 'audio' field)

## Development

For development with auto-restart, install nodemon globally and use:
```bash
npm run dev
```

## Browser Support

This application uses the MediaRecorder API for audio recording. Supported browsers:
- Chrome 47+
- Firefox 25+
- Edge 79+
- Safari 14.1+

## Security Notes

- Audio files are processed in memory and not stored on the server
- Make sure to keep your OpenAI API key secure and never commit it to version control
- The application runs on localhost by default for security

## 🌐 Deploy Online

### GitHub Pages (Demo Frontend)
La versione demo può essere deployata gratuitamente su GitHub Pages:

1. **Carica il progetto** su GitHub
2. **Vai su Settings → Pages**
3. **Seleziona branch `main`** e cartella `/ (root)`
4. **Attiva GitHub Actions** (include workflow automatico)
5. **URL:** `https://TUO-USERNAME.github.io/speech-to-text-app`

**Cosa mostra:** Interfaccia completa con simulazione delle funzionalità

### 🚀 Deploy Backend Completo

Per la versione completa con backend, usa una di queste piattaforme:

#### **Opzione 1: Vercel (Raccomandato)**
```bash
npm i -g vercel
vercel --prod
```

#### **Opzione 2: Railway**
- Connetti repository GitHub
- Deploy automatico
- Database incluso se necessario

#### **Opzione 3: Render**
- Deploy da GitHub
- Supporto Node.js nativo
- Free tier disponibile

### 📱 Demo Interattiva
Visita la demo live: https://ThemAiI4H.github.io/speech-to-text-app *(deploy automatico)*

## License

ISC
