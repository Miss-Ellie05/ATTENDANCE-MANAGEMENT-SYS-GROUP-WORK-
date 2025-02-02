// Service Worker Registration
if ('serviceWorker' in navigator && 'PushManager' in window) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('/sw.js')
            .then(registration => {
                console.log('ServiceWorker registration successful');
                initializeNotifications();
            })
            .catch(error => console.log('ServiceWorker registration failed:', error));
    });
}
function searchUsers() {
    const query = document.getElementById('searchInput').value;
    fetch(`/api/users/search?query=${query}`)
        .then(response => response.json())
        .then(data => {
            // Handle displaying search results
        });
}
function submitFeedback() {
    const message = document.getElementById('feedbackMessage').value;
    fetch('/api/feedback', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ message })
    })
    .then(response => response.json())
    .then(data => {
        // Handle successful feedback submission
    });
    return false; // Prevent form submission
}
// Initialize notification toggle
function initializeNotifications() {
    const notificationToggle = document.getElementById('notificationToggle');
    Notification.requestPermission().then(permission => {
        notificationToggle.checked = permission === 'granted';
    });

    notificationToggle.addEventListener('change', async () => {
        if (notificationToggle.checked) {
            const permission = await Notification.requestPermission();
            if (permission === 'granted') {
                await subscribeToNotifications();
            } else {
                notificationToggle.checked = false;
            }
        } else {
            await unsubscribeFromNotifications();
        }
    });
}

// Student Profile Management
class StudentProfile {
    static async loadProfile() {
        try {
            const response = await fetch('/api/student/profile');
            const profile = await response.json();
            
            document.getElementById('studentName').textContent = profile.name;
            document.getElementById('studentId').textContent = `ID: ${profile.studentId}`;
            document.getElementById('studentProgram').textContent = profile.program;
            
            // Load form data
            document.getElementById('phoneNumber').value = profile.phone;
            document.getElementById('email').value = profile.email;
        } catch (error) {
            console.error('Error loading profile:', error);
        }
    }

    static async saveProfile(formData) {
        try {
            const response = await fetch('/api/student/profile', {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData)
            });
            return response.ok;
        } catch (error) {
            console.error('Error saving profile:', error);
            return false;
        }
    }
}

// Attendance Chart
class AttendanceChart {
    static initialize() {
        const ctx = document.getElementById('attendanceChart').getContext('2d');
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Present', 'Absent', 'Late'],
                datasets: [{
                    data: [85, 10, 5],
                    backgroundColor: ['#28a745', '#dc3545', '#ffc107']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });
    }

    static async loadAttendanceHistory() {
        try {
            const response = await fetch('/api/student/attendance-history');
            const history = await response.json();
            const tbody = document.getElementById('attendanceHistory');
            
            tbody.innerHTML = history.map(record => `
                <tr>
                    <td>${new Date(record.date).toLocaleDateString()}</td>
                    <td>${record.course}</td>
                    <td>${record.time}</td>
                    <td><span class="badge bg-${record.status === 'Present' ? 'success' : 'danger'}">${record.status}</span></td>
                </tr>
            `).join('');
        } catch (error) {
            console.error('Error loading attendance history:', error);
        }
    }
}

// LMS Integration
class LMSIntegration {
    static async loadAssignments() {
        try {
            const response = await fetch('/api/lms/assignments');
            const assignments = await response.json();
            document.querySelector('#assignments').innerHTML = assignments.map(assignment => `
                <div class="card mb-2">
                    <div class="card-body">
                        <h6>${assignment.title}</h6>
                        <p class="text-muted">Due: ${new Date(assignment.dueDate).toLocaleDateString()}</p>
                        <a href="${assignment.link}" class="btn btn-sm btn-primary">View Assignment</a>
                    </div>
                </div>
            `).join('');
        } catch (error) {
            console.error('Error loading assignments:', error);
        }
    }

    static async loadMaterials() {
        try {
            const response = await fetch('/api/lms/materials');
            const materials = await response.json();
            document.querySelector('#materials').innerHTML = materials.map(material => `
                <div class="card mb-2">
                    <div class="card-body">
                        <h6>${material.title}</h6>
                        <p class="text-muted">${material.description}</p>
                        <a href="${material.link}" class="btn btn-sm btn-primary">Download</a>
                    </div>
                </div>
            `).join('');
        } catch (error) {
            console.error('Error loading materials:', error);
        }
    }
}

// Initialize everything when the page loads
document.addEventListener('DOMContentLoaded', () => {
    StudentProfile.loadProfile();
    AttendanceChart.initialize();
    AttendanceChart.loadAttendanceHistory();
    LMSIntegration.loadAssignments();
    LMSIntegration.loadMaterials();

    // Handle profile form submission
    document.getElementById('saveProfile').addEventListener('click', async () => {
        const formData = {
            phone: document.getElementById('phoneNumber').value,
            email: document.getElementById('email').value,
            picture: document.getElementById('profilePicture').files[0]
        };
        
        if (await StudentProfile.saveProfile(formData)) {
            bootstrap.Modal.getInstance(document.getElementById('profileModal')).hide();
            await StudentProfile.loadProfile();
        }
    });
});