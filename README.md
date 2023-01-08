## windows 10 o superior
- instala Docker Desktop, y asegurate de que esté abierto, si aún no lo tienes instalado
- si aún no tienes una distribución de linux instalada: abrir una consola en administrador y ejecutar ``wsl --install``
- en algunos casos habrá que reiniciar el ordenador
- abrir la aplicacion 'Ubuntu' que se habrá instalado
- si te lo pide, establece una contraseña
- abre Docker Desktop y activa Ubuntu: Docker Desktop > Settings > Resources > WSL Integration
- ejecuta ``sudo apt update && sudo apt install git``
- ejecuta ``git clone https://github.com/quiquelhappy/uab-bbdd-airport.git && cd uab-bbdd-airport && sh ./script.sh``

## linux y macos
- instala Docker Desktop
- instala git
- ejecuta ``git clone https://github.com/quiquelhappy/uab-bbdd-airport.git && cd uab-bbdd-airport && sh ./script.sh``

## credenciales
```
host:         localhost
port:         1521
host+port:    localhost:1521
sid:          XE
user:         system
password:     oracle
schema:       SYS
```
