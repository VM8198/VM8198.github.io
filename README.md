# Priti's Mehandi Art - Website

🎨 A fully responsive, professional static website for a Mehandi artist brand built with HTML5, CSS3, and Vanilla JavaScript.

## 🌟 Features

✅ **Fully Responsive Design** - Mobile-first approach, works perfectly on all devices
✅ **Beautiful UI/UX** - Elegant, premium, feminine aesthetic with soft color palette
✅ **Smooth Animations** - Fade-in on scroll, hover effects, and smooth transitions
✅ **Interactive Gallery** - Category filtering and lightbox modal
✅ **SEO Optimized** - Proper meta tags and semantic HTML5
✅ **Performance Optimized** - Clean code, CSS variables, and lazy loading
✅ **GitHub Pages Ready** - Deploy instantly to GitHub Pages
✅ **No Dependencies** - Pure vanilla JavaScript, no frameworks required

## 📁 Project Structure

```
pma/
│
├── index.html              # Main HTML file
│
├── css/
│   └── style.css          # All styles with CSS variables
│
├── js/
│   └── script.js          # All JavaScript functionality
│
└── images/
    ├── bridal/            # Bridal mehandi images
    ├── arabic/            # Arabic mehandi images
    ├── minimal/           # Minimal design images
    ├── backhand/          # Back hand mehandi images
    └── others/            # Other category images
```

## 🚀 Quick Start

### 0. Create Placeholder Images (Optional but Recommended!)

**Want to avoid naming confusion?** Create placeholder images with the correct names:

```
Double-click: create-placeholders.ps1
```

This creates placeholder image files with the exact names needed:
- ✅ `hero-bg.jpg` in `images/`
- ✅ `about.jpg` in `images/`
- ✅ All service images in `images/others/`

**Then just replace these files with your actual photos - no renaming needed!**

See [PLACEHOLDER-GUIDE.txt](PLACEHOLDER-GUIDE.txt) for detailed instructions.

### 1. Add Your Images - **AUTOMATIC LOADING!** ✨

**No HTML editing required!** Just drop images in folders and run a simple script.

Add photos to the appropriate folders:
- `images/bridal/` - Bridal mehandi designs
- `images/arabic/` - Arabic mehandi designs  
- `images/minimal/` - Minimal mehandi designs
- `images/backhand/` - Back hand mehandi designs
- `images/others/` - Service images, hero background, about photo

**Important images for `images/others/` folder:**
- `hero-bg.jpg` (or .png) - Main page background
- `about.jpg` (or .png) - Your photo for About section
- `service-bridal.jpg` - Bridal service card image
- `service-arabic.jpg` - Arabic service card image
- `service-party.jpg` - Party service card image
- `service-festival.jpg` - Festival service card image
- `service-kids.jpg` - Kids service card image

