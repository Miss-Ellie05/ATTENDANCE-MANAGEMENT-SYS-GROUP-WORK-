// profile.js

document.addEventListener('DOMContentLoaded', () => {
    fetchStudentProfile();
});

function fetchStudentProfile() {
    fetch('/api/student/profile') // Adjust the API endpoint as necessary
        .then(response => response.json())
        .then(data => {
            document.getElementById('studentName').textContent = data.name;
            document.getElementById('studentEmail').textContent = data.email;
            document.getElementById('studentID').textContent = data.studentID;
        })
        .catch(error => console.error('Error fetching student profile:', error));
}