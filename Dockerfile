FROM grazfather/pwndock:latest

# GEF
RUN cd ~/tools \
    && git clone --depth 1 https://github.com/hugsy/gef.git \
    && echo "source ~/tools/gef/gef.py" > ~/.gdbinit

# Install dotfiles
RUN cd ~/tools \
    && git clone --depth 1 https://github.com/Grazfather/dotfiles.git \
    && bash ~/tools/dotfiles/init.sh

# Setup ZSH
RUN apt-get update -y
RUN apt-get install -y zsh

# Change Shell
RUN chsh -s /bin/zsh

# Set Pure Shell

RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
RUN apt-get install -y nodejs
RUN npm install pure-prompt

# work env
RUN mkdir /root/CTF

RUN cd /root \
    && git clone https://github.com/fibonascii/Dotfiles.git \
    && rm .tmux.conf

RUN cd ~/Dotfiles \
    && git pull

RUN ln -s ~/Dotfiles/.tmux.conf ~/

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN rm ~/.zshrc
RUN ln -s ~/Dotfiles/.zshrc /root/


WORKDIR /root/CTF
