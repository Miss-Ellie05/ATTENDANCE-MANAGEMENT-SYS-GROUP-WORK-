// Toggle user type fields
document.getElementById('studentRadio').addEventListener('change', toggleUserTypeFields);
document.getElementById('lecturerRadio').addEventListener('change', toggleUserTypeFields);

function toggleUserTypeFields() {
    const isStudent = document.getElementById('studentRadio').checked;
    const studentField = document.querySelector('.student-field');
    const lecturerField = document.querySelector('.lecturer-field');
    
    if (isStudent) {
        studentField.classList.remove('d-none');
        lecturerField.classList.add('d-none');
    } else {
        studentField.classList.add('d-none');
        lecturerField.classList.remove('d-none');
    }
}

// Toggle password visibility
document.getElementById('togglePassword').addEventListener('click', function() {
    togglePasswordVisibility('password', this);
});

document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
    togglePasswordVisibility('confirmPassword', this);
});

function togglePasswordVisibility(inputId, button) {
    const passwordInput = document.getElementById(inputId);
    const icon = button.querySelector('i');
    
    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
    } else {
        passwordInput.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
    }
}

// Form validation
function validateRegistrationForm() {
    const fullName = document.getElementById('fullName').value;
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const idField = document.getElementById('idField').value;
    const userType = document.getElementById('studentRadio').checked ? 'student' : 'lecturer';

    // Name validation
    if (fullName.length < 2) {
        alert('Please enter a valid name');
        return false;
    }

    // Email validation
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert('Please enter a valid email address');
        return false;
    }

    // ID validation
    if (idField.length < 5) {
        alert('Please enter a valid ID number');
        return false;
    }

    // Password validation
    if (password.length < 6) {
        alert('Password must be at least 6 characters long');
        return false;
    }

    if (password !== confirmPassword) {
        alert('Passwords do not match');
        return false;
    }

    // Allow form submission
    return true; // Allow form submission if all validations pass
}

// Initialize user type fields on page load
window.addEventListener('load', toggleUserTypeFields);