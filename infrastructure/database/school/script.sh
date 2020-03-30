for i in "$@"
do
case $i in
    properties=*)
    propertiesFile="${i#*=}"
    shift
    ;;
    password=*)
    passwordString="${i#*=}"
    shift
    ;;
    *)
          # unknown option
    ;;
esac
done

networkName=$(jq -r ".networkName" < "$propertiesFile")
networkAlias=$(jq -r ".networkAlias" < "$propertiesFile")
containerName=$(jq -r ".containerName" < "$propertiesFile")
schemaName=$(jq -r ".schemaName" < "$propertiesFile")
VOLUME_BINDING=$(jq -r ".volumeBinding" < "$propertiesFile")

ROOT_PASSWORD="$passwordString"

echo "docker stop $containerName || true"
echo "docker rm $containerName || true"
echo "docker network inspect $networkName >/dev/null 2>&1 || docker network create --driver bridge $networkName"
echo "docker run -d --network=$networkName --name $containerName --network-alias $networkAlias -e 'MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD' -e 'MYSQL_DATABASE=$schemaName' -v '$VOLUME_BINDING:/var/lib/mysql' mysql:latest"
