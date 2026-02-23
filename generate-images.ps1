# ================================================================
# Image Gallery Generator Script
# ================================================================
# This script scans your image folders and creates a JSON file
# that the website uses to display all images automatically.
#
# HOW TO USE:
# 1. Add images to the appropriate folders (bridal, arabic, etc.)
# 2. Run this script: Right-click > Run with PowerShell
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

# Define image folders and their categories
$imageFolders = @{
    "images/bridal" = "bridal"
    "images/arabic" = "arabic"
    "images/minimal" = "minimal"
    "images/backhand" = "backhand"
}

# Initialize the images object
$imageData = @{
    bridal = @()
    arabic = @()
    minimal = @()
    backhand = @()
    services = @{
        bridal = ""
        arabic = ""
        party = ""
        festival = ""
        kids = ""
    }
    about = ""
    hero = ""
}

# Supported image formats
$imageExtensions = @('*.jpg', '*.jpeg', '*.png', '*.gif', '*.webp', '*.JPG', '*.JPEG', '*.PNG', '*.GIF', '*.WEBP')

Write-Host "Scanning image folders..." -ForegroundColor Yellow
Write-Host ""

# Scan each category folder
foreach ($folder in $imageFolders.Keys) {
    $category = $imageFolders[$folder]
    $folderPath = Join-Path $scriptPath $folder.Replace('/', '\')
    
    if (Test-Path $folderPath) {
        $images = Get-ChildItem -Path $folderPath -Include $imageExtensions -File | Where-Object { $_.Name -notlike "*.txt" }
        
        foreach ($image in $images) {
            $relativePath = "$folder/$($image.Name)" -replace '\\', '/'
            $imageObj = @{
                src = $relativePath
                alt = "$category Mehandi Design - $($image.BaseName)"
                category = $category
            }
            $imageData[$category] += $imageObj
        }
        
        Write-Host "  ✓ $category" -ForegroundColor Green -NoNewline
        Write-Host " - Found $($images.Count) image(s)" -ForegroundColor White
    } else {
        Write-Host "  ✗ $category folder not found" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Scanning special images..." -ForegroundColor Yellow

# Check for hero background
$heroImages = Get-ChildItem -Path (Join-Path $scriptPath "images") -Filter "hero-bg.*" -File
if ($heroImages.Count -gt 0) {
    $imageData.hero = "images/$($heroImages[0].Name)" -replace '\\', '/'
    Write-Host "  ✓ Hero background found: $($heroImages[0].Name)" -ForegroundColor Green
} else {
    Write-Host "  ! No hero-bg.* found (add to images/ folder)" -ForegroundColor DarkYellow
}

# Check for about image
$aboutImages = Get-ChildItem -Path (Join-Path $scriptPath "images") -Filter "about.*" -File
if ($aboutImages.Count -gt 0) {
    $imageData.about = "images/$($aboutImages[0].Name)" -replace '\\', '/'
    Write-Host "  ✓ About image found: $($aboutImages[0].Name)" -ForegroundColor Green
} else {
    Write-Host "  ! No about.* found (add to images/ folder)" -ForegroundColor DarkYellow
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
Write-Host "  Bridal:     $($imageData.bridal.Count) images" -ForegroundColor White
Write-Host "  Arabic:     $($imageData.arabic.Count) images" -ForegroundColor White
Write-Host "  Minimal:    $($imageData.minimal.Count) images" -ForegroundColor White
Write-Host "  Back Hand:  $($imageData.backhand.Count) images" -ForegroundColor White
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "✨ Done! Your website will now load these images automatically!" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Next steps:" -ForegroundColor Yellow
Write-Host "   1. Open index.html in your browser to see the gallery" -ForegroundColor White
Write-Host "   2. Add/remove images anytime and re-run this script" -ForegroundColor White
Write-Host "   3. Upload everything to GitHub Pages" -ForegroundColor White
Write-Host ""

# Keep window open
Write-Host "Press any key to close..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
