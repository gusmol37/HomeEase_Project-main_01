document.addEventListener('DOMContentLoaded', function() {
    // Toggle password visibility
    const togglePasswordButtons = document.querySelectorAll('.toggle-password');
    togglePasswordButtons.forEach(button => {
        button.addEventListener('click', function() {
            const input = this.previousElementSibling;
            const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
            input.setAttribute('type', type);
            this.querySelector('i').classList.toggle('fa-eye');
            this.querySelector('i').classList.toggle('fa-eye-slash');
        });
    });

    // Form validation
    const forms = document.querySelectorAll('.needs-validation');
    
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', async function(event) {
            event.preventDefault();
            event.stopPropagation();
            
            // Validate passwords match
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            if (password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('Las contraseñas no coinciden');
            } else {
                confirmPassword.setCustomValidity('');
            }
            
            form.classList.add('was-validated');
            
            if (form.checkValidity()) {
                // Form is valid, proceed with registration
                await registerUser();
            }
        }, false);
    });

    // Registration function
    async function registerUser() {
        const formData = {
            firstName: document.getElementById('firstName').value,
            lastName: document.getElementById('lastName').value,
            email: document.getElementById('email').value,
            phone: document.getElementById('phone').value,
            password: document.getElementById('password').value,
            userType: document.getElementById('userType').value
        };

        try {
            // Here you would typically make an API call to your backend
            // For this frontend example, we'll simulate a successful registration
            console.log('Registration data:', formData);
            
            // Simulate API call delay
            await new Promise(resolve => setTimeout(resolve, 1500));
            
            // Show success message
            alert('Registro exitoso. Por favor revisa tu correo para activar tu cuenta.');
            
            // Redirect to login page
            window.location.href = 'login.html';
        } catch (error) {
            console.error('Registration error:', error);
            alert('Error en el registro. Por favor intenta nuevamente.');
        }
    }

    // Login form handling (if on login page)
    if (window.location.pathname.includes('login.html')) {
        const loginForm = document.getElementById('loginForm');
        if (loginForm) {
            loginForm.addEventListener('submit', async function(e) {
                e.preventDefault();
                
                const email = document.getElementById('loginEmail').value;
                const password = document.getElementById('loginPassword').value;
                const rememberMe = document.getElementById('rememberMe').checked;
                
                try {
                    // Here you would make an API call to your backend
                    console.log('Login attempt:', { email, password, rememberMe });
                    
                    // Simulate API call delay
                    await new Promise(resolve => setTimeout(resolve, 1000));
                    
                    // For demo purposes, redirect based on email
                    if (email.includes('admin@')) {
                        window.location.href = '../admin/dashboard.html';
                    } else if (email.includes('provider@')) {
                        window.location.href = '../provider/dashboard.html';
                    } else {
                        window.location.href = '../client/dashboard.html';
                    }
                } catch (error) {
                    console.error('Login error:', error);
                    alert('Credenciales incorrectas. Por favor intenta nuevamente.');
                }
            });
        }
    }
});