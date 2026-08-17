param(
  [string]$Source,
  [string]$OutDir
)

Add-Type -AssemblyName System.Drawing

function RenderPng($src, [int]$size, [string]$path) {
  $bmp = New-Object System.Drawing.Bitmap($size, $size)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  try {
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.DrawImage($src, 0, 0, $size, $size)
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
  } finally { $g.Dispose(); $bmp.Dispose() }
}

function New-MultiSizeIco($src, [int[]]$sizes, [string]$path) {
  $images = @()
  foreach ($s in $sizes) {
    $bmp = New-Object System.Drawing.Bitmap($s, $s)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.DrawImage($src, 0, 0, $s, $s)

    $rect = New-Object System.Drawing.Rectangle(0, 0, $s, $s)
    $data = $bmp.LockBits($rect, [System.Drawing.Imaging.ImageLockMode]::ReadOnly, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $stride = $data.Stride
    $row = New-Object byte[] ($stride * $s)
    [System.Runtime.InteropServices.Marshal]::Copy($data.Scan0, $row, 0, $row.Length)
    $bmp.UnlockBits($data)
    $g.Dispose(); $bmp.Dispose()

    $xor = New-Object byte[] ($s * $s * 4)
    for ($y = 0; $y -lt $s; $y++) {
      $dstY = $s - 1 - $y
      for ($x = 0; $x -lt $s; $x++) {
        $i = $y * $stride + $x * 4
        $d = ($dstY * $s + $x) * 4
        # Format32bppArgb memory layout is already BGRA.
        $xor[$d]     = $row[$i]
        $xor[$d + 1] = $row[$i + 1]
        $xor[$d + 2] = $row[$i + 2]
        $xor[$d + 3] = $row[$i + 3]
      }
    }

    $rowBytes = [math]::Ceiling($s / 8.0)
    $rowBytesPadded = ([int][math]::Ceiling($rowBytes / 4.0)) * 4
    $and = New-Object byte[] ($rowBytesPadded * $s)

    $images += @{ size = $s; xor = $xor; and = $and }
  }

  $fs = [System.IO.File]::Create($path)
  $bw = New-Object System.IO.BinaryWriter($fs)
  try {
    $count = $images.Count
    $bw.Write([int16]0)
    $bw.Write([int16]1)
    $bw.Write([int16]$count)

    $offset = 6 + 16 * $count
    foreach ($im in $images) {
      $dim = if ($im.size -ge 256) { 0 } else { $im.size }
      $bw.Write([byte]$dim)
      $bw.Write([byte]$dim)
      $bw.Write([byte]0)
      $bw.Write([byte]0)
      $bw.Write([int16]1)
      $bw.Write([int16]32)
      $bw.Write([int32](40 + $im.xor.Length + $im.and.Length))
      $bw.Write([int32]$offset)
      $offset += 40 + $im.xor.Length + $im.and.Length
    }
    foreach ($im in $images) {
      $bw.Write([int32]40)
      $bw.Write([int32]$im.size)
      $bw.Write([int32]($im.size * 2))
      $bw.Write([int16]1)
      $bw.Write([int16]32)
      $bw.Write([int32]0)
      $bw.Write([int32]($im.xor.Length + $im.and.Length))
      $bw.Write([int32]0)
      $bw.Write([int32]0)
      $bw.Write([int32]0)
      $bw.Write([int32]0)
      $bw.Write($im.xor)
      $bw.Write($im.and)
    }
  } finally { $bw.Close() }
}

$src = [System.Drawing.Image]::FromFile($Source)
try {
  RenderPng $src 16 (Join-Path $OutDir "favicon-16x16.png")
  RenderPng $src 32 (Join-Path $OutDir "favicon-32x32.png")
  RenderPng $src 180 (Join-Path $OutDir "apple-touch-icon.png")
  RenderPng $src 192 (Join-Path $OutDir "icon-192.png")
  RenderPng $src 512 (Join-Path $OutDir "icon-512.png")
  New-MultiSizeIco $src @(16, 32, 48) (Join-Path $OutDir "favicon.ico")
} finally { $src.Dispose() }

Write-Output "favicon assets generated"