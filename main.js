const { app, BrowserWindow } = require('electron');
const path = require('path');
const { spawn } = require('child_process');

let mainWindow;
let serverProcess;

// Funzione per avviare il server Express
function startServer() {
  // Avvia il server Node.js
  serverProcess = spawn('node', ['server.js'], {
    cwd: __dirname,
    stdio: ['pipe', 'pipe', 'pipe']
  });

  // Gestisci l'output del server
  serverProcess.stdout.on('data', (data) => {
    console.log(`Server: ${data}`);
  });

  serverProcess.stderr.on('data', (data) => {
    console.error(`Server Error: ${data}`);
  });

  serverProcess.on('close', (code) => {
    console.log(`Server process exited with code ${code}`);
  });
}

// Funzione per creare la finestra principale
function createWindow() {
  // Crea la finestra del browser
  mainWindow = new BrowserWindow({
    width: 1200,
    height: 800,
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      enableRemoteModule: false
    },
    icon: path.join(__dirname, 'icon.png'), // Puoi aggiungere un'icona se vuoi
    title: 'Speech to Text App',
    titleBarStyle: 'default',
    show: false // Non mostrare finché non è pronta
  });

  // Carica l'app
  mainWindow.loadURL('http://localhost:3000');

  // Mostra la finestra quando è pronta
  mainWindow.once('ready-to-show', () => {
    mainWindow.show();
  });

  // Gestisci la chiusura della finestra
  mainWindow.on('closed', () => {
    mainWindow = null;
  });

  // Apri DevTools in modalità sviluppo
  if (process.env.NODE_ENV === 'development') {
    mainWindow.webContents.openDevTools();
  }
}

// Quando Electron è pronto
app.whenReady().then(() => {
  // Avvia il server
  startServer();

  // Aspetta un momento per assicurarsi che il server sia avviato
  setTimeout(() => {
    createWindow();
  }, 2000);

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow();
    }
  });
});

// Quando tutte le finestre sono chiuse
app.on('window-all-closed', () => {
  // Termina il processo del server
  if (serverProcess) {
    serverProcess.kill();
  }

  // Su macOS, mantieni l'app attiva finché l'utente non fa Cmd+Q
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

// Gestisci la chiusura dell'app
app.on('before-quit', () => {
  if (serverProcess) {
    serverProcess.kill();
  }
});
