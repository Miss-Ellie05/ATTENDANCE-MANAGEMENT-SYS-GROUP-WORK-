<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lecturer Dashboard - Attendify</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.1/main.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.1/main.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="js/notifications.js"></script>
    <style>
        body {
            background-color: #f0f8ff;
            background-image: url('path/to/your/background-image.jpg'); /* Add your background image path here */
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }
        .navbar {
            background-color: #007bff; /* Primary color for the navbar */
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .card-title {
            color: #007bff;
        }
        .btn-custom {
            background-color: #28a745; /* Custom button color */
            color: white;
        }
        .btn-custom:hover {
            background-color: #218838; /* Darker shade on hover */
        }
        .icon {
            font-size: 50px; /* Size for icons */
        }
    </style>
</head>
<body class="bg-light">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-chalkboard-teacher me-2"></i>Attendify
            </a>
            <input type="text" id="searchInput" placeholder="Search users..." class="form-control me-2" />
            <button class="btn btn-outline-light" onclick="searchUsers()">Search</button>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#profile">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="lecturer-check-in.jsp">Check-In</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#courses">Courses</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#attendance">Attendance</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div id="calendar"></div>
    <main class="container mt-4">
        <!-- Profile Section -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body text-center">
                        <img src="images/default-avatar.png" class="rounded-circle mb-3" style="width: 150px;">
                        <h4 id="lecturerName">Lecturer Name</h4>
                        <p class="text-muted" id="lecturerId">ID: 67890</p>
                        <p class="text-muted" id="lecturerDepartment">Computer Science Department</p>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#profileModal">
                            Edit Profile
                        </button>
                    </div>
                </div>
            </div>

            <!-- Attendance Stats -->
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <h5 class="card-title">Overall Attendance</h5>
                                <canvas id="attendanceChartLecturer"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <h5 class="card-title">Today's Classes</h5>
                                <div id="todayClassesLecturer" class="list-group">
                                    <!-- Populated by JavaScript -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Course Management -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Course Management</h5>
                        <ul class="nav nav-tabs" id="courseTabs">
                            <li class="nav-item">
                                <a class="nav-link active" data-bs-toggle="tab" href="#assignments">Assignments</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-bs-toggle="tab" href="#materials">Course Materials</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-bs-toggle="tab" href="#grades">Grades</a>
                            </li>
                        </ul>
                        <div class="tab-content mt-3" id="courseContent">
                            <!-- Populated by JavaScript -->
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Attendance History -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Attendance History</h5>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Date</th>
                                        <th>Course</th>
                                        <th>Time</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody id="attendanceHistoryLecturer">
                                    <!-- Populated by JavaScript -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Profile Edit Modal -->
    <div class="modal fade" id="profileModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Profile</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="profileForm">
                        <div class="mb-3">
                            <label class="form-label">Profile Picture</label>
                            <input type="file" class="form-control" id="profilePicture">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phoneNumber">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" id="email">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="saveProfile">Save Changes</button>
                </div>
            </div>
        </div>
    </div>

    <form id="feedbackForm" onsubmit="return submitFeedback()">
        <textarea id="feedbackMessage" placeholder="Your feedback" class="form-control mb-2"></textarea>
        <button type="submit" class="btn btn-custom">Submit Feedback</button>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/lecturer-dashboard.js"></script>
</body>
</html>