networkName=$(jq -r ".networkName" < "$1")
networkAlias=$(jq -r ".networkAlias" < "$1")
containerName=$(jq -r ".containerName" < "$1")
schemaName=$(jq -r ".schemaName" < "$1")
VOLUME_BINDING=$(jq -r ".volumeBinding" < "$1")

ROOT_PASSWORD="$2"

echo "docker stop $containerName || true"
echo "docker rm $containerName || true"
echo "docker network inspect $networkName >/dev/null 2>&1 || docker network create --driver bridge $networkName"
echo "docker run -d --network=$networkName --name $containerName --network-alias $networkAlias -e 'MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD' -e 'MYSQL_DATABASE=$schemaName' -v '$VOLUME_BINDING:/var/lib/mysql' mysql:latest"
