FROM ubuntu:14.04

RUN apt-get update

# install 
RUN apt-get install vim wget -y

# set Root login
RUN sed -i "s/PrimitRootLogin no//g" /etc/ssh/sshd_config
RUN echo "PrimitRootLogin yes" /etc/ssh/sshd_config

CMD ["bash"]
