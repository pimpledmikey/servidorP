#!/bin/bash

# Función para verificar la conexión a internet
check_internet_connection() {
    ping -c 1 google.com > /dev/null 2>&1
    return $?
}

# Función para verificar la conexión a un servidor
check_server_connection() {
    nc -z 192.168.6.1 36
    return $?
}

# Función para enviar correo electrónico utilizando Resend.com
send_email() {
	curl -X POST 'https://api.resend.com/emails' \
	  -H 'Authorization: Bearer re_UHywR82R_BWyQtBX37mU52zUiahBtTWMX' \
	  -H 'Content-Type: application/json' \
	  -d $'{
	    "from": "onboarding@resend.dev",
	    "to": "amiguel.requena@gmail.com",
	    "subject": "Alerta: Sin conexión",
	    "html": "<p>Se ha perdido la conexión a internet o al servidor.</p>"
	  }'
}

# Verificar la conexión a internet
if ! check_internet_connection; then
    send_email
    echo "Se ha enviado un correo electrónico debido a la falta de conexión a internet."
fi

# Verificar la conexión al servidor
if ! check_server_connection; then
    send_email
    echo "Se ha enviado un correo electrónico debido a la falta de conexión al servidor."
fi
