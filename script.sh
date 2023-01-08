current = "$pwd"
echo "si no se puede crear la base de datos, asegurate de que no exista ya. si tienes problemas con ella, eliminala y vuelve a ejecutar el script"
docker run --name uab-oracle-aerolineas -d -p 1521:1521 -v "$(pwd)/sql":/docker-entrypoint-initdb.d quay.io/maksymbilenko/oracle-12c
echo "------------------------------------"
echo "host:         localhost"
echo "port:         1521"
echo "host+port:    localhost:1521"
echo "sid:          XE"
echo "user:         system"
echo "password:     oracle"
echo "schema:       SYS"
echo "------------------------------------"
docker logs -f uab-oracle-aerolineas