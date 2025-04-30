
import os
import sys
sys.path.append('third_party/Matcha-TTS')
import argparse
import torchaudio
from cosyvoice.cli.cosyvoice import CosyVoice2


def rule1():
    yield "어르신, 지금 약 드실 시간이에요."
    yield "지금 드실 약은 혈압약입니다. 하루 두번 드시는 약이에요."
    yield "한 번에 삼키시면 되고, 꼭 물을 충분히 드셔주세요."
    yield "드시고 나서 어지럽거나 속이 불편하면 말씀해주세요."

def rule2():
    yield "어르신, 안녕하세요. 지금은 점심식사 하실 시간이에요."
    yield "식사 맛있게 하시고, 식사 후에 영양제 챙겨 드시는거 잊지 마세요"

def rule3():
    yield "어르신, 오래 앉아 계셨어요. 지금은 몸을 조금 움직이실 시간이에요."
    yield "가볍게 손이나 다리를 풀어보는 건 어떠세요?"
    yield "제가 함께 운동 영상도 보여드릴 수 있어요."

def main(name, iters):
    os.makedirs(f"./rule/{name}", exist_ok=True)
    model_dir='pretrained_models/CosyVoice2-0.5B-trt'
    cosyvoice = CosyVoice2(model_dir, load_jit=False, load_trt=True, fp16=False)
    cache_path = f'/workspace/CosyVoice/prompt_wav_cache/{name}.pt'

    output_file ='./rule/{}/rule{}_{}.wav'

    for r in range(3):
        func = globals().get(f"rule{r+1}")
        for iter in range(iters) :
            for i, j in enumerate(cosyvoice.inference_zero_shot_use_cache(func(), cache_file_path=cache_path, stream=False)):
                torchaudio.save(output_file.format(name, r+1, iter), j['tts_speech'], cosyvoice.sample_rate)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--name',
                        type=str,
                        help='name of the voice')
    parser.add_argument('--iter',
                        type=int,
                        default=1,
                        help='number of iterations')
    args = parser.parse_args()
    main(args.name, args.iter)