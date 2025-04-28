[![SVG Banners](https://svg-banners.vercel.app/api?type=origin&text1=CosyVoice🤠&text2=Text-to-Speech%20💖%20Large%20Language%20Model&width=800&height=210)](https://github.com/Akshay090/svg-banners)

## 👉🏻 CosyVoice 👈🏻
**CosyVoice 2.0**: [Demos](https://funaudiollm.github.io/cosyvoice2/); [Paper](https://arxiv.org/abs/2412.10117); [Modelscope](https://www.modelscope.cn/studios/iic/CosyVoice2-0.5B); [HuggingFace](https://huggingface.co/spaces/FunAudioLLM/CosyVoice2-0.5B)

**CosyVoice 1.0**: [Demos](https://fun-audio-llm.github.io); [Paper](https://funaudiollm.github.io/pdf/CosyVoice_v1.pdf); [Modelscope](https://www.modelscope.cn/studios/iic/CosyVoice-300M)

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

# if some selection page are open please enter 'N'

```
---

## 2. 사용자 프롬프트 토큰을 생성
- `./voice/$NAME/prompt.txt`, `./voice/$NAME/prompt.wav` 경로에 파일 넣기
- 정상적인 텍스트로 10초 가량의 차분한 목소리를 녹음하고 사용 하였을때 가장 좋은 결과를 도출 할 수 있음

```bash
mkdir -p ./prompt_wav_cache
python3 pre_tokenized.py --name $NAME
# ex) python3 pre_tokenizer.py --name woon
```


---
## 3. server.sh 사용 방법 (fastapi)
``` bash
./server.sh --port [PORT]
```
- `IP:PORT/inference_zero_shot_use_cache` 로 HTTP request
- [Client](https://github.com/sogang-capzzang/WSL-Application) 설정에 이를 반영해야함
