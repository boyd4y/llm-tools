#!/bin/bash

echo "Launching Oobabooga web UI Server"
cd /workspace/text-generation-webui
# python download-model.py THUDM/chatglm-6b
# python download-model.py THUDM/chatglm2-6b
# python server.py --model THUDM_chatglm-6b --trust-remote-code --listen &
echo "Oobabooga web UI Server Ready"


echo "Launching ChatGLM2"
cd /workspace/ChatGLM2-6B
python web_demo.py &
# python download-model.py THUDM/chatglm-6b
# python download-model.py THUDM/chatglm2-6b
# python server.py --model THUDM_chatglm-6b --trust-remote-code --listen &
echo "ChatGLM2 Ready"

echo 'Download Dataset'
mkdir /workspace/dataset
cd /workspace/dataset
wget -O AdvertiseGen.tar.gz https://drive.google.com/u/0/uc?id=13_vf0xRTQsyneRKdD1bZIr93vBGOczrk&export=download
tar -xvf AdvertiseGen.tar.gz
mv AdvertiseGen /workspace/ChatGLM2-6B/ptuning
echo 'Dataset Ready'

