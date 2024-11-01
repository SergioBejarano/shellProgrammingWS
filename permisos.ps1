
function punto5 {
    Clear-Host
    param (
    [string]$directorio,       # Directorio donde buscar archivos
    [string]$permiso    # Permiso que se desea buscar (ej. "ReadData", "Write", "FullControl")
    )
    if (-Not (Test-Path -Path $directorio -PathType Container)) {
        Write-Host "Directorio inválido"
        exit 1
    }

    Get-ChildItem -Path $directorio -File | Where-Object {
        (Get-Acl $_.FullName).AccessToString -match $permiso
    } | Format-Table FullName
    }
punto5 -directorio $args[0] -permiso $args[1]
