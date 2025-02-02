// Function to handle manual check-in
function handleManualCheckIn(event) {
    event.preventDefault(); // Prevent the default form submission

    const classCode = document.getElementById('classCode').value;

    const checkInData = {
        classCode: classCode,
        // You can add more data here if needed (e.g., user ID, timestamp)
    };

    fetch('/api/checkins', { // Update this URL to match your backend endpoint
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(checkInData),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        alert('Check-in successful!');const startVoiceCheckInButton = document.getElementById('startVoiceCheckIn');
        const resultText = document.getElementById('result-text');
        const resultDiv = document.getElementById('result');
        const errorDiv = document.getElementById('error');
        const errorText = document.getElementById('error-text');
        const locationText = document.getElementById('location-text');
        const requiredPhraseInput = document.getElementById('requiredPhrase');
        const phraseDisplay = document.getElementById('phraseDisplay');
        
        // Check geolocation
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
        
        startVoiceCheckInButton.addEventListener('click', () => {
            checkLocation(); // Check location before starting voice recognition
            recognition.start();
        });
        // Optionally, you can update the UI with the new data or reset the form
        document.getElementById('manualCheckInForm').reset();
    })
    .catch(error => {
        console.error('Error during check-in:', error);
        alert('Check-in failed. Please try again.');
    });
}

// Function to handle feedback submission
function submitFeedback() {
    const feedbackMessage = document.getElementById('feedbackMessage').value;

    const feedbackData = {
        message: feedbackMessage,
    };

    fetch('/api/feedback', { // Update this URL to match your backend endpoint
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(feedbackData),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        alert('Feedback submitted successfully!');
        document.getElementById('feedbackMessage').value = ''; // Clear the textarea
    })
    .catch(error => {
        console.error('Error submitting feedback:', error);
        alert('Failed to submit feedback. Please try again.');
    });
}

// QR Code Scanner Initialization
const html5QrCode = new Html5Qrcode("reader");

function startScanner() {
    const config = { fps: 10, qrbox: 250 };
    html5QrCode.start(
        { facingMode: "environment" }, // Use the environment camera
        config,
        qrCodeMessage => {
            // Handle the QR code message
            document.getElementById('result-text').innerText = qrCodeMessage;
            document.getElementById('result').classList.remove('d-none');
            // Optionally, you can call the check-in function here
            handleManualCheckIn({ preventDefault: () => {} }); // Simulate form submission
        },
        errorMessage => {
            // Handle scanning errors
            console.warn(`QR Code scan error: ${errorMessage}`);
        }
    ).catch(err => {
        console.error(`Failed to start scanning: ${err}`);
    });
}

// Attach event listeners
document.getElementById('manualCheckInForm').addEventListener('submit', handleManualCheckIn);
document.getElementById('feedbackForm').addEventListener('submit', submitFeedback);
document.getElementById('startButton').addEventListener('click', startScanner);