FROM nvidia/cuda:11.7.1-runtime-ubuntu22.04

RUN apt update && apt-get -y install git wget \
    python3.10 python3.10-venv python3-pip \
    build-essential libgl-dev libglib2.0-0 wget
RUN ln -s /usr/bin/python3.10 /usr/bin/python
WORKDIR /workspace

RUN git clone https://github.com/boyd4y/ChatGLM2-6B.git && \
    cd ChatGLM2-6B && \
    pip3 install -e requirements.txt

