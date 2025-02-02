// Toggle password visibility
document.getElementById('togglePassword').addEventListener('click', function() {
    const passwordInput = document.getElementById('password');
    const icon = this.querySelector('i');
    
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        passwordInput.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
});

// Form validation
function validateLoginForm() {
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const userType = document.getElementById('studentRadio').checked ? 'student' : 'lecturer';

    // Basic email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert('Please enter a valid email address');
        return false;
    }

    // Basic password validation
    if (password.length < 6) {
        alert('Password must be at least 6 characters long');
        return false;
    }

    // Redirect to appropriate dashboard based on user type
    // In a real application, you would make an API call to verify credentials
    if (userType === 'student') {
        window.location.href = 'student-dashboard.html';
    } else {
        window.location.href = 'lecturer-dashboard.html';
    }

    return false; // Prevent form submission for this example
}

// Remember me functionality
document.getElementById('loginForm').addEventListener('submit', function(e) {
    const rememberMe = document.getElementById('rememberMe').checked;
    const email = document.getElementById('email').value;
    
    if (rememberMe) {
        localStorage.setItem('rememberedEmail', email);
    } else {
        localStorage.removeItem('rememberedEmail');
    }
});

// Load remembered email if exists
window.addEventListener('load', function() {
    const rememberedEmail = localStorage.getItem('rememberedEmail');
    if (rememberedEmail) {
        document.getElementById('email').value = rememberedEmail;
        document.getElementById('rememberMe').checked = true;
    }
});
