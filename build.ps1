# Сборка поставки «Листа»: dist\Leaflet-<версия>-win-x64\ (папка), dist\Leaflet-<версия>-win-x64-portable.zip.
#   powershell -ExecutionPolicy Bypass -File build.ps1                    самодостаточная сборка (.NET внутри, ставить ничего не нужно)
#   powershell -ExecutionPolicy Bypass -File build.ps1 -FrameworkDependent   дополнительно лёгкая сборка (нужен .NET 8 Desktop Runtime)
#   -NoZip — только папка; -NoSmoke — без пробного запуска из чистой папки.
# Версия — <Version> в src\Leaflet\Leaflet.csproj. Сборка ReadyToRun (код заранее скомпилирован — быстрый запуск).
param(
    [switch]$FrameworkDependent,
    [switch]$NoZip,
    [switch]$NoSmoke
)
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem

$root = $PSScriptRoot
$proj = Join-Path $root 'src\Leaflet\Leaflet.csproj'
$version = ([xml](Get-Content $proj -Raw -Encoding UTF8)).Project.PropertyGroup.Version | Where-Object { $_ } | Select-Object -First 1
if (-not $version) { throw 'В Leaflet.csproj нет <Version>' }
$dist = Join-Path $root 'dist'

$readme = @"
Leaflet $version - a lightweight notebook: a folder of Markdown files, [[links]], backlinks, search.
The interface is in English or Russian (Settings -> Language, or the "Switch language" command; Leaflet.exe --lang ru|en for one run).

Run: Leaflet.exe [file.md | folder]. No installation needed.
Portable mode: while portable.txt lies next to Leaflet.exe, settings, drafts and version snapshots are kept
in the data folder next to the program (delete portable.txt to use %APPDATA%\Leaflet).
A desktop shortcut is created on the first launch (once).
"Open with" for .md: Leaflet.exe --register (remove: --unregister), no administrator rights needed.
Command line help: Leaflet.exe --help.

Support the project: https://dalink.to/olegche

---

Leaflet $version — лёгкий заметочник: папка с Markdown-файлами, [[ссылки]], обратные ссылки, поиск.

Запуск: Leaflet.exe [файл.md | папка]. Установка не нужна.
Портативный режим: пока рядом с Leaflet.exe лежит portable.txt, настройки, черновики и снимки версий
хранятся в папке data рядом с программой (удалите portable.txt — будут в %APPDATA%\Leaflet).
Ярлык на рабочем столе создаётся при первом запуске (один раз).
Открыть с помощью для .md: Leaflet.exe --register (убрать: --unregister), без прав администратора.
Справка по ключам: Leaflet.exe --help.

Помощь проекту: https://dalink.to/olegche
"@

$portable = @"
Portable mode marker: settings, drafts and version snapshots are kept in the data folder next to Leaflet.exe.
Delete this file to keep them in %APPDATA%\Leaflet.

Файл-признак портативного режима: настройки, черновики и снимки версий лежат в папке data рядом с Leaflet.exe.
Удалите этот файл, чтобы хранить их в %APPDATA%\Leaflet.
"@

