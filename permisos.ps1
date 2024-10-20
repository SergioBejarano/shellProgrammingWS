param (
    [string]$directorio,       # Primer argumento: directorio para buscar
    [string]$permisoBuscado    # Segundo argumento: tipo de permiso buscado
)

# Verifica si el directorio existe
if (-Not (Test-Path -Path $directorio -PathType Container)) {
    Write-Host "El directorio '$directorio' no existe."
    exit 1
}

# Obtiene todos los archivos en el directorio
$archivos = Get-ChildItem -Path $directorio -File

# Recorre cada archivo para verificar los permisos
foreach ($archivo in $archivos) {
    # Obtiene la ACL (lista de control de acceso) del archivo
    $acl = Get-Acl -Path $archivo.FullName

    # Verifica si algún permiso coincide con el permiso buscado
    $tienePermiso = $false
    foreach ($permiso in $acl.Access) {
        if ($permiso.FileSystemRights -contains $permisoBuscado) {
            $tienePermiso = $true
            break
        }
    }

    # Si el archivo tiene el permiso buscado, lo muestra en pantalla
    if ($tienePermiso) {
        Write-Host "Archivo: $($archivo.FullName) - Permiso: $permisoBuscado"
    }
}

# Si no se encontraron archivos con el permiso buscado
if (-Not $tienePermiso) {
    Write-Host "No se encontraron archivos con el permiso '$permisoBuscado' en '$directorio'."
}
