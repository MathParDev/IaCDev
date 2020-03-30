# Application and infrastructure folders
Scripts located under mentioned directories should `echo` the prepared commands to be executed on the remote host in order to run appropriate application or infrastructure.
Script should only prepare statements to be executed using property files under the same directory.

This way the script will be basically the simulation of IaC where you have only descriptors of required infrastructure which is later transformed to appropriate code

