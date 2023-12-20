# Python 3.8
FROM ghcr.io/coreweave/ml-containers/torch-extras:f35193e-nccl-cuda12.1.1-nccl2.18.3-1-torch2.1.1-vision0.16.1-audio2.1.1-flash_attn2.3.6

RUN apt-get update && \
    apt-get install -y --allow-change-held-packages vim curl nano libnccl2 libnccl-dev

WORKDIR /workspace

RUN git clone --depth=1 https://github.com/OpenAccess-AI-Collective/axolotl.git

WORKDIR /workspace/axolotl

RUN pip install -e .[deepspeed,flash-attn]

# fix so that git fetch/pull from remote works
RUN git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" && \
    git config --get remote.origin.fetch

# helper for huggingface-login cli
RUN git config --global credential.helper store