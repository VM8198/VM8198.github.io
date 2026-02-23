# ================================================================
# Image Gallery Generator Script
# ================================================================
# This script scans your gallery folder and creates a JSON file
# that the website uses to display all images automatically.
#
# HOW TO USE:
# 1. Add images to images/gallery/ folder
# 2. Run this script: Double-click UPDATE-GALLERY.bat
#    OR in terminal: .\generate-images.ps1
# 3. Refresh your website - images appear automatically!
# ================================================================

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Priti's Mehandi Art" -ForegroundColor Magenta
Write-Host "  Image Gallery Generator" -ForegroundColor Magenta
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Get the script directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

# Initialize the images object
$imageData = @{
    gallery = @()
    services = @{
        bridal = ""
        arabic = ""
        party = ""
        festival = ""
        kids = ""
    }
    hero = ""
}

# Supported image formats
$imageExtensions = @('*.jpg', '*.jpeg', '*.png', '*.gif', '*.webp', '*.JPG', '*.JPEG', '*.PNG', '*.GIF', '*.WEBP')

Write-Host "Scanning gallery folder..." -ForegroundColor Yellow
Write-Host ""

# Scan gallery folder
$galleryPath = Join-Path $scriptPath "images\gallery"

if (Test-Path $galleryPath) {
    $images = @()
    foreach ($ext in $imageExtensions) {
        $images += Get-ChildItem -Path $galleryPath -Filter $ext -File | Where-Object { $_.Name -notlike "*.txt" }
    }
    
    foreach ($image in $images) {
        $relativePath = "images/gallery/$($image.Name)" -replace '\\', '/'
        $imageObj = @{
            src = $relativePath
            alt = "Mehandi Design - $($image.BaseName)"
        }
        $imageData.gallery += $imageObj
    }
    
    Write-Host "  ✓ Gallery" -ForegroundColor Green -NoNewline
    Write-Host " - Found $($images.Count) image(s)" -ForegroundColor White
} else {
    Write-Host "  ✗ Gallery folder not found - creating it..." -ForegroundColor Yellow
    New-Item -Path $galleryPath -ItemType Directory -Force | Out-Null
    Write-Host "  ✓ Created: images/gallery/" -ForegroundColor Green
    Write-Host "  ➝ Add your mehandi photos here!" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Scanning special images..." -ForegroundColor Yellow

# Check for hero background
$heroImages = Get-ChildItem -Path (Join-Path $scriptPath "images") -Filter "hero-bg.*" -File
if ($heroImages.Count -gt 0) {
    $imageData.hero = "images/$($heroImages[0].Name)" -replace '\\', '/'
    Write-Host "  ✓ Hero background found: $($heroImages[0].Name)" -ForegroundColor Green
} else {
    Write-Host "  ! No hero-bg.* found (optional - gradient displays if missing)" -ForegroundColor DarkGray
}

# Check for service images in images/others/
$othersPath = Join-Path $scriptPath "images\others"
if (Test-Path $othersPath) {
    $serviceImages = @{
        "service-bridal.*" = "bridal"
        "service-arabic.*" = "arabic"
        "service-party.*" = "party"
        "service-festival.*" = "festival"
        "service-kids.*" = "kids"
    }
    
    foreach ($pattern in $serviceImages.Keys) {
        $serviceCat = $serviceImages[$pattern]
        $serviceImg = Get-ChildItem -Path $othersPath -Filter $pattern -File | Select-Object -First 1
        
        if ($serviceImg) {
            $imageData.services[$serviceCat] = "images/others/$($serviceImg.Name)" -replace '\\', '/'
            Write-Host "  ✓ Service image ($serviceCat): $($serviceImg.Name)" -ForegroundColor Green
        }
    }
}

Write-Host ""
Write-Host "Generating images.json..." -ForegroundColor Yellow

# Convert to JSON and save
$jsonOutput = $imageData | ConvertTo-Json -Depth 10
$jsonPath = Join-Path $scriptPath "images.json"
$jsonOutput | Out-File -FilePath $jsonPath -Encoding UTF8

Write-Host "  ✓ Saved to: images.json" -ForegroundColor Green
Write-Host ""

# Display summary
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  SUMMARY" -ForegroundColor Magenta
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Gallery:    $($imageData.gallery.Count) images" -ForegroundColor White
Write-Host "  Services:   5 card images" -ForegroundColor White
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "✨ Done! Your website will now load these images automatically!" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Next steps:" -ForegroundColor Yellow
Write-Host "   1. Open index.html in your browser to see the gallery" -ForegroundColor White
Write-Host "   2. Add/remove images anytime and re-run UPDATE-GALLERY.bat" -ForegroundColor White
Write-Host "   3. Upload everything to GitHub Pages" -ForegroundColor White
Write-Host ""

# Keep window open
Write-Host "Press any key to close..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
