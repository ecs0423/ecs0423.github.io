FROM ubuntu:14.04

RUN apt-get update

# install 
RUN apt-get install vim wget openssh-server -y

# fix Please use a locale setting which supports utf-8.
RUN apt-get install locales
RUN dpkg-reconfigure locales 
RUN locale-gen en_US.UTF-8
RUN Generation complete.
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8

# set Root login
RUN sed -i "s/PermitRootLogin no//g" /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
