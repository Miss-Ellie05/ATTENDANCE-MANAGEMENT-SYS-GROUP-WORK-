const startVoiceCheckInButton = document.getElementById('startVoiceCheckIn');
const resultText = document.getElementById('result-text');
const resultDiv = document.getElementById('result');
const errorDiv = document.getElementById('error');
const errorText = document.getElementById('error-text');
const locationText = document.getElementById('location-text');
const requiredPhraseInput = document.getElementById('requiredPhrase');
const phraseDisplay = document.getElementById('phraseDisplay');

const recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();

recognition.onstart = function() {
    console.log('Voice recognition started. Please say the phrase.');
};

recognition.onresult = function(event) {
    const transcript = event.results[0][0].transcript;
    resultText.textContent = `You said: "${transcript}"`;
    resultDiv.classList.remove('d-none');
    errorDiv.classList.add('d-none');

    // Check if the phrase matches
    if (transcript.toLowerCase() === requiredPhraseInput.value.toLowerCase()) {
        // Handle successful check-in
        alert("Check-in successful!");
    } else {
        errorText.textContent = "The phrase did not match. Please try again.";
        errorDiv.classList.remove('d-none');
        resultDiv.classList.add('d-none');
    }
};

// Function to check geolocation
function checkLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition, showError);
    } else {
        locationText.textContent = "Geolocation is not supported by this browser.";
    }
}

function showPosition(position) {
    const lat = position.coords.latitude;
    const lon = position.coords.longitude;
    locationText.textContent = `Location: Latitude ${lat}, Longitude ${lon}`;
    // Additional logic to verify location can be added here
}

function showError(error) {
    switch(error.code) {
        case error.PERMISSION_DENIED:
            locationText.textContent = "User denied the request for Geolocation.";
            break;
        case error.POSITION_UNAVAILABLE:
            locationText.textContent = "Location information is unavailable.";
            break;
        case error.TIMEOUT:
            locationText.textContent = "The request to get user location timed out.";
            break;
        case error.UNKNOWN_ERROR:
            locationText.textContent = "An unknown error occurred.";
            break;
    }
}

// Event listener for the start button
startVoiceCheckInButton.addEventListener('click', () => {
    checkLocation(); // Check location before starting voice recognition
    recognition.start();
});