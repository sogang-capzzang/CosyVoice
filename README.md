[![SVG Banners](https://svg-banners.vercel.app/api?type=origin&text1=CosyVoice🤠&text2=Text-to-Speech%20💖%20Large%20Language%20Model&width=800&height=210)](https://github.com/Akshay090/svg-banners)

## 👉🏻 CosyVoice 👈🏻
**CosyVoice 2.0**: [Demos](https://funaudiollm.github.io/cosyvoice2/); [Paper](https://arxiv.org/abs/2412.10117); [Modelscope](https://www.modelscope.cn/studios/iic/CosyVoice2-0.5B); [HuggingFace](https://huggingface.co/spaces/FunAudioLLM/CosyVoice2-0.5B)

**CosyVoice 1.0**: [Demos](https://fun-audio-llm.github.io); [Paper](https://funaudiollm.github.io/pdf/CosyVoice_v1.pdf); [Modelscope](https://www.modelscope.cn/studios/iic/CosyVoice-300M)

# 📖 CosyVoice 사용법

## 1. 설치 및 환경 설정

```bash
cd /workspace/CosyVoice
conda activate cosyvoice
./vast.sh
```

---

## 2. Usage

- 기본적으로 서버가 실행됩니다.
- 이후 클라이언트 스크립트를 사용해 서버에 요청을 보낼 수 있습니다.

---

## 3. pre_tokenized 사용법

- 서버 실행 시 `--pre_tokenized` 옵션을 사용하면,
  - 텍스트를 서버에서 토크나이즈하는 과정을 생략하고
  - 미리 토크나이즈된 token id를 직접 입력할 수 있습니다.
- 이로 인해 추론 속도가 향상됩니다.

```bash
python3 server.py --pre_tokenized True
```

- 클라이언트에서도 token id를 직접 전송해야 합니다.

---

## 4. 테스트 스크립트 사용

- `test_cache.py` 스크립트를 이용해 서버에 pre_tokenized input을 보내는 테스트를 할 수 있습니다.

```bash
python3 test_cache.py
```

---
