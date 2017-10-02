#CONTAINER COMMANDS (I HAVE USED Docker Image: "ubuntu:14.04" image from docker hub to play with following commands)

#This following command runs a container in iteractive mode 
- Docker run -it <image name>

#This following command runs a container in iteractive mode and run a command (in this case it is bash)
# NOTE:: When you do this, the /bin/bash command is assigned to PID1 in the container.
- Docker run -it <image name> /bin/bash

# Naming a container
- docker run -it --name=<name of the container> <image name>

# To EXECUTE a command inside a running container do this (In this case, it's bash command). THIS IS RECOMMENDED WAY
- docker exec -it <container id> /bin/bash

# This command lists all the containers that are currently runnning and NOT running
- docker ps -a

# This command lists all the containers that are currently runnning
- docker ps

# This command list last run container
- docker ps -l

# Removes a container
- docker container rm <container id>

# To exit from a running container
- exit

# To exit from a running container but let it run in the background (DETACHED)
- Short cut is ctrl + P + Q

# To stop a running container
- docker stop <container id>

# TO check all the processes in a container, first start it in interactive mode "docker run -it <image name>" and then run the following
 - ps -ef

 # TO check all the logs in a container, use the following command
 - docker logs <container id>

 # TO check all the low level info about a container use INSPECT command
 - docker inspect <container id>

 # TO log or ATTACH into a running container. This attachs the host machines terminal to stdin, stdout & stderr of PID1 of the container (THIS IS VERY VERY IMPORTANT)
 - docker attach <container id>

 # To inspect all the layers in an image, use the following
 - docker history <image name or Id> 