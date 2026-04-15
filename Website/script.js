document.addEventListener('DOMContentLoaded', () => {
  // Navigation Bar Scroll Effect
  const nav = document.querySelector('.top-nav');
  window.addEventListener('scroll', () => {
    if (window.scrollY > 20) {
      nav.classList.add('scrolled');
    } else {
      nav.classList.remove('scrolled');
    }
  });

  // Intersection Observer for scroll animations
  const fadeElements = document.querySelectorAll('.fade-in-up');
  
  const observerOptions = {
    root: null,
    rootMargin: '0px',
    threshold: 0.15
  };
  
  const observer = new IntersectionObserver((entries, observer) => {
    entries.forEach(entry => {
      // If the element is visible
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        // Optional: unobserve if you only want the animation to happen once
        observer.unobserve(entry.target);
      }
    });
  }, observerOptions);
  
  fadeElements.forEach(el => observer.observe(el));
  
  // Quick fix: Trigger visible class if elements are already in view on load
  setTimeout(() => {
    fadeElements.forEach(el => {
      const rect = el.getBoundingClientRect();
      if(rect.top < window.innerHeight) {
        el.classList.add('visible');
      }
    });
  }, 100);
  
  // Smooth scroll for anchor links
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      const targetId = this.getAttribute('href');
      if(targetId === '#') return;
      const targetElement = document.querySelector(targetId);
      if (targetElement) {
        targetElement.scrollIntoView({
          behavior: 'smooth'
        });
      }
    });
  });

  // Video Controls Logic
  const video = document.getElementById('demoVideo');
  const playPauseBtn = document.getElementById('playPauseBtn');
  const fullscreenBtn = document.getElementById('fullscreenBtn');
  const videoContainer = video.parentElement;

  if (video) {
    playPauseBtn.addEventListener('click', () => {
      if (video.paused) {
        video.play();
        playPauseBtn.innerHTML = '<i class="ph-fill ph-pause"></i>';
      } else {
        video.pause();
        playPauseBtn.innerHTML = '<i class="ph-fill ph-play"></i>';
      }
    });

    fullscreenBtn.addEventListener('click', () => {
      if (video.requestFullscreen) {
        video.requestFullscreen();
      } else if (video.webkitRequestFullscreen) { /* Safari */
        video.webkitRequestFullscreen();
      } else if (video.msRequestFullscreen) { /* IE11 */
        video.msRequestFullscreen();
      }
    });

    // Toggle play on video click too
    video.addEventListener('click', () => {
      playPauseBtn.click();
    });

    // Check if video file exists/loads
    video.addEventListener('error', () => {
      document.getElementById('mockupFallback').style.display = 'flex';
      video.style.display = 'none';
      document.querySelector('.video-controls-overlay').style.display = 'none';
    });
  }
});
