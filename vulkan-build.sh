#!/bin/bash
set -e

# 仅在 build 目录不存在时执行 cmake 配置
if [ ! -d build ]; then
	cmake -B build -DGGML_VULKAN=ON -DGGML_METAL=OFF
fi

targets=(
	llama-cli
	# llama-server
	# llama-completion
)
cmake --build build --config Release -j 10 --target "${targets[@]}"
