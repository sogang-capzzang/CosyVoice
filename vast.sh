#!/bin/bash
git checkout main
git pull
sudo apt-get install vim unzip -y
tar -xvf test.tar.gz
cp ./pretrained_models/CosyVoice2-0.5B ./pretrained_models/CosyVoice2-0.5B-trt -r
./cosyvoice/bin/export_trt.sh
mkdir -p ./prompt_wav_cache
cd pretrained_models/CosyVoice-ttsfrd
unzip -n resource.zip -d . && \
pip install ttsfrd_dependency-0.1-py3-none-any.whl
pip install ttsfrd-0.4.2-cp310-cp310-linux_x86_64.whl
cd ../../
pip install -r requirements_vllm.txt
cp pretrained_models/CosyVoice2-0.5B-trt/CosyVoice-BlankEN/{config.json,tokenizer_config.json,vocab.json,merges.txt} pretrained_models/CosyVoice2-0.5B-trt/
sed -i 's/Qwen2ForCausalLM/CosyVoice2Model/' pretrained_models/CosyVoice2-0.5B-trt/config.json
FILE="/opt/conda/envs/cosyvoice/lib/python3.10/site-packages/deepspeed/elasticity/elastic_agent.py"
sed -i '/^from torch\.distributed\.elastic\.agent\.server\.api import _get_socket_with_port/s/^/# /' "$FILE"
echo -e '\n'"def _get_socket_with_port():\n    import socket\n    return socket.socket()" >> "$FILE"
