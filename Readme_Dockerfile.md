# Every RUN command in the Dockerfile creates a new layer in the image that is being built. So, use RUN command judiciously

# To minimize number of commands from being execute, use them in ONE RUN command using "&& \"

# When building the image using "docker build" command and tagging it with "-t" options, only use LOWER CASE characters in the name

# If the FROM instruction has "scratch", this means the image is being from scratch.

#### CMD INSTRUCTION ####
# CMD is a Run time instruction as opposed to RUN command which is a build time instruction.
# There can be only ONE CMD instruction per docker file
# #CMD Command instruction can be overriden by command args in the "docker run" command that spins up a container
#CMD ["cowsay", "To improve is to change; to be perfect is to change often"]

#ENTRYPOINT Command instruction cannot be overriden by command args in the docker run command that spins up a container 
# ENTRYPOINT instruction is the default command that executes by running a container.
# Any that gets passed to the container as part of "docker run" command becomes an argument to ENTRYPOINT instruction 
  # Example: docker run <image name> /bin/bash (This becomes an argument to ENTRYPOINT instruction in the Dockerfile)


#ENTRYPOINT [ "cowsay" ]

#CMD and ENTRYPOINT instructions can work in tandem. CMD below defines default args for ENTRYPOINT instruction but can be overriden.
#CMD ["-f", "tux", "To improve is to change; to be perfect is to change often"]
#ENTRYPOINT [ "cowsay" ]