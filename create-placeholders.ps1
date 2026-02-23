# ================================================================
# Create Placeholder Images Script
# ================================================================
# This creates placeholder images with the correct names
# so you can just replace them with your actual photos!
# ================================================================

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Creating Placeholder Images" -ForegroundColor Magenta
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Get script directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $scriptPath) {
    $scriptPath = Get-Location
}

# Function to create a simple placeholder image (1x1 pixel)
function Create-PlaceholderImage {
    param(
        [string]$FilePath,
        [string]$Description
    )
    
    # Create a minimal valid JPEG file (1x1 pixel gray image)
    # This is a base64 encoded 1x1 pixel JPEG
    $base64Image = '/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAABAAEDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlbaWmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD3+iiigD//2Q=='
    
    $bytes = [Convert]::FromBase64String($base64Image)
    [System.IO.File]::WriteAllBytes($FilePath, $bytes)
    
    Write-Host "  ✓ Created: " -ForegroundColor Green -NoNewline
    Write-Host "$Description" -ForegroundColor White -NoNewline
    Write-Host " → " -ForegroundColor DarkGray -NoNewline
    Write-Host (Split-Path $FilePath -Leaf) -ForegroundColor Yellow
}

# Create images directory if it doesn't exist
$imagesPath = Join-Path $scriptPath "images"
$othersPath = Join-Path $scriptPath "images\others"

if (-not (Test-Path $imagesPath)) {
    New-Item -Path $imagesPath -ItemType Directory -Force | Out-Null
}
if (-not (Test-Path $othersPath)) {
    New-Item -Path $othersPath -ItemType Directory -Force | Out-Null
}

Write-Host "Creating main images..." -ForegroundColor Yellow
Write-Host ""

# Create hero background
$heroPath = Join-Path $imagesPath "hero-bg.jpg"
Create-PlaceholderImage -FilePath $heroPath -Description "Hero Background (Main page)"

# Create about image
$aboutPath = Join-Path $imagesPath "about.jpg"
Create-PlaceholderImage -FilePath $aboutPath -Description "About Image (Your photo)"

Write-Host ""
Write-Host "Creating service card images..." -ForegroundColor Yellow
Write-Host ""

# Create service images
$serviceImages = @{
    "service-bridal.jpg" = "Bridal Service Card"
    "service-arabic.jpg" = "Arabic Service Card"
    "service-party.jpg" = "Party Service Card"
    "service-festival.jpg" = "Festival Service Card"
    "service-kids.jpg" = "Kids Service Card"
}

foreach ($fileName in $serviceImages.Keys) {
    $filePath = Join-Path $othersPath $fileName
    Create-PlaceholderImage -FilePath $filePath -Description $serviceImages[$fileName]
}

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  ✨ Done!" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Placeholder images created with correct names!" -ForegroundColor White
Write-Host ""
Write-Host "📝 Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Replace these placeholder files with your actual photos:" -ForegroundColor White
Write-Host ""
Write-Host "     In images/ folder:" -ForegroundColor Cyan
Write-Host "     • hero-bg.jpg" -ForegroundColor White -NoNewline
Write-Host "      → Your main background image" -ForegroundColor DarkGray
Write-Host "     • about.jpg" -ForegroundColor White -NoNewline
Write-Host "        → Your personal photo" -ForegroundColor DarkGray
Write-Host ""
Write-Host "     In images/others/ folder:" -ForegroundColor Cyan
Write-Host "     • service-bridal.jpg   → Bridal service photo" -ForegroundColor White
Write-Host "     • service-arabic.jpg   → Arabic service photo" -ForegroundColor White
Write-Host "     • service-party.jpg    → Party service photo" -ForegroundColor White
Write-Host "     • service-festival.jpg → Festival service photo" -ForegroundColor White
Write-Host "     • service-kids.jpg     → Kids service photo" -ForegroundColor White
Write-Host ""
Write-Host "  2. Just replace the files (keep the same names!)" -ForegroundColor White
Write-Host "  3. Run UPDATE-GALLERY.bat" -ForegroundColor White
Write-Host "  4. Open index.html - your images appear!" -ForegroundColor White
Write-Host ""
Write-Host "💡 Tip: You can drag & drop your photos over these files!" -ForegroundColor Yellow
Write-Host ""

# Keep window open
Write-Host "Press any key to close..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
