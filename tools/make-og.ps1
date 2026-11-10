# Draws public/og.png (1200x630), the image shown when the site is shared.
# Usage: pwsh tools/make-og.ps1
Add-Type -AssemblyName System.Drawing

$root = Split-Path $PSScriptRoot
$out = Join-Path $root 'public\og.png'
$icon = [System.Drawing.Image]::FromFile((Join-Path $root 'public\icon-256.png'))

$bmp = [System.Drawing.Bitmap]::new(1200, 630)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = 'AntiAlias'
$g.InterpolationMode = 'HighQualityBicubic'
$g.TextRenderingHint = 'AntiAliasGridFit'

# Background: the navy of the app icon, top to bottom.
$rect = [System.Drawing.Rectangle]::new(0, 0, 1200, 630)
$bg = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    $rect, [System.Drawing.Color]::FromArgb(36, 44, 68), [System.Drawing.Color]::FromArgb(15, 17, 21), 90)
$g.FillRectangle($bg, $rect)

$g.DrawImage($icon, 90, 96, 132, 132)

$white = [System.Drawing.Brushes]::White
$muted = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(170, 178, 196))
$title = [System.Drawing.Font]::new('Segoe UI Semibold', 78, [System.Drawing.FontStyle]::Regular, 'Pixel')
$name = [System.Drawing.Font]::new('Segoe UI Semibold', 56, [System.Drawing.FontStyle]::Regular, 'Pixel')
$body = [System.Drawing.Font]::new('Segoe UI', 34, [System.Drawing.FontStyle]::Regular, 'Pixel')
$mono = [System.Drawing.Font]::new('Consolas', 40, [System.Drawing.FontStyle]::Regular, 'Pixel')

$g.DrawString('Linter', $name, $white, 250, 124)
$g.DrawString('Wrong layout? One key.', $title, $white, 84, 270)
$g.DrawString('Retypes what you typed in the right keyboard layout.', $body, $muted, 90, 372)

# The before / after line, with the spell checker's red underline under "before".
$g.DrawString('ghbdtn', $mono, $muted, 90, 478)
$g.DrawString([string][char]0x2192, $mono, $muted, 262, 478)
$g.DrawString([string]::new([char[]](0x43F, 0x440, 0x438, 0x432, 0x435, 0x442)), $mono, $white, 330, 478)

$pen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 82, 82), 4)
$points = for ($x = 96; $x -le 232; $x += 4) {
    [System.Drawing.PointF]::new($x, 534 + 5 * [Math]::Sin(($x - 96) / 34 * 2 * [Math]::PI))
}
$g.DrawCurve($pen, [System.Drawing.PointF[]]$points)

$g.Dispose()
$bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
$icon.Dispose()
"wrote $out"
