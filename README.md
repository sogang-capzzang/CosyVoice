[![SVG Banners](https://svg-banners.vercel.app/api?type=origin&text1=CosyVoice🤠&text2=Text-to-Speech%20💖%20Large%20Language%20Model&width=800&height=210)](https://github.com/Akshay090/svg-banners)

## 👉🏻 CosyVoice 👈🏻
**CosyVoice 2.0**: [Demos](https://funaudiollm.github.io/cosyvoice2/); [Paper](https://arxiv.org/abs/2412.10117); [Modelscope](https://www.modelscope.cn/studios/iic/CosyVoice2-0.5B); [HuggingFace](https://huggingface.co/spaces/FunAudioLLM/CosyVoice2-0.5B)

## 1. Usage
### prerequisite
- CUDA >= 12.4
- nvidia container toolkit
- docker

### Clone docker image
```bash
docker pull goldrunn/cosyvoice_mjkim
docker run —gpus all -p 8080:8080 —user root —rm -it goldrunn/cosyvoice_mjkim
```
### At the container
```bash
cd /workspace/CosyVoice
conda activate cosyvoice
git checkout main
git pull
sudo apt-get install vim unzip -y
tar -xvf test.tar.gz
cp ./pretrained_models/CosyVoice2-0.5B ./pretrained_models/CosyVoice2-0.5B-trt -r
./cosyvoice/bin/export_trt.sh
cd pretrained_models/CosyVoice-ttsfrd
unzip resource.zip -d . && \
cd -
pip install ttsfrd_dependency-0.1-py3-none-any.whl
pip install ttsfrd-0.4.2-cp310-cp310-linux_x86_64.whl
cd ../../
pip install -r requirements_vllm.txt
cp pretrained_models/CosyVoice2-0.5B-trt/CosyVoice-BlankEN/{config.json,tokenizer_config.json,vocab.json,merges.txt} pretrained_models/CosyVoice2-0.5B-trt/
sed -i 's/Qwen2ForCausalLM/CosyVoice2Model/' pretrained_models/CosyVoice2-0.5B-trt/config.json
FILE="/opt/conda/envs/cosyvoice/lib/python3.10/site-packages/deepspeed/elasticity/elastic_agent.py"
sed -i '/^from torch\.distributed\.elastic\.agent\.server\.api import _get_socket_with_port/s/^/# /' "$FILE"
echo -e '\n'"def _get_socket_with_port():\n    import socket\n    return socket.socket()" >> "$FILE"
# if some selection slot is opened, please enter 'N'

```
### Before inferencing with vllm
```bash
#you have to run verify_vllm.py
python verify_vllm.py
```

---

## 2. 사용자 프롬프트 토큰을 생성
- `./voice/$NAME/prompt.txt`, `./voice/$NAME/prompt.wav` 경로에 파일 넣기
- 정상적인 텍스트로 10초 가량의 차분한 목소리를 녹음하고 사용 하였을때 가장 좋은 결과를 도출 할 수 있음

```bash
mkdir -p ./prompt_wav_cache
python3 pre_tokenized.py --name $NAME
# ex) python3 pre_tokenized.py --name woon
```


---
## 3. runtime/python/fastapi/server.py 사용 방법 (fastapi)
``` bash
# no vllm inference
python runtime/python/fastapi/server.py --port [PORT]

# use vllm inference
python runtime/python/fastapi/server.py --port [PORT] --use_vllm

```
- `IP:PORT/inference_zero_shot_use_cache` 로 HTTP request
- [Client](https://github.com/sogang-capzzang/WSL-Application) 설정에 이를 반영해야함

## 4. Rule-based voice 생성 방법 (tokenize를 미리 해야함)

``` bash
mkdir -p ./rule
python3 gen_rule_base.py --name $NAME --iter $ITER
# python3 gen_rule_base.py --name woon --iter 5
```
