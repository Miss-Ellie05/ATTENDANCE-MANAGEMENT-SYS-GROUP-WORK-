// grades.js

document.addEventListener('DOMContentLoaded', () => {
    fetchStudentGrades();
});

function fetchStudentGrades() {
    fetch('/api/student/grades') // Adjust the API endpoint as necessary
        .then(response => response.json())
        .then(data => {
            const gradesBody = document.getElementById('gradesBody');
            data.forEach(grade => {
                const row = `<tr>
                    <td>${grade.course}</td>
                    <td>${grade.grade}</td>
                    <td>${grade.comments}</td>
                </tr>`;
                gradesBody.innerHTML += row;
            });
        })
        .catch(error => console.error('Error fetching student grades:', error));
}