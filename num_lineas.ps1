# Limpia la pantalla
Clear-Host

# Obtener el numero de lineas
$result = (Get-Content 'C:\Windows\System32\drivers\etc\hosts').Length

# Imprimir el numero de lineas
Write-Host "El numero de lineas del archivo C:\Windows\System32\drivers\etc\hosts es: $result"