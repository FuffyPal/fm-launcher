FROM python:3.13.3-slim

RUN apt update && apt install -y  git openssh-server --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

WORKDIR /workspace

ARG user
ARG email

RUN git config --global user.name "$user" && \
git config --global user.email "$email"

COPY ./ /workspace/

ARG password
RUN echo "root:$password" | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd && \
chmod 0755 /var/run/sshd

CMD ["/usr/sbin/sshd", "-D"]

