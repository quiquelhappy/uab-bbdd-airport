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

## una vez la base de datos se haya iniciado (suele tardar 10 minutos)
para ver los datos en el sql developer, conectarse con las siguientes credenciales:

```
host:         localhost
port:         1521
host+port:    localhost:1521
sid:          XE
user:         system
password:     oracle
schema:       SYS
```

y tras conectarse a la base de datos, ejecutar la consulta SQL ``ALTER SESSION SET CURRENT_SCHEMA="SYS"``. Despues de esto, las consultas funcionarán bien
