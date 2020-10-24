FROM python:3.8 
 
ARG WORKSPACE=/root 

RUN apt-get update 

RUN git clone https://github.com/vim/vim.git && cd vim/src && ./configure &&  make && make install 

RUN git config --global user.name "John Doe"
RUN git config --global user.email johndoe@example.com

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install nodejs wget zsh build-essential  -y

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true

RUN pip install annoy streamlit pandas transformers numpy torch torchvision tensorflow

 
WORKDIR $WORKSPACE

COPY .vimrc ${WORKSPACE}/.vimrc 
COPY plug.vim ${WORKSPACE}/.vim/autoload/plug.vim

RUN vim +PlugInstall +qall 

RUN curl https://sh.rustup.rs -sSf  | sh -s -- -y 

CMD ["zsh"]
