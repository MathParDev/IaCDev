# Application and infrastructure folders
Scripts located under mentioned directories should `echo` the prepared commands to be executed on the remote host in order to run appropriate application or infrastructure.
Script should only prepare statements to be executed using property files under the same directory.

This way the script will be basically the simulation of IaC where you have only descriptors of required infrastructure which is later transformed to appropriate code

### Application deployment approach
Each application has its own docker container. Each application exposes a port to host if needed (public endpoints are present).
Applications without public endpoints shouldn't map ports to host and expose them to docker network instead.
Docker network is basically considered as the secured private network.
Before running a new container additional checks are need to be done:
- force pull an image in case copy already cached locally (i.e. docker will not try to pull an image). _Note_, when using latest versions of an image it will not check for newest version automatically.
- if container already running (so it's redeployment, not a first deploy), old container need to be gracefully stopped.
- if container with such a name already exists it needs to be dropped.
- if shared network doesn't exist it needs to be created.

Note that it's important to pull **BEFORE** stopping container as it will minimize the downtime.

### Infrastructure deployment approach
- Databases

Each database has its own container. Additional parameters (like passwords) usually are required to create a valid run string.
Those parameters should be passed from a Jenkins job where they are stored securely. Same rules for running container applied as with application.
