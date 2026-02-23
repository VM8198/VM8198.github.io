// =========================================
// Dynamic Image Gallery Loader
// =========================================
let galleryImages = [];

// Load images from JSON file
async function loadGalleryImages() {
    try {
        const response = await fetch('images.json');
        const data = await response.json();
        
        // Store images for filtering
        galleryImages = [
            ...data.bridal.map(img => ({ ...img, category: 'bridal' })),
            ...data.arabic.map(img => ({ ...img, category: 'arabic' })),
            ...data.minimal.map(img => ({ ...img, category: 'minimal' })),
            ...data.backhand.map(img => ({ ...img, category: 'backhand' }))
        ];
        
        // Render gallery
        renderGallery(galleryImages);
        
        // Load special images
        loadSpecialImages(data);
        
        console.log(`✅ Loaded ${galleryImages.length} gallery images automatically!`);
    } catch (error) {
        console.warn('⚠️ images.json not found. Run generate-images.ps1 to create it.');
        console.warn('Using placeholder images for now.');
    }
}

// Render gallery items
function renderGallery(images) {
    const galleryGrid = document.getElementById('galleryGrid');
    
    // Only clear if we have images to show
    if (images.length === 0) return;
    
    galleryGrid.innerHTML = '';
    
    images.forEach((img, index) => {
        const galleryItem = document.createElement('div');
        galleryItem.className = 'gallery-item fade-up';
        galleryItem.setAttribute('data-category', img.category);
        
        galleryItem.innerHTML = `
            <img src="${img.src}" alt="${img.alt}" loading="lazy">
            <div class="gallery-overlay">
                <i class="fas fa-search-plus"></i>
            </div>
        `;
        
        // Add click event for lightbox
        galleryItem.addEventListener('click', () => {
            openLightbox(img.src, img.alt);
        });
        
        galleryGrid.appendChild(galleryItem);
        
        // Observe for animation
        observer.observe(galleryItem);
    });
}

// Load special images (hero, about, services)
function loadSpecialImages(data) {
    // Hero background
    if (data.hero) {
        const heroSection = document.querySelector('.hero');
        heroSection.style.backgroundImage = `linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('${data.hero}')`;
        heroSection.classList.add('has-image');
    }
    
    // About image
    if (data.about) {
        const aboutImg = document.querySelector('.about-image img');
        const aboutImage = document.querySelector('.about-image');
        const aboutContent = document.querySelector('.about-content');
        if (aboutImg) {
            aboutImg.src = data.about;
            aboutImage.classList.add('show');
            aboutContent.classList.add('has-image');
        }
    }
    
    // Service images
    const serviceImages = {
        bridal: document.querySelector('.service-card:nth-child(1) .service-image img'),
        arabic: document.querySelector('.service-card:nth-child(2) .service-image img'),
        party: document.querySelector('.service-card:nth-child(3) .service-image img'),
        festival: document.querySelector('.service-card:nth-child(4) .service-image img'),
        kids: document.querySelector('.service-card:nth-child(5) .service-image img')
    };
    
    Object.keys(serviceImages).forEach(key => {
        if (data.services[key] && serviceImages[key]) {
            serviceImages[key].src = data.services[key];
        }
    });
}

// Open lightbox with image
function openLightbox(src, alt) {
    const lightbox = document.getElementById('lightbox');
    const lightboxImage = document.getElementById('lightboxImage');
    const lightboxCaption = document.getElementById('lightboxCaption');
    
    lightboxImage.src = src;
    lightboxCaption.textContent = alt;
    lightbox.classList.add('active');
    document.body.style.overflow = 'hidden';
}

// Initialize gallery on page load
document.addEventListener('DOMContentLoaded', () => {
    loadGalleryImages();
});

// =========================================
// Smooth Scrolling for Navigation Links
// =========================================
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        
        if (target) {
            const navHeight = document.querySelector('.navbar').offsetHeight;
            const targetPosition = target.offsetTop - navHeight;
            
            window.scrollTo({
                top: targetPosition,
                behavior: 'smooth'
            });
            
            // Close mobile menu if open
            const navMenu = document.getElementById('navMenu');
            const hamburger = document.getElementById('hamburger');
            if (navMenu.classList.contains('active')) {
                navMenu.classList.remove('active');
                hamburger.classList.remove('active');
            }
        }
    });
});

