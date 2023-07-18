FROM runpod/pytorch:2.0.1-py3.10-cuda11.8.0-devel

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
ENV SHELL=/bin/bash

RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt install --yes --no-install-recommends\
    nginx\
    wget\
    bash\
    vim\
    nano\
    rsync \
    blobfuse \
    openssh-server &&\
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN /usr/bin/python3 -m pip install --upgrade pip
RUN pip install jupyterlab
RUN pip install ipywidgets
RUN pip install deepspeed

RUN cd /workspace && git clone https://github.com/oobabooga/text-generation-webui.git && cd /workspace/text-generation-webui && pip install -r requirements.txt
# RUN cd /workspace/text-generation-webui && python download-model.py PygmalionAI/pygmalion-6b
RUN mv /workspace/text-generation-webui /text-generation-webui

RUN cd /workspace && git clone https://github.com/boyd4y/ChatGLM2-6B.git && cd /workspace/ChatGLM2-6B && pip install -r requirements.txt
RUN pip install rouge_chinese nltk jieba datasets transformers[torch]

# NGINX Proxy
COPY nginx.conf /etc/nginx/nginx.conf
COPY readme.html /usr/share/nginx/html/readme.html

# Copy the README.md
COPY README.md /usr/share/nginx/html/README.md

# Start Scripts
COPY pre_start.sh /pre_start.sh
COPY post_start.sh /post_start.sh
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD [ "/start.sh" ]