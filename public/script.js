// DOM elements
const recordBtn = document.getElementById('recordBtn');
const stopBtn = document.getElementById('stopBtn');
const recordingStatus = document.getElementById('recordingStatus');
const audioFile = document.getElementById('audioFile');
const uploadBtn = document.getElementById('uploadBtn');
const transcriptionResult = document.getElementById('transcriptionResult');
const loading = document.getElementById('loading');

// Global variables
let mediaRecorder;
let audioChunks = [];
let isRecording = false;

// Check if browser supports MediaRecorder
if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
    alert('Your browser does not support audio recording. Please use a modern browser like Chrome, Firefox, or Edge.');
    recordBtn.disabled = true;
}

// Recording functionality
recordBtn.addEventListener('click', startRecording);
stopBtn.addEventListener('click', stopRecording);
uploadBtn.addEventListener('click', uploadFile);

async function startRecording() {
    try {
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true });

        mediaRecorder = new MediaRecorder(stream);
        audioChunks = [];

        mediaRecorder.ondataavailable = (event) => {
            audioChunks.push(event.data);
        };

        mediaRecorder.onstop = () => {
            const audioBlob = new Blob(audioChunks, { type: 'audio/wav' });
            transcribeAudio(audioBlob);

            // Stop all tracks to release microphone
            stream.getTracks().forEach(track => track.stop());
        };

        mediaRecorder.start();
        isRecording = true;

        // Update UI
        recordBtn.disabled = true;
        stopBtn.disabled = false;
        recordingStatus.textContent = 'Recording...';
        recordingStatus.className = 'status recording';

    } catch (error) {
        console.error('Error starting recording:', error);
        alert('Error accessing microphone. Please check permissions.');
    }
}

function stopRecording() {
    if (mediaRecorder && isRecording) {
        mediaRecorder.stop();
        isRecording = false;

        // Update UI
        recordBtn.disabled = false;
        stopBtn.disabled = true;
        recordingStatus.textContent = 'Processing...';
        recordingStatus.className = 'status not-recording';
    }
}

async function uploadFile() {
    const file = audioFile.files[0];
    if (!file) {
        alert('Please select an audio file first.');
        return;
    }

    // Check file size (25MB limit)
    if (file.size > 25 * 1024 * 1024) {
        alert('File size must be less than 25MB.');
        return;
    }

    transcribeAudio(file);
}

async function transcribeAudio(audioBlob) {
    // Show loading
    loading.style.display = 'block';
    transcriptionResult.innerHTML = '<p class="placeholder">Transcribing...</p>';

    try {
        const formData = new FormData();
        formData.append('audio', audioBlob, 'recording.wav');

        const response = await fetch('/transcribe', {
            method: 'POST',
            body: formData
        });

        const result = await response.json();

        if (result.success) {
            displayTranscription(result.text);
        } else {
            throw new Error(result.error || 'Transcription failed');
        }

    } catch (error) {
        console.error('Transcription error:', error);
        displayError(error.message);
    } finally {
        loading.style.display = 'none';
        recordingStatus.textContent = 'Not recording';
        recordingStatus.className = 'status not-recording';
    }
}

function displayTranscription(text) {
    transcriptionResult.innerHTML = `<p class="transcription-text">${text}</p>`;
}

function displayError(message) {
    transcriptionResult.innerHTML = `<p style="color: #f44336; font-weight: bold;">Error: ${message}</p>`;
}

// Reset recording status when page loads
recordingStatus.className = 'status not-recording';
