FROM ubuntu:rolling

# install packages
COPY scripts/install-packages.sh .
RUN ./install-packages.sh \
    ca-certificates \
    build-essential \
    openssh-server \
    ruby-full \
    python3 \
    python3-pip \
    locales \
    wget \
    sudo \
    curl \
    file \
    zsh \
    vim \
    git

# install homebrew
COPY scripts/install-homebrew.sh .
RUN ./install-homebrew.sh

# add user
RUN adduser --shell /usr/bin/zsh --disabled-password --gecos "" user
RUN adduser user linuxbrew
RUN adduser user sudo
RUN echo 'user:user' | chpasswd

# add customization
USER user
RUN git clone https://github.com/0x1010-dev/dotfiles.git /home/user/.dotfiles
RUN /home/user/.dotfiles/install

# ssh
USER root
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]