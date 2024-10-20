# Filtrar los eventos de seguridad relacionados con intentos fallidos de acceso
$eventLogs = Get-WinEvent -LogName Security | Where-Object {
    $_.Id -eq 4625 # Event ID 4625: An account failed to log on
}

# Variables para contar los intentos fallidos al usuario "root" (Administrador)
$failedAttempts = 0

# Recorre los eventos de intentos fallidos
foreach ($event in $eventLogs) {
    $message = $event.Message

    # Verifica si el mensaje contiene el nombre de usuario "root" o "Administrador"
    if ($message -match "root" -or $message -match "Administrator") {
        # Incrementa el contador de intentos fallidos
        $failedAttempts++

        # Muestra la fecha y hora del intento fallido
        Write-Host "Intento fallido al usuario root/Administrador el: $($event.TimeCreated)"
    }
}

# Mostrar el total de intentos fallidos al usuario root/Administrador
Write-Host "`nCantidad total de intentos fallidos: $failedAttempts"