function Publish([string]$name, [bool]$selfContained) {
    $out = Join-Path $dist $name
    if (Test-Path $out) { Remove-Item $out -Recurse -Force }
    Write-Host "== $name" -ForegroundColor Cyan
    $sc = if ($selfContained) { 'true' } else { 'false' }
    dotnet publish $proj -c Release -r win-x64 --self-contained $sc -p:PublishReadyToRun=true `
        -p:DebugType=none -p:DebugSymbols=false -p:SatelliteResourceLanguages=en -o $out --nologo -v:q
    if ($LASTEXITCODE -ne 0) { throw "publish $name не удался" }
    # Отладочные файлы нативных библиотек (SkiaSharp, HarfBuzz) весят 100 МБ и пользователю не нужны.
    Get-ChildItem $out -Recurse -Filter *.pdb | Remove-Item -Force
    # Тестовые данные и замеры в поставку не входят; признак портативного режима и памятка — да.
    [IO.File]::WriteAllText((Join-Path $out 'portable.txt'), $portable, (New-Object Text.UTF8Encoding $true))
    [IO.File]::WriteAllText((Join-Path $out 'README.txt'), $readme, (New-Object Text.UTF8Encoding $true))
    Copy-Item (Join-Path $PSScriptRoot 'Help.md') $out -Force
    $size = (Get-ChildItem $out -Recurse -File | Measure-Object Length -Sum).Sum
    Write-Host ("   папка: {0:N1} МБ" -f ($size / 1MB))
    if (-not $NoZip) {
        $zip = Join-Path $dist "$name-portable.zip"
        if (Test-Path $zip) { Remove-Item $zip -Force }
        [IO.Compression.ZipFile]::CreateFromDirectory($out, $zip, [IO.Compression.CompressionLevel]::Optimal, $true)
        Write-Host ("   zip:   {0:N1} МБ  {1}" -f ((Get-Item $zip).Length / 1MB), $zip)
    }
    $out
}

# Пробный запуск из чистой папки: распаковать zip (или скопировать папку) в новое место, открыть заметку с отдельной папкой данных.
function Smoke([string]$name) {
    $tmp = Join-Path ([IO.Path]::GetTempPath()) ("leaflet-smoke-" + [guid]::NewGuid().ToString('N').Substring(0, 8))
    New-Item -ItemType Directory $tmp | Out-Null
    try {
        $app = Join-Path $tmp 'app'
        $zip = Join-Path $dist "$name-portable.zip"
        if (Test-Path $zip) { [IO.Compression.ZipFile]::ExtractToDirectory($zip, $app) }
        else { Copy-Item (Join-Path $dist $name) (Join-Path $app $name) -Recurse }
        # В zip всё лежит в папке с именем сборки.
        $exe = Join-Path $app "$name\Leaflet.exe"
        $vault = Join-Path $tmp 'заметки'
        New-Item -ItemType Directory $vault | Out-Null
        $note = Join-Path $vault 'Проверка.md'
        [IO.File]::WriteAllText($note, "# Проверка`n`nСвязь: [[Другая]]`n", (New-Object Text.UTF8Encoding $false))
        $sw = [Diagnostics.Stopwatch]::StartNew()
        $p = Start-Process $exe -ArgumentList "`"$note`"", '--data', "`"$(Join-Path $tmp 'data')`"" -PassThru
        $ok = $false
        while ($sw.Elapsed.TotalSeconds -lt 20 -and -not $p.HasExited) {
            $p.Refresh()
            if ($p.MainWindowTitle -like 'Проверка*') { $ok = $true; break }
            Start-Sleep -Milliseconds 50
        }
        $ms = $sw.ElapsedMilliseconds
        if ($ok) { Write-Host ("   пробный запуск из чистой папки: окно «{0}» через {1} мс" -f $p.MainWindowTitle, $ms) -ForegroundColor Green }
        else { Write-Host '   пробный запуск НЕ удался: окно не появилось' -ForegroundColor Red; $script:failed = $true }
        if (-not $p.HasExited) { $p.CloseMainWindow() | Out-Null; if (-not $p.WaitForExit(5000)) { $p.Kill() } }
    }
    finally { Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue }
}

New-Item -ItemType Directory -Force $dist | Out-Null
$script:failed = $false
$sc = "Leaflet-$version-win-x64"
Publish $sc $true | Out-Null
if (-not $NoSmoke) { Smoke $sc }
if ($FrameworkDependent) {
    $fd = "Leaflet-$version-win-x64-fd"
    Publish $fd $false | Out-Null
    if (-not $NoSmoke) { Smoke $fd }
}
if ($script:failed) { exit 1 }
Write-Host "Готово: $dist" -ForegroundColor Green
