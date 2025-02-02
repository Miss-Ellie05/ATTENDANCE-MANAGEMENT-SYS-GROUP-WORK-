// assignments.js

document.addEventListener('DOMContentLoaded', () => {
    fetchStudentAssignments();
});

function fetchStudentAssignments() {
    fetch('/api/student/assignments') // Adjust the API endpoint as necessary
        .then(response => response.json())
        .then(data => {
            const assignmentsBody = document.getElementById('assignmentsBody');
            data.forEach(assignment => {
                const row = `<tr>
                    <td>${assignment.title}</td>
                    <td>${assignment.dueDate}</td>
                    <td>${assignment.status}</td>
                </tr>`;
                assignmentsBody.innerHTML += row;
            });
        })
        .catch(error => console.error('Error fetching student assignments:', error));
}