param (
    [string]$directorio,       # Directorio donde buscar archivos
    [string]$permisoBuscado    # Permiso que se desea buscar (ej. "ReadData", "Write", "FullControl")
)

# Verifica si el directorio existe
if (-Not (Test-Path -Path $directorio -PathType Container)) {
    Write-Host "El directorio '$directorio' no existe."
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
    
    # Verifica el permiso buscado mediante un switch
    foreach ($permiso in $acl.Access) {
        switch ($permisoBuscado) {
            "ReadData" {
                if ($permiso.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::ReadData) {
                    $permisoEncontrado = $true
                }
            }
            "WriteData" {
                if ($permiso.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::WriteData) {
                    $permisoEncontrado = $true
                }
            }
            "AppendData" {
                if ($permiso.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::AppendData) {
                    $permisoEncontrado = $true
                }
            }
            "ReadExtendedAttributes" {
                if ($permiso.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::ReadExtendedAttributes) {
                    $permisoEncontrado = $true
                }
            }
            "WriteExtendedAttributes" {
                if ($permiso.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::WriteExtendedAttributes) {
                    $permisoEncontrado = $true
                }
            }
            "ExecuteFile" {
                if ($permiso.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::ExecuteFile) {
                    $permisoEncontrado = $true
                }
            }
            "Delete" {
                if ($permiso.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::Delete) {
                    $permisoEncontrado = $true
                }
            }
            "ReadPermissions" {
                if ($permiso.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::ReadPermissions) {
                    $permisoEncontrado = $true
                }
            }
            "Modify" {
                if ($permiso.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::Modify) {
                    $permisoEncontrado = $true
                }
            }
            "FullControl" {
                if ($permiso.FileSystemRights -band [System.Security.AccessControl.FileSystemRights]::FullControl) {
                    $permisoEncontrado = $true
                }
            }
            default {
                Write-Host "Permiso buscado '$permisoBuscado' no es válido. Usa un permiso válido, como 'ReadData', 'WriteData', 'Modify', 'FullControl', etc."
                exit 1
            }
        }
        
        # Si se encontró el permiso, muestra el archivo y detiene la búsqueda en este archivo
        if ($permisoEncontrado) {
            Write-Host "Archivo: $($archivo.FullName) - Permiso encontrado: $permisoBuscado"
            $encontrado = $true
            break
        }
    }
}

# Si no se encontraron archivos con el permiso buscado
if (-Not $encontrado) {
    Write-Host "No se encontraron archivos con el permiso '$permisoBuscado' en '$directorio'."
}
