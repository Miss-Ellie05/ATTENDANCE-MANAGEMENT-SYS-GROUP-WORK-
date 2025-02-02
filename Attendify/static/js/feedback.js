// feedback.js

document.addEventListener('DOMContentLoaded', () => {
    const feedbackForm = document.getElementById('feedbackForm');

    feedbackForm.addEventListener('submit', (event) => {
        event.preventDefault();
        const feedbackMessage = document.getElementById('feedbackMessage').value;

        fetch('/api/student/feedback', { // Adjust the API endpoint as necessary
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ feedback: feedbackMessage }),
        })
        .then(response => {
            if (response.ok) {
                alert("Thank you for your feedback!");
                feedbackForm.reset(); // Reset the form after submission
            } else {
                alert("There was an error submitting your feedback.");
            }
        })
        .catch(error => console.error('Error submitting feedback:', error));
    });
});