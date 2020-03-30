environment=$(jq -r ".environmentType" < "$1")
profiles=$(jq -r ".springProfiles" < "$1")
imageName=$(jq -r ".imageName" < "$1")
networkName=$(jq -r ".networkName" < "$1")
networkAlias=$(jq ".networkAlias" < "$1")
containerName=$(jq -r ".containerName" < "$1")
propertiesFolder=$(jq -r ".propertiesFolder" < "$1")

fullImage="$imageName:$2"

echo "docker pull $fullImage"
echo "docker stop $containerName || true"
echo "docker rm $containerName || true"
echo "docker network inspect $networkName >/dev/null 2>&1 || docker network create --driver bridge $networkName"
echo "docker run -d --network=$networkName -v $propertiesFolder:$propertiesFolder --network-alias $networkAlias --name $containerName -e 'ACTIVE_PROFILES=$profiles' -e 'ENVIRONMENT=$environment' -e 'PROPERTIES_PREFIX=$propertiesFolder' $fullImage"
