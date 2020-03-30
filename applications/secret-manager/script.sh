for i in "$@"
do
case $i in
    properties=*)
    propertiesFile="${i#*=}"
    shift # past argument=value
    ;;
    tag=*)
    tag="${i#*=}"
    shift # past argument=value
    ;;
    *)
          # unknown option
    ;;
esac
done

environment=$(jq -r ".environmentType" < "$propertiesFile")
profiles=$(jq -r ".springProfiles" < "$propertiesFile")
imageName=$(jq -r ".imageName" < "$propertiesFile")
networkName=$(jq -r ".networkName" < "$propertiesFile")
networkAlias=$(jq ".networkAlias" < "$propertiesFile")
containerName=$(jq -r ".containerName" < "$propertiesFile")
propertiesFolder=$(jq -r ".propertiesFolder" < "$propertiesFile")

fullImage="$imageName:$tag"

echo "docker pull $fullImage"
echo "docker stop $containerName || true"
echo "docker rm $containerName || true"
echo "docker network inspect $networkName >/dev/null 2>&1 || docker network create --driver bridge $networkName"
echo "docker run -d --network=$networkName -v $propertiesFolder:$propertiesFolder --network-alias $networkAlias --name $containerName -e 'ACTIVE_PROFILES=$profiles' -e 'ENVIRONMENT=$environment' -e 'PROPERTIES_PREFIX=$propertiesFolder' $fullImage"
