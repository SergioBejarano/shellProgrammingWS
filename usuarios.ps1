# Archivo de salida
$outputFile = "usuarios.txt"

# Obtiene todos los usuarios locales
$usuarios = Get-WmiObject -Class Win32_UserAccount | Where-Object { $_.LocalAccount -eq $true }

# Recorre cada usuario y extrae el nombre y la descripción
foreach ($usuario in $usuarios) {
    $nombre = $usuario.Name
    $descripcion = $usuario.Description

    # Si no hay descripción, se muestra como "Sin descripción"
    if (-not $descripcion) {
        $descripcion = "Sin descripcion"
    }

    # Guarda el nombre y la descripción en el archivo de salida, con formato "nombre : descripción"
    Add-Content -Path $outputFile -Value "$nombre : $descripcion"
}

# Muestra un mensaje de éxito
Write-Host "Los nombres de usuario y descripciones han sido guardados en $outputFile."