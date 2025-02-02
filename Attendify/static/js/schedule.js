// schedule.js

document.addEventListener('DOMContentLoaded', () => {
    fetchStudentSchedule();
});

function fetchStudentSchedule() {
    fetch('/api/student/schedule') // Adjust the API endpoint as necessary
        .then(response => response.json())
        .then(data => {
            const scheduleBody = document.getElementById('scheduleBody');
            data.forEach(course => {
                const row = `<tr>
                    <td>${course.name}</td>
                    <td>${course.day}</td>
                    <td>${course.time}</td>
                    <td>${course.location}</td>
                </tr>`;
                scheduleBody.innerHTML += row;
            });
        })
        .catch(error => console.error('Error fetching student schedule:', error));
}