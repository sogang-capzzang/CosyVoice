import time
init_time = time.time()
import sys
import os
sys.path.append('third_party/Matcha-TTS')

def main(): 
    # set test configuration
    DEBUG = True
    use_stream = True
    model_dir='pretrained_models/CosyVoice2-0.5B-trt'
    cache_path = '/workspace/CosyVoice/prompt_wav_cache/woon.pt'
    output_file ='./test/results/cache_{}_{}.wav'
    a = open("./test/logs_zero_shot_firstack.txt", 'w')

    if DEBUG:
        from viztracer import VizTracer
        tracer = VizTracer()
        tracer.start()

    from cosyvoice.cli.cosyvoice import CosyVoice2
    import torchaudio


    cosyvoice = CosyVoice2(model_dir, load_jit=False, load_trt=True, fp16=False, use_vllm=True)

    def text_generator():
        yield "세상은 매일 진화하고 있습니다."
        yield "AI는 이제 단순한 도구가 아니라,"
        yield "우리 삶의 일부가 되었죠."
        yield "오늘, 그 놀라운 변화를 함께 만나봅니다."
    load_time = time.time()

    print("load time : %.2f"%(load_time-init_time))

    for iter in range(5):
        start_time = time.time()

        idx = 0
        for i, j in enumerate(cosyvoice.inference_zero_shot_use_cache(text_generator(), cache_file_path=cache_path, stream=True)):   
            torchaudio.save(output_file.format(iter,i), j['tts_speech'], cosyvoice.sample_rate)
            if i == 0:
                print("first ack time : %f"%(time.time()-start_time),end=" ", file = a)
            idx = i

        end_time = time.time()
        print("iter time : %.2f"%(end_time-start_time),file=a);
        #combine all wav files into one
        if use_stream:
            from pydub import AudioSegment
            tmp = AudioSegment.empty()
            for i in range(idx + 1):
                tmp += AudioSegment.from_wav(output_file.format(iter,i))
                os.remove(output_file.format(iter,i))
            tmp.export("test/results/cache_{}.wav".format(iter), format="wav")

if __name__ == '__main__':
    from multiprocessing import freeze_support
    freeze_support()
    main()