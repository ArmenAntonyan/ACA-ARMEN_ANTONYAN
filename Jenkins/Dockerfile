FROM ubuntu:20.04
# if we want to install via apt
USER root
RUN apt-get update && apt-get install nginx -y
# drop back to the regular jenkins user - good practice
USER jenkins