// =========================================
// Hamburger Menu Toggle
// =========================================
const hamburger = document.getElementById('hamburger');
const navMenu = document.getElementById('navMenu');

hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('active');
    navMenu.classList.toggle('active');
});

// Close menu when clicking outside
document.addEventListener('click', (e) => {
    if (!hamburger.contains(e.target) && !navMenu.contains(e.target)) {
        hamburger.classList.remove('active');
        navMenu.classList.remove('active');
    }
});

// =========================================
// Navbar Background on Scroll
// =========================================
window.addEventListener('scroll', () => {
    const navbar = document.querySelector('.navbar');
    
    if (window.scrollY > 100) {
        navbar.style.boxShadow = '0 4px 20px rgba(0, 0, 0, 0.1)';
    } else {
        navbar.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.08)';
    }
});

// =========================================
// Gallery Filter Functionality
// =========================================
const filterButtons = document.querySelectorAll('.filter-btn');

filterButtons.forEach(button => {
    button.addEventListener('click', () => {
        // Remove active class from all buttons
        filterButtons.forEach(btn => btn.classList.remove('active'));
        
        // Add active class to clicked button
        button.classList.add('active');
        
        // Get filter value
        const filterValue = button.getAttribute('data-filter');
        
        // Filter and render images
        if (filterValue === 'all') {
            renderGallery(galleryImages);
        } else {
            const filteredImages = galleryImages.filter(img => img.category === filterValue);
            renderGallery(filteredImages);
        }
    });
});

// =========================================
// Lightbox Functionality
// =========================================
const lightbox = document.getElementById('lightbox');
const lightboxClose = document.querySelector('.lightbox-close');

// Close lightbox
lightboxClose.addEventListener('click', closeLightbox);

lightbox.addEventListener('click', (e) => {
    if (e.target === lightbox) {
        closeLightbox();
    }
});

// Close lightbox with Escape key
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && lightbox.classList.contains('active')) {
        closeLightbox();
    }
});

function closeLightbox() {
    lightbox.classList.remove('active');
    document.body.style.overflow = 'auto'; // Re-enable scrolling
}

// =========================================
// Scroll to Top Button
// =========================================
const scrollToTopBtn = document.getElementById('scrollToTop');

window.addEventListener('scroll', () => {
    if (window.scrollY > 300) {
        scrollToTopBtn.classList.add('active');
    } else {
        scrollToTopBtn.classList.remove('active');
    }
});

scrollToTopBtn.addEventListener('click', () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});

// =========================================
// Intersection Observer for Fade-up Animation
// =========================================
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('visible');
            // Optionally unobserve after animation
            observer.unobserve(entry.target);
        }
    });
}, observerOptions);

// Observe all elements with fade-up class
const fadeElements = document.querySelectorAll('.fade-up');
fadeElements.forEach(element => {
    observer.observe(element);
});

// =========================================
// Active Navigation Link on Scroll
// =========================================
const sections = document.querySelectorAll('section[id]');
const navLinks = document.querySelectorAll('.nav-link');

window.addEventListener('scroll', () => {
    let current = '';
    const navHeight = document.querySelector('.navbar').offsetHeight;
    
    sections.forEach(section => {
        const sectionTop = section.offsetTop - navHeight - 100;
        const sectionHeight = section.offsetHeight;
        
        if (window.scrollY >= sectionTop && window.scrollY < sectionTop + sectionHeight) {
            current = section.getAttribute('id');
        }
    });
    
    navLinks.forEach(link => {
        link.classList.remove('active');
        if (link.getAttribute('href') === `#${current}`) {
            link.classList.add('active');
        }
    });
});

// =========================================
// Lazy Loading Images (Optional Enhancement)
// =========================================
if ('IntersectionObserver' in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.classList.add('loaded');
                observer.unobserve(img);
            }
        });
    });
    
    const images = document.querySelectorAll('img');
    images.forEach(img => imageObserver.observe(img));
}

