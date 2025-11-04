#!/bin/bash
set -e

echo "🔧 Setting up FramePack environment..."

# Step 1: Fix ownership of models directory
echo "📁 Ensuring ./models is owned by $USER..."
sudo chown -R $USER:$USER ./models || true

# Step 2: Create required directories
echo "📁 Creating model directories..."
mkdir -p ./models/checkpoints
mkdir -p ./models/upscale_models
mkdir -p ./models/vae
mkdir -p ./models/refiners

# Step 3: Install aria2 if not present
if ! command -v aria2c &> /dev/null; then
    echo "📦 Installing aria2..."
    sudo apt update && sudo apt install -y aria2
else
    echo "✅ aria2 already installed."
fi

# Step 4: Download Stable Diffusion XL base model
if [ ! -f ./models/checkpoints/sd_xl_base_1.0.safetensors ]; then
    echo "⬇️ Downloading SDXL base model..."
    aria2c -x 16 -s 16 -d ./models/checkpoints -o sd_xl_base_1.0.safetensors \
      "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
else
    echo "✅ SDXL base model already present."
fi

# Step 5: Download Real-ESRGAN upscaler
if [ ! -f ./models/upscale_models/realesr-general-x4v3.pth ]; then
    echo "⬇️ Downloading Real-ESRGAN upscaler..."
    wget -O ./models/upscale_models/realesr-general-x4v3.pth \
      https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.5.0/realesr-general-x4v3.pth
else
    echo "✅ Real-ESRGAN upscaler already present."
fi

echo "🎉 Setup complete. You can now run: docker compose up"
