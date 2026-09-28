(function () {
    function applyTheme(theme) {
        document.documentElement.setAttribute('data-theme', theme);
        var icon = document.getElementById('theme-icon');
        if (icon) {
            icon.className = theme === 'dark' ? 'bi bi-sun-fill' : 'bi bi-moon-stars-fill';
        }
    }

    function currentTheme() {
        return localStorage.getItem('theme') || 'light';
    }

    applyTheme(currentTheme());

    window.toggleTheme = function () {
        var next = currentTheme() === 'dark' ? 'light' : 'dark';
        localStorage.setItem('theme', next);
        applyTheme(next);
    };
})();