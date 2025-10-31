require('dotenv').config();
const express = require('express');
const multer = require('multer');
const cors = require('cors');
const OpenAI = require('openai');
const path = require('path');

const app = express();

// Initialize OpenAI client
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY, // Make sure to set your API key in environment variables
});

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('public')); // Serve static files from public directory

// Configure multer for file uploads
const storage = multer.memoryStorage();
const upload = multer({
  storage: storage,
  limits: {
    fileSize: 25 * 1024 * 1024, // 25MB limit
  },
  fileFilter: (req, file, cb) => {
    // Check file type
    const allowedTypes = ['audio/mpeg', 'audio/mp4', 'audio/mpeg', 'audio/mpga', 'audio/m4a', 'audio/wav', 'audio/webm'];
    if (allowedTypes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error('Invalid file type. Only audio files are allowed.'));
    }
  }
});

// Transcription endpoint
app.post('/transcribe', upload.single('audio'), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'No audio file provided' });
    }

    // Create a readable stream from the buffer
    const audioBuffer = req.file.buffer;
    const audioStream = require('stream').Readable.from(audioBuffer);

    // Transcribe using OpenAI
    const transcription = await openai.audio.transcriptions.create({
      file: audioStream,
      model: 'gpt-4o-transcribe', // Using the latest model
      response_format: 'json',
    });

    res.json({
      text: transcription.text,
      success: true
    });

  } catch (error) {
    console.error('Transcription error:', error);
    res.status(500).json({
      error: 'Failed to transcribe audio',
      details: error.message
    });
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'OK', message: 'Speech to Text API is running' });
});

const port = process.env.PORT || 3000;

if (require.main === module) {
  // Solo se eseguito direttamente (non su Vercel)
  app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
  });
}

module.exports = app;
