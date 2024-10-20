# Limpia la pantalla
Clear-Host

# Verifica que se hayan pasado exactamente 2 argumentos (la palabra y el archivo)
if ($args.Count -ne 2) {
    Write-Host "Uso: .\script.ps1 palabra archivo"
    exit 1
}

# Asigna los argumentos a variables
$palabra = $args[0]
$archivo = $args[1]

# Verifica si el archivo existe
if (-Not (Test-Path $archivo)) {
    Write-Host "El archivo $archivo no existe."
    exit 1
}

# Realiza la búsqueda de la palabra en el archivo
Write-Host "Buscando la palabra '$palabra' en el archivo '$archivo'..."
$resultado = Select-String -Path $archivo -Pattern $palabra
if ($resultado) {
    Write-Host "Búsqueda completada.La palabra se encontro en las siguientes lineas:"
    foreach ($linea in $resultado) {
        Write-Host "Linea $($linea.LineNumber): $($linea.Line)"
    }
} else {
    Write-Host "No se encontró la palabra '$palabra' en el archivo '$archivo'."
}
