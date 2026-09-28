(function () {
    var MOBILE_QUERY = window.matchMedia('(max-width: 768px)');

    function isMobile() {
        return MOBILE_QUERY.matches;
    }

    function isCollapsed() {
        return localStorage.getItem('sidebar-collapsed') === 'true';
    }

    function applyCollapsed(collapsed) {
        document.body.classList.toggle('sidebar-collapsed', collapsed);
    }

    applyCollapsed(isCollapsed());

    window.toggleSidebar = function () {
        if (isMobile()) {
            document.body.classList.toggle('mobile-sidebar-open');
            return;
        }
        var collapsed = !document.body.classList.contains('sidebar-collapsed');
        applyCollapsed(collapsed);
        localStorage.setItem('sidebar-collapsed', collapsed);
    };

    var backdrop = document.querySelector('.backdrop');
    if (backdrop) {
        backdrop.addEventListener('click', function () {
            document.body.classList.remove('mobile-sidebar-open');
        });
    }

    MOBILE_QUERY.addEventListener('change', function () {
        document.body.classList.remove('mobile-sidebar-open');
    });
})();