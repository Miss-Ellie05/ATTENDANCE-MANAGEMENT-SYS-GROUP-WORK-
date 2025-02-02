<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendify - Smart Attendance System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.1/main.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f0f8ff;
        }
        .feature-card {
            border: 2px solid #007bff;
            border-radius: 10px;
            transition: transform 0.2s;
        }
        .feature-card:hover {
            transform: scale(1.05);
        }
        .btn-custom {
            background-color: #28a745;
            color: white;
        }
        .btn-custom:hover {
            background-color: #218838;
        }
    </style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-microphone-alt me-2"></i>Attendify
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="register.jsp">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container mt-5">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h1 class="display-4 fw-bold">Welcome to Attendify</h1>
                <p class="lead">The smart attendance tracking system for modern education</p>
                <div class="mt-4">
                    <a href="login.jsp" class="btn btn-custom btn-lg me-3">Get Started</a>
                    <a href="#features" class="btn btn-outline-primary btn-lg">Learn More</a>
                </div>
            </div>
            <div class="col-md-6">
                <img src="scr/images/go.png" alt="Attendify Hero" class="img-fluid">
            </div>
        </div>

        <section id="features" class="my-5">
            <h2 class="text-center mb-4">Features</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-microphone-alt fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">Voice Recognition Check-in</h5>
                            <p class="card-text">Easily check-in by speaking your name</p>
                            <button id="start-record-btn" class="btn btn-custom">Start Voice Check-in</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-map-marker-alt fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">Geolocation Verification</h5>
                            <p class="card-text">Ensure students are physically present in class</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-chart-bar fa-3x text-primary mb-3"></i>
                            <h5 class="card-title">Real-time Analytics</h5>
                            <p class="card-text">Track and analyze attendance patterns</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container text-center">
            <p>&copy; 2024 Attendify. All rights reserved.</p>
        </div>
    </footer>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JavaScript -->
    <script src="js/main.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.10.1/main.min.js"></script>
    <script>
        const startRecordBtn = document.getElementById('start-record-btn');
        const recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();

        recognition.onstart = function() {
            console.log('Voice recognition started. Try speaking into the microphone.');
        };

        recognition.onresult = function(event) {
            const transcript = event.results[0][0].transcript;
            alert(`You said: ${transcript}`);
            // Implement check-in logic here
        };

        startRecordBtn.addEventListener('click', () => {
            recognition.start();
        });
    </script>
</body>
</html>