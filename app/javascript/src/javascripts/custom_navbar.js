window.onload = function () {
    customNav();
  }
  // Toggle open and close nav styles on click
  function customNav() {
    var topbar = document.getElementById('overlay-topbar');
    var navbar = document.getElementById('overlay-navbar');

    document.getElementById('nav-toggle').addEventListener('click', function() {
      // Hamburger to X toggle
      this.classList.toggle('active');

      // toggle navbar and topbar
      if (this.classList.contains('active')) {
        navbar.style.display = 'block';
        if (topbar){
          topbar.style.display = 'none';
        }
      }
      else {
        navbar.style.display = 'none';
        if (topbar){
          topbar.style.display = 'block';
        }
      }
    });
  }