// =========================================
// Prevent Default Link Behavior on Empty Links
// =========================================
document.querySelectorAll('a[href="#"]').forEach(link => {
    link.addEventListener('click', (e) => {
        e.preventDefault();
    });
});

// =========================================
// Performance: Debounce Scroll Events
// =========================================
function debounce(func, wait = 10, immediate = true) {
    let timeout;
    return function() {
        const context = this;
        const args = arguments;
        const later = function() {
            timeout = null;
            if (!immediate) func.apply(context, args);
        };
        const callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func.apply(context, args);
    };
}

// Apply debounce to scroll-heavy functions if needed
const efficientScrollHandler = debounce(function() {
    // Any scroll-heavy operations can go here
}, 10);

window.addEventListener('scroll', efficientScrollHandler);

// =========================================
// Console Log - Remove in Production
// =========================================
console.log('%cPriti\'s Mehandi Art Website', 'color: #d4a373; font-size: 20px; font-weight: bold;');
console.log('%cWebsite loaded successfully! ✨', 'color: #f4c2c2; font-size: 14px;');

// =========================================
// Form Validation (If you add a contact form later)
// =========================================
// Example function for form validation
function validateForm(formElement) {
    const inputs = formElement.querySelectorAll('input[required], textarea[required]');
    let isValid = true;
    
    inputs.forEach(input => {
        if (!input.value.trim()) {
            isValid = false;
            input.classList.add('error');
        } else {
            input.classList.remove('error');
        }
    });
    
    return isValid;
}

// =========================================
// Loading Animation (Optional)
// =========================================
window.addEventListener('load', () => {
    document.body.classList.add('loaded');
    
    // Remove any preloader if you add one
    const preloader = document.querySelector('.preloader');
    if (preloader) {
        setTimeout(() => {
            preloader.style.opacity = '0';
            setTimeout(() => {
                preloader.style.display = 'none';
            }, 300);
        }, 500);
    }
});

// =========================================
// Prevent Right Click on Images (Optional - Protection)
// =========================================
// Uncomment if you want to prevent right-click on gallery images
/*
const galleryImages = document.querySelectorAll('.gallery-item img');
galleryImages.forEach(img => {
    img.addEventListener('contextmenu', (e) => {
        e.preventDefault();
        return false;
    });
});
*/

// =========================================
// Analytics Event Tracking (Optional)
// =========================================
// Track CTA button clicks
const ctaButtons = document.querySelectorAll('.cta-button, .instagram-button');
ctaButtons.forEach(button => {
    button.addEventListener('click', () => {
        // Add your analytics tracking code here
        // Example: gtag('event', 'click', { 'event_category': 'CTA', 'event_label': 'Instagram' });
        console.log('CTA Button clicked - Track this event');
    });
});

// Track gallery filter usage
filterButtons.forEach(button => {
    button.addEventListener('click', () => {
        const filterValue = button.getAttribute('data-filter');
        // Add your analytics tracking code here
        console.log(`Gallery filtered by: ${filterValue}`);
    });
});

// =========================================
// Dynamic Year in Footer (Keep copyright updated)
// =========================================
const currentYear = new Date().getFullYear();
const footerYear = document.querySelector('.footer-bottom p');
if (footerYear) {
    footerYear.innerHTML = footerYear.innerHTML.replace('2026', currentYear);
}

// =========================================
// Easter Egg (Optional Fun Element)
// =========================================
let clickCount = 0;
const logo = document.querySelector('.logo');

logo.addEventListener('click', () => {
    clickCount++;
    if (clickCount === 5) {
        console.log('%c🎨 You found the secret! Thanks for exploring! 🎨', 'color: #d4a373; font-size: 16px;');
        clickCount = 0;
    }
});

// =========================================
// Service Worker Registration (Optional - PWA)
// =========================================
// Uncomment to enable Progressive Web App features
/*
if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('/sw.js')
            .then(registration => console.log('SW registered:', registration))
            .catch(error => console.log('SW registration failed:', error));
    });
}
*/
