<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Check-in - Attendify</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/lecturer-check-in.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="lecturer-dashboard.jsp">
                <i class="fas fa-chalkboard-teacher me-2"></i>Attendify
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="lecturer-dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="lecturer-check-in.jsp">Check-in</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <h2 class="text-center mb-4">Class Check-in</h2>
                        <div id="location-status" class="mt-3 text-center text-muted">
                            <i class="fas fa-map-marker-alt me-2"></i>
                            <span id="location-text">Checking location...</span>
                        </div>
                        <h4 class="mt-4">Voice Check-in for Students</h4>
                        <p>Please ask the students to say the following phrase to check in:</p>
                        <input type="text" id="requiredPhrase" class="form-control mb-3" placeholder="Enter the required phrase" />
                        <blockquote class="blockquote text-center">
                            <p class="mb-0" id="phraseDisplay">"I am present for the class."</p>
                        </blockquote>
                        <button id="startVoiceCheckIn" class="btn btn-primary">
                            <i class="fas fa-microphone me-2"></i>Start Voice Check-in
                        </button>
                        <div id="result" class="d-none alert alert-success mt-3">
                            <i class="fas fa-check-circle me-2"></i>
                            <span id="result-text"></span>
                        </div>
                        <div id="error" class="d-none alert alert-danger mt-3">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <span id="error-text"></span>
                        </div>
                    </div>
                </div>
                <div class="card mt-4">
                    <div class="card-body">
                        <h4 class="card-title">Feedback</h4>
                        <form id="feedbackForm" onsubmit="return submitFeedback()">
                            <textarea id="feedbackMessage" class="form-control mb-2" placeholder="Your feedback"></textarea>
                            <button type="submit" class="btn btn-custom">Submit Feedback</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container text-center">
            <p>&copy; 2024 Attendify. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/lecturer-check-in.js"></script> <!-- Link to the new JavaScript file -->
</body>
</html>