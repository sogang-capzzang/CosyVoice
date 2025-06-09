#!/bin/bash
function usage(
    {
        echo "Usage: $0 [--port PORT] [--model_dir MODEL_DIR]"
        echo "Options:"
        echo "  --model_dir   Specify the model directory (default: pretrained_models/CosyVoice2-0.5B-trt)"
        echo "  --port PORT   Specify the port number for the server (default: 8080)"
        echo "  --use_vllm    Enable vLLM (default: disabled)"
    }
)

usage
MODEL_DIR="pretrained_models/CosyVoice2-0.5B-trt"
PORT=8080
USE_VLLM=""
while [[ $# -gt 0 ]]; do
    case $1 in
        --model_dir)
            MODEL_DIR="$2"
            shift 2
            ;;
        --port)
            PORT="$2"
            shift 2
            ;;
        --use_vllm)
            USE_VLLM="--use_vllm"
            shift
            ;;    
        *)
            usage
            exit 1
            ;;
    esac
done
python ./runtime/python/fastapi/server.py --model_dir $MODEL_DIR --port $PORT $USE_VLLM
