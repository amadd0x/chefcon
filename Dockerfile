FROM ubuntu:jammy

# Installing required packages
RUN apt-get update -y 
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    gnupg \
    build-essential \
    nano \
    vim \
    git \
    curl \
    cmake \
    wget \
    sudo \
    iputils-ping \
    ssh \
    netcat \
    zip \
    unzip \
    jq \
    tree \
    bash-completion \
    apt-transport-https \
    ca-certificates \
    zsh \
    less \
    && rm -rf /var/lib/apt/lists/*

# Package Versions

# Installing Chef
RUN curl "https://packages.chef.io/files/stable/chef-workstation/21.10.640/ubuntu/20.04/chef-workstation_21.10.640-1_amd64.deb" -o "chef-workstation.deb" && \
    dpkg -i chef-workstation.deb 

# Set Chef configs
COPY knife.rb /root/.chef/knife.rb
COPY credentials /root/.chef/credentials

# Setting WORKDIR and USER 
USER root
WORKDIR /root/workspace
VOLUME ["/home/chef"]


# ZSH ENVs
ENV TERM xterm
ENV ZSH_THEME agnoster
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
RUN git config --global --add safe.directory '*'
ENTRYPOINT ["zsh"]