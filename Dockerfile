FROM ubuntu:14.04

RUN apt-get update

# install 
RUN apt-get install vim wget -y

# set Root login
RUN sed -i "s/PermitRootLogin no//g" /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" /etc/ssh/sshd_config

CMD ["bash"]
