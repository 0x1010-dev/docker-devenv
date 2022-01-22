FROM ubuntu:rolling
# FROM nvidia/cuda:11.1.1-base-ubuntu20.04

# environment
ENV SSHD_PORT=2222 \
    DISPLAY=:0

# install packages
COPY scripts/install-packages.sh .
RUN ./install-packages.sh \
    # python build dependencies
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libsqlite3-dev \
    liblzma-dev \
    libbz2-dev \
    tk-dev \
    llvm \
    # fpga development
    ghdl-llvm \
    gtkwave \
    # pillow deps
    libjpeg-dev \
    libtiff-dev \
    libfreetype-dev \
    liblcms2-dev \
    libwebp-dev \
    libimagequant-dev \
    libraqm-dev \
    # x11
    libgl1-mesa-glx \
    libegl1-mesa \
    xvfb \
    # essentials
    ca-certificates \
    openssh-server \
    supervisor \
    ruby-full \
    python3 \
    python3-pip \
    locales \
    netbase \
    pwgen \
    rsync \
    mosh \
    wget \
    sudo \
    curl \
    file \
    rpl \
    zsh \
    vim \
    git

# install docker
COPY scripts/install-docker.sh .
RUN ./install-docker.sh

# install homebrew
COPY scripts/install-homebrew.sh .
RUN ./install-homebrew.sh

# setup services
COPY config/services.conf /etc/supervisor/conf.d/services.conf
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
USER root
EXPOSE ${SSHD_PORT}
COPY scripts/start.sh .
CMD /start.sh
