#!/bin/zsh

CMD=cli
typeset -A CMD_PATHS
CMD_PATHS[cli]="$(dirname "$0")/build/bin/llama-cli"
CMD_PATHS[comp]="$(dirname "$0")/build/bin/llama-completion"
CMD_PATHS[server]="$(dirname "$0")/build/bin/llama-server"

MODEL=qwen35_08b
typeset -A MODEL_PATHS
# 533M
MODEL_PATHS[qwen35_08b]="$LLAMA_ARG_MODELS_DIR/unsloth/Qwen3___5-0___8B-GGUF/Qwen3.5-0.8B-UD-Q4_K_XL.gguf"
# 1.2G + 637M = 1267 多模态, 仅支持图片
MODEL_PATHS[qwen35_2b]="$LLAMA_ARG_MODELS_DIR/unsloth/Qwen3___5-2B-GGUF/Qwen3.5-2B-UD-Q4_K_XL.gguf\
  --mmproj $LLAMA_ARG_MODELS_DIR/unsloth/Qwen3___5-2B-GGUF/mmproj-F16.gguf"
# 2.7G + 641M = 2766M 多模态, 仅支持图片
MODEL_PATHS[qwen35_4b]="$LLAMA_ARG_MODELS_DIR/unsloth/Qwen3___5-4B-GGUF/Qwen3.5-4B-UD-Q4_K_XL.gguf\
  --mmproj $LLAMA_ARG_MODELS_DIR/unsloth/Qwen3___5-4B-GGUF/mmproj-F16.gguf"
# 5.6G = 5133M 多模态, 仅支持图片
MODEL_PATHS[qwen35_9b]="$LLAMA_ARG_MODELS_DIR/unsloth/Qwen3___5-9B-GGUF/Qwen3.5-9B-UD-Q4_K_XL.gguf"
# 4.8G + 944M = 3002M 多模态, 支持音频, 但不太能稳定输出中文
MODEL_PATHS[gemma_e4b]="$LLAMA_ARG_MODELS_DIR/unsloth/gemma-4-E4B-it-GGUF/gemma-4-E4B-it-UD-Q4_K_XL.gguf\
  --mmproj $LLAMA_ARG_MODELS_DIR/unsloth/gemma-4-E4B-it-GGUF/mmproj-F16.gguf"

args=(
  --model "${(z)MODEL_PATHS[$MODEL][@]}"
  # --ctx-size 1024
  # --ctx-size 2048
  --ctx-size 4096
  # --ctx-size 5120
  # --ctx-size 8192
  # --ctx-size 9216
  # --ctx-size 10240
  # --ctx-size 12288
  # --ctx-size 16384
  # --ctx-size 32768
  # --ctx-size 65536
  # --ctx-size 98304
  # --ctx-size 131072
  # --ctx-size 163840
  --temperature 0.7
  --top-p 0.8
  --top-k 20
  --min-p 0.0
  --presence-penalty 1.5
  --repeat-penalty 1.0
  --prompt "如何提升英语口语水平"
  --predict 256
  --single-turn
  --fit-target 1
  # --gpu-layers 0
  --log-verbosity 3
  --reasoning off
  # --chat-template-kwargs '{"enable_thinking":false}'
)

"${CMD_PATHS[$CMD]}" "${args[@]}"

# 示例输出, 末尾40行:
# 
# > 如何提升英语口语水平
# 提高英语能力是一个系统工程，需要**输入（听、读）、输出（说、写）以及环境营造**的平衡。没有一种“速成”的方法，但可以通过科学的方法实现显著进步。
# prompt eval time =     328.54 ms /    16 tokens (   20.53 ms per token,    48.70 tokens per second)
#       eval time =    4842.39 ms /   256 tokens (   18.92 ms per token,    52.87 tokens per second)
#      total time =    5170.93 ms /   272 tokens
# [ Prompt: 25.2 t/s | Generation: 21.7 t/s ]