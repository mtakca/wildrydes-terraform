function checkAuth() {
    const token = sessionStorage.getItem('idToken');
    if (!token && window.location.pathname === '/ride.html') {
        window.location.href = '/signin.html';
    }
}

checkAuth();
