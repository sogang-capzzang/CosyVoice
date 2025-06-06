#!/bin/bash
# Copyright 2024 Alibaba Inc. All Rights Reserved.
# download Tensor-RT from : https://developer.nvidia.com/downloads/compute/machine-learning/tensorrt/10.9.0/tars/TensorRT-10.9.0.34.Linux.x86_64-gnu.cuda-12.8.tar.gz
TRT_DIR=./TensorRT-10.9.0.34
MODEL_DIR=./pretrained_models/CosyVoice2-0.5B-trt
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$TRT_DIR/lib:/usr/local/cuda/lib64

# MJKIM README
# Consider "optShapes" argument, it influence exec time
 
# onnx_fp32-> trt_fp32
# memory issue : reduce maxShape 2x80x6800 -> 2x80x5000
opt_dim=193
out_dim=6800
$TRT_DIR/bin/trtexec --onnx=$MODEL_DIR/flow.decoder.estimator.fp32.onnx \
                     --saveEngine=$MODEL_DIR/flow.decoder.estimator.fp32.mygpu.plan \
                     --minShapes=x:2x80x4,mask:2x1x4,mu:2x80x4,cond:2x80x4 \
                     --maxShapes=x:2x80x$out_dim,mask:2x1x$out_dim,mu:2x80x$out_dim,cond:2x80x$out_dim \
                     --optShapes=x:2x80x$opt_dim,mask:2x1x$opt_dim,mu:2x80x$opt_dim,cond:2x80x$opt_dim \
                     --inputIOFormats=fp32:chw,fp32:chw,fp32:chw,fp32:chw,fp32:chw,fp32:chw \
                     --outputIOFormats=fp32:chw \
                     --verbose

# onnx_fp32-> trt_fp16
$TRT_DIR/bin/trtexec --onnx=$MODEL_DIR/flow.decoder.estimator.fp32.onnx \
                     --saveEngine=$MODEL_DIR/flow.decoder.estimator.fp16.mygpu.plan \
                     --fp16 \
                     --minShapes=x:2x80x4,mask:2x1x4,mu:2x80x4,cond:2x80x4 \
                     --maxShapes=x:2x80x6800,mask:2x1x6800,mu:2x80x6800,cond:2x80x6800 \
                     --optShapes=x:2x80x$opt_dim,mask:2x1x$opt_dim,mu:2x80x$opt_dim,cond:2x80x$opt_dim \
                     --inputIOFormats=fp16:chw,fp16:chw,fp16:chw,fp16:chw,fp16:chw,fp16:chw \
                     --outputIOFormats=fp16:chw \
                     --verbose