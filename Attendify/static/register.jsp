<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Attendify</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('path/to/your/background-image.jpg'); /* Add your background image path here */
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }
        .form-container {
            border: 2px solid #007bff;
            border-radius: 10px;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-qrcode me-2"></i>Attendify
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
                        <a class="nav-link active" href="register.jsp">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container mt-5">
        <div class="form-container">
            <h2 class="text-center mb-4">Create an Account</h2>
            <div class="mb-4">
                <div class="btn-group w-100" role="group">
                    <input type="radio" class="btn-check" name="userType" id="studentRadio" autocomplete="off" checked>
                    <label class="btn btn-outline-primary" for="studentRadio">Student</label>
                    <input type="radio" class="btn-check" name="userType" id="lecturerRadio" autocomplete="off">
                    <label class="btn btn-outline-primary" for="lecturerRadio">Lecturer</label>
                </div>
            </div>
            <form id="registerForm" action="registerUser.jsp" method="post" onsubmit="return validateRegistrationForm()">
                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email address</label>
                    <input type="email" class="form-control" id="email" required>
                </div>
                <div class="mb-3">
                    <label for="faculty" class="form-label">Faculty</label>
                    <select class="form-select" id="faculty" required onchange="updateDepartments()">
                        <option value="" disabled selected>Select your faculty</option>
                        <option value="science">Science</option>
                        <option value="arts">Arts</option>
                        <option value="engineering">Engineering</option>
                        <option value="business">Business</option>
                        <option value="education">Education</option>
                        <!-- Add more faculties as needed -->
                    </select>
                </div>
                <div class="mb-3">
                    <label for="department" class="form-label">Department</label>
                    <select class="form-select" id="department" required>
                        <option value="" disabled selected>Select your department</option>
                        <!-- Departments will be populated based on faculty selection -->
                    </select>
                </div>
                <div class="mb-3">
                    <label for="studentId" class="form-label student-field">Student ID</label>
                    <label for="employeeId" class="form-label lecturer-field d-none">Employee ID</label>
                    <input type="text" class="form-control" id="idField" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="confirmPassword" required>
                        <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="termsCheck" required>
                    <label class="form-check-label" for="termsCheck">
                        I agree to the <a href="#" class="text-decoration-none">Terms and Conditions</a>
                    </label>
                </div>
                <button type="submit" class="btn btn-primary w-100">Register</button>
            </form>
            <hr class="my-4">
            <div class="text-center">
                <p>Already have an account? <a href="login.jsp" class="text-decoration-none">Login here</a></p>
            </div>
        </div>
    </main>

    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container text-center">
            <p>&copy; 2024 Attendify. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/register.js"></script>
    <script>
        function updateDepartments() {
            const faculty = document.getElementById('faculty').value;
            const departmentSelect = document.getElementById('department');
            departmentSelect.innerHTML = ''; // Clear existing options

            let departments = [];
            switch (faculty) {
                case 'science':
                    departments = ['Biology', 'Chemistry', 'Physics'];
                    break;
                case 'arts':
                    departments = ['History', 'Literature', 'Philosophy'];
                    break;
                case 'engineering':
                    departments = ['Computer Engineering', 'Civil Engineering', 'Mechanical Engineering'];
                    break;
                case 'business':
                    departments = ['Marketing', 'Finance', 'Human Resources'];
                    break;
                case 'education':
                    departments = ['Elementary Education', 'Secondary Education', 'Special Education'];
                    break;
                // Add more cases for additional faculties and their departments
            }

            departments.forEach(department => {
                const option = document.createElement('option');
                option.value = department.toLowerCase().replace(' ', '-'); // Format for easier use
                option.textContent = department;
                departmentSelect.appendChild(option);
            });
        }
    </script>
</body>
</html>