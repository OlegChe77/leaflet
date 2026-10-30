# Рисует иконку «Листа» (тёмный скруглённый квадрат, лист акцентного цвета Графита):
# src/Leaflet/Assets/leaflet.ico (16–256, кадры PNG) и leaflet.png (256, для значка окна).
# Запуск: powershell -File tools/make-icon.ps1 — нужен только если менялся рисунок.
Add-Type -AssemblyName System.Drawing
$root = Split-Path $PSScriptRoot -Parent
$out = Join-Path $root 'src\Leaflet\Assets'
New-Item -ItemType Directory -Force $out | Out-Null

function Draw([int]$size) {
    $s = 4                                   # рисуем в 4× и сжимаем — гладкие края
    $n = $size * $s
    $bmp = New-Object System.Drawing.Bitmap $n, $n, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = 'AntiAlias'
    $g.Clear([System.Drawing.Color]::Transparent)
    $r = $n * 0.22
    $rect = New-Object System.Drawing.RectangleF 0, 0, $n, $n
    $p = New-Object System.Drawing.Drawing2D.GraphicsPath
    $d = $r * 2
    $p.AddArc(0, 0, $d, $d, 180, 90); $p.AddArc($n - $d, 0, $d, $d, 270, 90)
    $p.AddArc($n - $d, $n - $d, $d, $d, 0, 90); $p.AddArc(0, $n - $d, $d, $d, 90, 90); $p.CloseFigure()
    $bg = New-Object System.Drawing.Drawing2D.LinearGradientBrush $rect, ([System.Drawing.Color]::FromArgb(0x26, 0x27, 0x2e)), ([System.Drawing.Color]::FromArgb(0x17, 0x18, 0x1b)), 90
    $g.FillPath($bg, $p)
    # лист: от нижнего левого угла к верхнему правому, две дуги
    function P($x, $y) { New-Object System.Drawing.PointF ([float]($x * $n)), ([float]($y * $n)) }
    $leaf = New-Object System.Drawing.Drawing2D.GraphicsPath
    $a = P 0.25 0.76; $b = P 0.76 0.24
    $leaf.AddBezier($a, (P 0.20 0.38), (P 0.50 0.18), $b)
    $leaf.AddBezier($b, (P 0.82 0.52), (P 0.52 0.82), $a)
    $leaf.CloseFigure()
    $acc = [System.Drawing.Color]::FromArgb(0xa7, 0x9b, 0xff)
    $g.FillPath((New-Object System.Drawing.SolidBrush $acc), $leaf)
    # прожилка и черенок цветом фона
    $dark = [System.Drawing.Color]::FromArgb(0x1b, 0x1c, 0x20)
    $pen = New-Object System.Drawing.Pen $dark, ([float]($n * 0.034))
    $pen.StartCap = 'Round'; $pen.EndCap = 'Round'
    $g.DrawLine($pen, (P 0.30 0.70), (P 0.66 0.34))
    $stem = New-Object System.Drawing.Pen $acc, ([float]($n * 0.05))
    $stem.StartCap = 'Round'; $stem.EndCap = 'Round'
    $g.DrawLine($stem, (P 0.25 0.76), (P 0.17 0.84))
    $g.Dispose()
    $res = New-Object System.Drawing.Bitmap $size, $size, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g2 = [System.Drawing.Graphics]::FromImage($res)
    $g2.InterpolationMode = 'HighQualityBicubic'; $g2.PixelOffsetMode = 'HighQuality'
    $g2.DrawImage($bmp, 0, 0, $size, $size); $g2.Dispose(); $bmp.Dispose()
    $ms = New-Object System.IO.MemoryStream
    $res.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png); $res.Dispose()
    , $ms.ToArray()
}

$sizes = 16, 24, 32, 48, 64, 128, 256
$frames = foreach ($z in $sizes) { , (Draw $z) }
$fs = [System.IO.File]::Create((Join-Path $out 'leaflet.ico'))
$w = New-Object System.IO.BinaryWriter $fs
$w.Write([uint16]0); $w.Write([uint16]1); $w.Write([uint16]$sizes.Count)
$off = 6 + 16 * $sizes.Count
for ($i = 0; $i -lt $sizes.Count; $i++) {
    $z = $sizes[$i]; $len = $frames[$i].Length
    $w.Write([byte]($z % 256)); $w.Write([byte]($z % 256)); $w.Write([byte]0); $w.Write([byte]0)
    $w.Write([uint16]1); $w.Write([uint16]32); $w.Write([uint32]$len); $w.Write([uint32]$off)
    $off += $len
}
foreach ($f in $frames) { $w.Write($f) }
$w.Close()
[System.IO.File]::WriteAllBytes((Join-Path $out 'leaflet.png'), $frames[$sizes.Count - 1])
"OK: $out"
