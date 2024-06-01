# Use the base Windows Server Core image

FROM mcr.microsoft.com/windows/servercore:ltsc2019

 

# Set up working directory

WORKDIR /app

 

# Download and install Ngrok

RUN powershell -Command Invoke-WebRequest https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip -OutFile ngrok.zip

RUN powershell -Command Expand-Archive ngrok.zip

 

# Authenticate Ngrok

ARG NGROK_AUTH_TOKEN

RUN powershell -Command .\ngrok\ngrok.exe authtoken "2hG3JO6ZSoh5oXGl6UQtT4reVIG_56itJ1VjUoaWkBA4C8wAa"

 

# Enable Remote Desktop

RUN powershell -Command Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0

RUN powershell -Command Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

RUN powershell -Command Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1

 

# Create a local user

RUN powershell -Command New-LocalUser -Name "runneradmin" -Password (ConvertTo-SecureString -AsPlainText "P@ssw0rd!" -Force)

 

# Expose RDP port

EXPOSE 3389

 

# Start Ngrok tunnel for RDP

CMD ["powershell", "-Command", ".\ngrok\ngrok.exe", "tcp", "3389"]
