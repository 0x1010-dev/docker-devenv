FROM ubuntu:rolling

# install packages
COPY scripts/install-packages.sh .
RUN ./install-packages.sh \
    ca-certificates \
    build-essential \
    openssh-server \
    supervisor \
    ruby-full \
    python3 \
    python3-pip \
    locales \
    pwgen \
    rsync \
    wget \
    sudo \
    curl \
    file \
    rpl \
    zsh \
    vim \
    git

# install homebrew
COPY scripts/install-homebrew.sh .
RUN ./install-homebrew.sh

# setup ssh
COPY config/sshd.conf /etc/supervisor/conf.d/sshd.conf
RUN service ssh start

# add user
RUN adduser --shell /usr/bin/zsh --disabled-password --gecos "" user
RUN adduser user linuxbrew
RUN adduser user sudo
RUN echo "%sudo ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/nopasswd

# add customization
USER user
RUN git clone https://github.com/0x1010-dev/dotfiles.git /home/user/.dotfiles
RUN /home/user/.dotfiles/install

# execute
EXPOSE 22
USER root
COPY scripts/start.sh .
CMD /start.sh