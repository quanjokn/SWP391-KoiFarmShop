document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('.login100-form');
    const emailInput = form.querySelector('input[name="email"]');
    const usernameInput = form.querySelector('input[name="username"]');
    const passwordInput = form.querySelector('input[name="pass"]');
    const phoneInput = form.querySelector('input[name="phone-number"]');

    form.addEventListener('submit', function(event) {
        event.preventDefault();
        let valid = true;
        
        // Clear previous error messages
        form.querySelectorAll('.alert-validate').forEach(el => el.classList.remove('alert-validate'));
        
        // Validate email
        if (!validateEmail(emailInput.value)) {
            showError(emailInput, 'Email is required');
            valid = false;
        }
        
        // Validate username
        if (!usernameInput.value.trim()) {
            showError(usernameInput, 'Username is required');
            valid = false;
        }
        
        // Validate password
        if (!passwordInput.value.trim()) {
            showError(passwordInput, 'Password is required');
            valid = false;
        }
        
        // Validate phone number
        if (!validatePhoneNumber(phoneInput.value)) {
            showError(phoneInput, 'Phone number must be 10 digits');
            valid = false;
        }
        
        if (valid) {
            alert('Đăng ký thành công');
            window.location.href = 'index.html';
        }
    });
    
    function showError(input, message) {
        const container = input.closest('.wrap-input100');
        const alert = document.createElement('div');
        alert.classList.add('alert-validate');
        alert.setAttribute('data-validate', message);
        container.appendChild(alert);
    }

    function validateEmail(email) {
        // Simple email validation regex
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    }

    function validatePhoneNumber(phoneNumber) {
        // Phone number should be exactly 10 digits
        return /^\d{10}$/.test(phoneNumber);
    }
});
