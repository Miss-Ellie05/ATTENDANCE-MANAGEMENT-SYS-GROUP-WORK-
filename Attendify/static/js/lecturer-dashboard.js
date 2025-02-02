// Function to handle profile update
function updateProfile(event) {
    event.preventDefault(); // Prevent the default form submission

    const fullName = document.getElementById('fullName').value;
    const email = document.getElementById('email').value;
    const phoneNumber = document.getElementById('phoneNumber').value;

    const profileData = {
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
    };

    fetch('/api/users/profile', { // Update this URL to match your backend endpoint
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(profileData),
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.json();
    })
    .then(data => {
        alert('Profile updated successfully!');
        // Optionally, you can update the UI with the new data
    })
    .catch(error => {
        console.error('Error updating profile:', error);
        alert('Failed to update profile. Please try again.');
    });
}

// Function to handle feedback submission
function submitFeedback(event) {
    event.preventDefault(); // Prevent the default form submission

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

// Function to fetch attendance stats and populate the chart
function fetchAttendanceStats() {
    fetch('/api/attendance/reports') // Update this URL to match your backend endpoint
        .then(response => response.json())
        .then(data => {
            // Assuming data is an array of attendance records
            const ctx = document.getElementById('attendanceChartLecturer').getContext('2d');
            const labels = data.map(record => record.date); // Adjust based on your data structure
            const attendanceCounts = data.map(record => record.status === 'Present' ? 1 : 0); // Example logic

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Attendance',
                        data: attendanceCounts,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        })
        .catch(error => {
            console.error('Error fetching attendance stats:', error);
        });
}

// Attach event listeners
document.getElementById('profileForm').addEventListener('submit', updateProfile);
document.getElementById('feedbackForm').addEventListener('submit', submitFeedback);
document.getElementById('saveProfile').addEventListener('click', updateProfile);

// Fetch attendance stats on page load
document.addEventListener('DOMContentLoaded', fetchAttendanceStats);