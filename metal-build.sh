#!/bin/bash
set -e

# 仅在 build 目录不存在时执行 cmake 配置
if [ ! -d build ]; then
	cmake -B build -DGGML_VULKAN=OFF -DGGML_METAL=ON -DGGML_METAL_EMBED_LIBRARY=OFF
fi

targets=(
	ggml-metal-lib
	llama-cli
	# llama-server
	# llama-completion
)
cmake --build build --config Release -j 10 --target "${targets[@]}"
