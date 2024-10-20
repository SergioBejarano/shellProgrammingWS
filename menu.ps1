# Bucle infinito para mostrar el menú
while ($true) {
    Write-Host "-------------------------------"
    Write-Host "           Menú PowerShell"
    Write-Host "-------------------------------"
    Write-Host "1. Ejecutar mensaje.ps1"
    Write-Host "2. Ejecutar num_lineas.ps1"
    Write-Host "3. Ejecutar buscar_palabra.ps1"
    Write-Host "4. Ejecutar usuarios.ps1"
    Write-Host "5. Ejecutar permisos.ps1"
    Write-Host "6. Salir"
    Write-Host "-------------------------------"
    
    # Leer la opción del usuario
    $opcion = Read-Host "Seleccione una opción"

    switch ($opcion) {
        1 {
            # Ejecuta mensaje.ps1
            ./mensaje.ps1
        }
        2 {
            # Ejecuta num_lineas.ps1 utilizando PowerShell
            ./num_lineas.ps1
        }
        3 {
            # Solicita la palabra y el archivo, luego ejecuta buscar_palabra.ps1 con los argumentos
            $palabra = Read-Host "Ingrese la palabra a buscar"
            $archivo = Read-Host "Ingrese el archivo donde buscar"
            ./buscar_palabra.ps1 $palabra $archivo
        }
        4 {
            # Ejecuta usuarios.ps1
            ./usuarios.ps1
        }
        5 {
            # Opción permisos.ps1: solicita ruta y permisos como argumentos
            $directorio = Read-Host "Ingrese el directorio"
            $permisos = Read-Host "Ingrese el permiso"
            ./permisos.ps1 $directorio $permisos
        }
        6 {
            Write-Host "Saliendo del menu..."
            exit
        }
        default {
            # Si elige una opción inválida
            Write-Host "Opción inválida. Intente nuevamente."
        }
    }
    # Pausa antes de mostrar el menú de nuevo
    Read-Host "Presione Enter para continuar..."
}
