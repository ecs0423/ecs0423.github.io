FROM ubuntu:14.04

RUN apt-get update

# install 
RUN apt-get install vim wget openssh-server -y

# fix Please use a locale setting which supports utf-8.
RUN apt-get install locales
RUN dpkg-reconfigure locales 
RUN locale-gen en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8

RUN mkdir /var/run/sshd
RUN echo 'root:1qaz' | chpasswd

# set Root login
RUN sed -i "s/PermitRootLogin no//g" /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
