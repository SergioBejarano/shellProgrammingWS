
function punto5 {
    Clear-Host
    $directorio = Read-Host "Introduce el directorio"
    $permiso = Read-Host "Introduce el permiso"

    if (-Not (Test-Path -Path $directorio -PathType Container)) {
        Write-Host "Directorio inválido"
        exit 1
    }

    Get-ChildItem -Path $directorio -File | Where-Object {
        (Get-Acl $_.FullName).AccessToString -match $permiso
    } | Format-Table FullName
}

punto5 -directorio $args[0] -permiso $args[1]
