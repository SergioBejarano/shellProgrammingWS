param (
    [string]$directorio,       # Directorio donde buscar archivos
    [string]$permisoBuscado    # Permiso que se desea buscar (ej. "ReadData", "Write", "FullControl")
)

# Verifica si el directorio existe
if (-Not (Test-Path -Path $directorio -PathType Container)) {
    Write-Host "El directorio '$directorio' no existe."
    exit 1
}

# Verifica si el permiso ingresado es válido
$permisosValidos = [Enum]::GetValues([System.Security.AccessControl.FileSystemRights]) | ForEach-Object { $_.ToString() }
if (-Not ($permisosValidos -contains $permisoBuscado)) {
    Write-Host "El permiso '$permisoBuscado' no es válido. Permisos válidos: $permisosValidos"
    exit 1
}

# Obtiene todos los archivos en el directorio especificado
$archivos = Get-ChildItem -Path $directorio -File

# Variable para rastrear si se encontraron archivos con el permiso
$encontrado = $false

# Recorre cada archivo para verificar el permiso específico
foreach ($archivo in $archivos) {
    # Obtiene la ACL (lista de control de acceso) del archivo
    $acl = Get-Acl -Path $archivo.FullName
    $permisoEncontrado = $false
    
    # Verifica el permiso buscado en cada entrada de la ACL
    foreach ($permiso in $acl.Access) {
        if ($permiso.FileSystemRights.ToString() -eq $permisoBuscado) {
            $permisoEncontrado = $true
            break
        }
    }
    
    # Si se encontró el permiso, muestra el archivo y detiene la búsqueda en este archivo
    if ($permisoEncontrado) {
        Write-Host "Archivo: $($archivo.FullName) - Permiso encontrado: $permisoBuscado"
        $encontrado = $true
    }
}

# Si no se encontraron archivos con el permiso buscado
if (-Not $encontrado) {
    Write-Host "No se encontraron archivos con el permiso '$permisoBuscado' en '$directorio'."
}