**✨ NO RESIZING NEEDED!**
- ✅ Just drop your mobile phone photos directly!
- ✅ Any size works - the design auto-adjusts
- ✅ Any aspect ratio (portrait, landscape, square)
- ✅ The website handles everything automatically
- 💡 **Tip:** For best quality, compress large images at [TinyPNG.com](https://tinypng.com) (optional but recommended)

### 2. Run the Gallery Generator

**Super Easy - One Double-Click:**

```
Double-click: UPDATE-GALLERY.bat
```

This automatically:
- ✅ Scans all image folders
- ✅ Finds all your photos
- ✅ Generates `images.json` file
- ✅ Gallery updates instantly!

**Alternative:** Run from command line:
```powershell
.\generate-images.ps1
```

### 3. View Your Website

Open `index.html` in your browser - all your images appear automatically in the gallery!

### 2. Update Instagram Links

In `index.html`, replace `YOUR_INSTAGRAM_ID` with your actual Instagram username:

```html
<!-- Find and replace these lines: -->
<a href="https://instagram.com/YOUR_INSTAGRAM_ID" target="_blank">

<!-- With: -->
<a href="https://instagram.com/your_actual_username" target="_blank">
```

There are 3 instances to update:
- Line 41: Hero section CTA button
- Line 370: Instagram section button
- Line 379: Instagram section text

### 3. Customize Colors (Optional)

All colors are defined as CSS variables in `css/style.css` (lines 5-14):

```css
:root {
    --primary-color: #d4a373;      /* Main brand color */
    --secondary-color: #f4c2c2;    /* Accent pink */
    --accent-color: #c9ada7;       /* Soft accent */
    --gold-accent: #d4af37;        /* Gold highlights */
    /* ... more colors */
}
```

Change these values to customize the entire color scheme!

## 🔄 Updating Your Gallery

**Want to add or remove images later?**

It's super easy:

1. **Add/Remove** images from the folders
2. **Double-click** `UPDATE-GALLERY.bat`
3. **Done!** Gallery updates automatically

**For GitHub Pages deployment:**
- After running UPDATE-GALLERY.bat
- Commit and push the new `images.json` file to GitHub
- Your live site updates with new images!

**No HTML editing ever required!** 🎉

## 🌐 Deployment to GitHub Pages

### Method 1: Using GitHub Desktop or Web Interface

1. Create a new repository on GitHub
2. Upload all files to the repository
3. Go to **Settings** → **Pages**
4. Under **Source**, select **main** branch
5. Click **Save**
6. Your site will be live at: `https://your-username.github.io/repository-name/`

### Method 2: Using Git Command Line

```bash
# Initialize git repository
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - Priti's Mehandi Art Website"

# Add remote repository (create it on GitHub first)
git remote add origin https://github.com/your-username/repository-name.git

# Push to GitHub
git branch -M main
git push -u origin main
```

Then enable GitHub Pages in repository settings.

## 📱 Testing Locally

Simply open `index.html` in your browser:

- **Windows**: Right-click `index.html` → Open with → Your browser
- **Mac**: Double-click `index.html`
- **VS Code**: Install "Live Server" extension and click "Go Live"

## 🎨 Customization Guide

### Changing Text Content

All text can be edited directly in `index.html`:

- **Brand Name**: Line 31 (Logo) and throughout
- **Tagline**: Line 42
- **About Text**: Lines 61-62
- **Service Descriptions**: Lines 75-127
- **Testimonials**: Lines 238-282
- **Footer**: Lines 294-318

### Adding More Gallery Images

**It's automatic!**

1. Drop new images in the appropriate folder (`images/bridal/`, etc.)
2. Double-click `UPDATE-GALLERY.bat`
3. Images appear automatically - no HTML editing needed!

The script scans all folders and updates the gallery for you.

### Modifying Sections

To add/remove sections:
1. Copy/remove the section HTML in `index.html`
2. Add corresponding navigation link
3. Styles will auto-apply based on existing classes

## 🔧 Technical Details

### Technologies Used
- HTML5
- CSS3 (Flexbox, Grid, CSS Variables)
- Vanilla JavaScript (ES6+)
- Google Fonts (Playfair Display + Poppins)
- Font Awesome 6.4.0

### Browser Support
- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers

### Key Features Implementation

**Smooth Scrolling**: Native CSS + JavaScript
**Animations**: Intersection Observer API
**Gallery Filter**: JavaScript DOM manipulation
**Lightbox**: Pure CSS + JavaScript modal
**Responsive**: CSS Grid + Flexbox with media queries
**Mobile Menu**: Hamburger menu with smooth transitions

## 📝 Important Notes

### Before Going Live:

1. ✅ Replace ALL placeholder images
2. ✅ Update Instagram links (3 places)
3. ✅ Test on mobile devices
4. ✅ Check all links work
5. ✅ Optimize images (compress for web)
6. ✅ Update copyright year if needed (auto-updates via JS)

### Image Optimization Tips:

- **Optional but Recommended**: Use tools like TinyPNG or ImageOptim to compress
- **Good Lighting**: Take clear, well-lit photos
- **Format**: JPG works great for photos, PNG for graphics
- **File Size**: Try to keep under 1-2MB per image for faster loading
- **Note**: The website automatically handles any image size/aspect ratio!

## 🎯 Performance Tips

The website is already optimized, but you can improve further:

1. **Compress Images**: Use tools like TinyPNG or ImageOptim
2. **Enable Caching**: GitHub Pages does this automatically
3. **Use WebP Format**: Convert JPG to WebP for better compression
4. **Lazy Loading**: Already implemented via Intersection Observer

## 🐛 Troubleshooting

**Images not showing?**
- Check file paths are correct
- Ensure images are in the right folders
- Check file extensions match (jpg vs jpeg)

**GitHub Pages not updating?**
- Clear browser cache (Ctrl+Shift+R or Cmd+Shift+R)
- Wait 2-3 minutes for GitHub to rebuild
- Check GitHub Actions tab for build errors

**Mobile menu not working?**
- Ensure `script.js` is loading correctly
- Check browser console for errors (F12)

## 📄 File Descriptions

- **index.html**: Main HTML structure with all sections
- **css/style.css**: Complete styling with responsive design
- **js/script.js**: All interactive functionality
- **images/**: Image assets organized by category

## 🔮 Future Enhancements (Optional)

Consider adding:
- Contact form (using Formspree or similar)
- WhatsApp integration
- Price list section
- Before/After slider
- Blog/Tips section
- Multilingual support
- Progressive Web App (PWA) features

## 📞 Support

If you need help:
1. Check this README thoroughly
2. Search for error messages online
3. Check browser console (F12) for errors
4. Verify all file paths are correct

## 📜 License

This is a custom-built website. You own all rights to your content and can modify as needed.

---

## 🎉 Ready to Launch!

Your website is production-ready. Just add your images, update the Instagram links, and deploy to GitHub Pages!

**Live URL Format**: `https://your-username.github.io/repository-name/`

Good luck with your Mehandi art business! 🎨✨

---

**Built with ❤️ for Priti's Mehandi Art**

*Last Updated: February 2026*
