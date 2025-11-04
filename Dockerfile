FROM nvidia/cuda:12.8.0-runtime-ubuntu22.04 AS base

# Build-time arguments
ARG UID=1000
ARG GID=1000
ARG MAX_JOBS=16
ARG REPO_URL=https://github.com/lllyasviel/FramePack
ARG REPO_BRANCH=main

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    VIRTUAL_ENV=/app/venv \
    PATH="/app/venv/bin:$PATH" \
    USER=appuser \
    MAX_JOBS=$MAX_JOBS \
    HF_HOME=/app/hf_download \
    CLI_ARGS="--server 0.0.0.0"

# Layer 1: System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    ninja-build \
    sudo \
    curl \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Layer 2: Create user and directory structure
RUN groupadd -g $GID appuser && \
    useradd -u $UID -g $GID -m -s /bin/bash appuser && \
    echo "appuser ALL=(ALL) NOPASSWD: /bin/chown" >> /etc/sudoers && \
    mkdir -p /app /app/outputs /app/hf_download && \
    chown -R $UID:$GID /app

# Layer 3: Setup Python environment and clone repo
USER $UID:$GID
WORKDIR /app
RUN python3.10 -m venv $VIRTUAL_ENV && \
    python -m pip install --upgrade pip wheel setuptools && \
    git clone --depth 1 --branch $REPO_BRANCH $REPO_URL /tmp/framepack && \
    cp -r /tmp/framepack/* /app/ && \
    rm -rf /tmp/framepack

# Layer 4: Install PyTorch ecosystem (tested versions)
RUN pip install --no-cache-dir \
    torch==2.8.0 \
    torchvision==0.23.0 \
    --index-url https://download.pytorch.org/whl/cu128

# Layer 5: Install FramePack requirements
RUN pip install --no-cache-dir -r /app/requirements.txt

# Layer 6: Performance enhancements and attention backends
RUN pip install --no-cache-dir \
    xformers \
    sageattention==1.0.6

# Layer 7: Attention backends
RUN pip install --no-cache-dir sageattention==1.0.6 xformers

# Layer 8: Diagnostics
RUN python -c "import torch; import torchvision; \
    print(f'Torch: {torch.__version__}, TorchVision: {torchvision.__version__}'); \
    print('CUDA available:', torch.cuda.is_available()); \
    import torchvision.ops; print('torchvision.ops loaded successfully')"

# ===== APPLICATION STAGE =====
FROM base AS application

ARG UID=1000
ARG GID=1000

USER root
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chown $UID:$GID /entrypoint.sh

USER $UID:$GID
WORKDIR /app
EXPOSE 7860

# Declare volumes
VOLUME /app/hf_download
VOLUME /app/outputs

# Healthcheck
HEALTHCHECK CMD curl -f http://localhost:7860 || exit 1

# Entrypoint and command
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash", "-c", "exec python demo_gradio.py $CLI_ARGS"]
