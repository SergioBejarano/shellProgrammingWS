# Guarda la ubicación actual
$ubicacionOriginal = Get-Location


# Verifica  argumentos 
if ($args.Count -ne 2) {
    Write-Host "Uso: ./tipo.ps1 nombre directorio"
    exit 1
}

# Asigna los argumentos a variables
$nombre = $args[0]
$directorio = $args[1]


# Verifica si el directorio existe
if (-Not (Test-Path -Path $directorio -PathType Container)) {
    Write-Host "El directorio '$directorio' no existe."
    exit 1
}

# Cambia al directorio especificado
Set-Location -Path $directorio

# Verifica si el nombre especificado es un archivo, un subdirectorio, o no existe
if (Test-Path -Path $nombre -PathType Leaf) {
    Write-Host "'$nombre' es un archivo."
} elseif (Test-Path -Path $nombre -PathType Container) {
    Write-Host "'$nombre' es un subdirectorio."
} else {
    Write-Host "'$nombre' no es un archivo ni un subdirectorio en '$directorio'."
}

# Regresa a la ubicación original
Set-Location -Path $ubicacionOriginal