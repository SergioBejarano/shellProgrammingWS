param (
    [string]$directorio,       # Primer argumento: directorio para buscar
    [string]$permisoBuscado    # Segundo argumento: tipo de permiso buscado
)

# Verifica si el directorio existe
if (-Not (Test-Path -Path $directorio -PathType Container)) {
    Write-Host "El directorio '$directorio' no existe."
    exit 1
}

# Convierte el permiso buscado a un tipo enumerado de FileSystemRights
try {
    $permisoBuscadoEnum = [System.Security.AccessControl.FileSystemRights]::$permisoBuscado
} catch {
    Write-Host "Permiso buscado '$permisoBuscado' no es válido."
    exit 1
}

# Obtiene todos los archivos en el directorio
$archivos = Get-ChildItem -Path $directorio -File

# Variable para rastrear si se encontraron archivos con el permiso
$encontrado = $false

# Recorre cada archivo para verificar los permisos
foreach ($archivo in $archivos) {
    # Obtiene la ACL (lista de control de acceso) del archivo
    $acl = Get-Acl -Path $archivo.FullName

    # Verifica si algún permiso incluye el permiso buscado
    foreach ($permiso in $acl.Access) {
        if ($permiso.FileSystemRights -band $permisoBuscadoEnum) {
            Write-Host "Archivo: $($archivo.FullName) - Permiso: $permisoBuscado"
            $encontrado = $true
            break
        }
    }
}

# Si no se encontraron archivos con el permiso buscado
if (-Not $encontrado) {
    Write-Host "No se encontraron archivos con el permiso '$permisoBuscado' en '$directorio'."
}
