#!/bin/bash

echo "Launching Oobabooga web UI Server"
cd /workspace/text-generation-webui
python download-model.py THUDM/chatglm-6b
python server.py --model THUDM_chatglm-6b --trust-remote-code --listen &
echo "Oobabooga web UI Server Ready"