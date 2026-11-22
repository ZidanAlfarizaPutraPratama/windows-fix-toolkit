Add-Type -AssemblyName System.Drawing
if (-not (Test-Path "assets")) { New-Item -ItemType Directory -Path "assets" | Out-Null }
$icoPath = Join-Path $PWD "assets\app.ico"
$sizes = @(16, 32, 48, 64, 256)
$pngStreams = @()

function New-RoundedRectPath([float]$x, [float]$y, [float]$w, [float]$h, [float]$r) {
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $d = [math]::Max(2, $r * 2)
    $path.AddArc($x, $y, $d, $d, 180, 90)
    $path.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
    $path.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
    $path.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
    $path.CloseFigure()
    return $path
}

foreach ($s in $sizes) {
    $bmp = New-Object System.Drawing.Bitmap($s, $s)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.Clear([System.Drawing.Color]::Transparent)

    $pad = [math]::Max(1, [float]($s * 0.06))
    $boxSize = $s - ($pad * 2)
    $radius = [math]::Max(2, [float]($s * 0.20))

    $bgPath = New-RoundedRectPath $pad $pad $boxSize $boxSize $radius
    $bgBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 15, 23, 42))
    $borderPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 56, 189, 248), [math]::Max(1, [float]($s * 0.05)))
    $g.FillPath($bgBrush, $bgPath)
    $g.DrawPath($borderPen, $bgPath)

    $chevronPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 56, 189, 248), [math]::Max(1.5, [float]($s * 0.08)))
    $chevronPen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $chevronPen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    $chevronPen.LineJoin = [System.Drawing.Drawing2D.LineJoin]::Round

    $p1 = New-Object System.Drawing.PointF(($s * 0.25), ($s * 0.36))
    $p2 = New-Object System.Drawing.PointF(($s * 0.43), ($s * 0.48))
    $p3 = New-Object System.Drawing.PointF(($s * 0.25), ($s * 0.60))
    $g.DrawLines($chevronPen, [System.Drawing.PointF[]]@($p1, $p2, $p3))

    $linePen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 248, 250, 252), [math]::Max(1.5, [float]($s * 0.08)))
    $linePen.StartCap = [System.Drawing.Drawing2D.LineCap]::Round
    $linePen.EndCap = [System.Drawing.Drawing2D.LineCap]::Round
    $g.DrawLine($linePen, ($s * 0.48), ($s * 0.60), ($s * 0.68), ($s * 0.60))

    $winBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 96, 165, 250))
    $sq = [math]::Max(1.5, [float]($s * 0.09))
    $gap = [math]::Max(1, [float]($s * 0.025))
    $wx = $s * 0.64
    $wy = $s * 0.66
    $g.FillRectangle($winBrush, $wx, $wy, $sq, $sq)
    $g.FillRectangle($winBrush, ($wx + $sq + $gap), $wy, $sq, $sq)
    $g.FillRectangle($winBrush, $wx, ($wy + $sq + $gap), $sq, $sq)
    $g.FillRectangle($winBrush, ($wx + $sq + $gap), ($wy + $sq + $gap), $sq, $sq)

    $ms = New-Object System.IO.MemoryStream
    $bmp.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
    $pngStreams += ,$ms.ToArray()
    $g.Dispose(); $bmp.Dispose()
}

$fs = [System.IO.File]::Open($icoPath, [System.IO.FileMode]::Create)
$bw = New-Object System.IO.BinaryWriter($fs)
$bw.Write([uint16]0); $bw.Write([uint16]1); $bw.Write([uint16]$sizes.Count)

$offset = 6 + (16 * $sizes.Count)
for ($i = 0; $i -lt $sizes.Count; $i++) {
    $dim = if ($sizes[$i] -ge 256) { [byte]0 } else { [byte]$sizes[$i] }
    $dataLen = $pngStreams[$i].Length
    $bw.Write($dim); $bw.Write($dim); $bw.Write([byte]0); $bw.Write([byte]0)
    $bw.Write([uint16]1); $bw.Write([uint16]32); $bw.Write([uint32]$dataLen); $bw.Write([uint32]$offset)
    $offset += $dataLen
}
foreach ($bytes in $pngStreams) { $bw.Write($bytes) }
$bw.Close(); $fs.Close()
Write-Host "Berhasil! Logo dibuat di: $icoPath" -ForegroundColor Green