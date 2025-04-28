[![SVG Banners](https://svg-banners.vercel.app/api?type=origin&text1=CosyVoice🤠&text2=Text-to-Speech%20💖%20Large%20Language%20Model&width=800&height=210)](https://github.com/Akshay090/svg-banners)

## 👉🏻 CosyVoice 👈🏻
**CosyVoice 2.0**: [Demos](https://funaudiollm.github.io/cosyvoice2/); [Paper](https://arxiv.org/abs/2412.10117); [Modelscope](https://www.modelscope.cn/studios/iic/CosyVoice2-0.5B); [HuggingFace](https://huggingface.co/spaces/FunAudioLLM/CosyVoice2-0.5B)

**CosyVoice 1.0**: [Demos](https://fun-audio-llm.github.io); [Paper](https://funaudiollm.github.io/pdf/CosyVoice_v1.pdf); [Modelscope](https://www.modelscope.cn/studios/iic/CosyVoice-300M)

## 1. 초기 설정

```bash
cd /workspace/CosyVoice
conda activate cosyvoice
./vast.sh
```

---

## 2. pre_tokenized 사용법



```bash
python3 pre_tokenized.py --model_dir [사용할 모델] --name [사용자 이름]
# ex) python3 pre_tokenized.py --model_dir pretrained_models/CosyVoice2-0.5B-trt --name woon
```


---

## 3. test_cache.py 사용법

- `test_cache.py` 

```bash
python3 test_cache.py
```

---
