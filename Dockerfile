FROM ubuntu:14.04

RUN apt-get update

# install 
RUN apt-get install vim wget curl openssh-server -y

# cross compiler tool:
RUN apt-get install patchutils zip unzip -y
RUN apt-get install gawk git-core diffstat texinfo gcc-multilib \
     build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping libsdl1.2-dev xterm -y

#Fix Error: No valid terminal found, unable to open devshell
RUN apt-get install screen -y

# for node js 6.1 fix:
#RUN apt-get install g++-multilib libssl-dev libcrypto++-dev zlib1g-dev -y

# fix Please use a locale setting which supports utf-8.
RUN apt-get install locales
RUN dpkg-reconfigure locales 
RUN locale-gen en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8

RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd

## create user
RUN ln -sf /bin/bash /bin/sh
RUN adduser --disabled-password --gecos "" docker && \
  echo docker:docker | chpasswd

## setup sudoers
RUN echo "docker    ALL=(ALL)       ALL" >> /etc/sudoers.d/docker

# set Root login
RUN sed -i 's/PermitRootLogin prohibit-password//' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin without-password//' /etc/ssh/sshd_config
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Set user.email so crosbymichael's in-container merge commits go smoothly
RUN git config --global user.email 'docker@example.com'
RUN git config --global user.name "docker"

# Add an unprivileged user to be used for tests which need it
# RUN groupadd -r docker

RUN /etc/init.d/ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
