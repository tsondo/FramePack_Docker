![Build](https://img.shields.io/badge/build-passing-brightgreen)
![CUDA](https://img.shields.io/badge/CUDA-12.8-blue)
![Torch](https://img.shields.io/badge/Torch-2.2.2-informational)
![License](https://img.shields.io/github/license/tsondo/FramePack_Docker)

# 🎞️ FramePack-Docker

A reproducible, persistent Docker setup for running [FramePack](https://github.com/your-org/framepack) with GPU acceleration, model persistence, and clean config management.

---

📖 **New to WSL/Docker on Windows?**  
See the [HOWTO guide](HOWTO.md) for step‑by‑step instructions on installing Docker inside WSL (Ubuntu 22.04) before using this project.

📘 **New to Docker or FramePack in general?**  
Check out the [GETTING_STARTED.md](GETTING_STARTED.md) guide for a plain‑language introduction: what Docker is, what FramePack does, what’s persistent vs. ephemeral in this build, and how to add your first models.

---

## 🐧 Setup for Linux (Ubuntu, Debian, Arch, etc. Assumes Docker with Compose is already installed)

### 1. Clone the repo

git clone https://github.com/tsondo/FramePack_Docker.git ~/FramePack_Docker
cd ~/FramePack_Docker

This gives you access to setup.sh, docker-compose.yml, and all required files.

### 2. Install Docker and Docker Compose

Follow official instructions:  
https://docs.docker.com/engine/install/

Then install Docker Compose plugin:

sudo apt install docker-compose-plugin

Add your user to the Docker group (optional):

sudo usermod -aG docker $USER
newgrp docker

### 3. Run setup and launch

bash setup.sh
docker compose up

Access the FramePack UI at http://localhost:7860

---

## 🪟 Setup for Windows (Docker Desktop + WSL2)

### 1. Install Docker Desktop

Download and install from:  
https://www.docker.com/products/docker-desktop/

Enable **WSL2 integration** during setup. You’ll need:

- Windows 10/11 with WSL2 enabled
- A Linux distro installed (Ubuntu recommended)

### 2. Open your WSL terminal

Use Windows Terminal or your preferred terminal app to open Ubuntu (or other WSL distro).

### 3. Clone the repo inside WSL

git clone https://github.com/tsondo/FramePack_Docker.git ~/FramePack_Docker
cd ~/FramePack_Docker

### 4. Run setup. It will setup everything, build, then launch via docker compose up

bash setup.sh

Access the FramePack UI at http://localhost:7860 from your Windows browser.

**Important:**  
Run all commands inside WSL — not PowerShell or CMD.  
Your persistent folders live inside your WSL home directory.

---

## 🚀 What setup.sh does

- Fixes ownership of models/ so you don’t hit root permission issues
- Creates persistent folders for models, outputs, and configs
- Installs aria2 if missing
- Downloads required models:
  - sd_xl_base_1.0.safetensors → ./models/checkpoints/
  - realesr-general-x4v3.pth → ./models/upscale_models/
- Prepares everything for docker compose up

---

## 🧱 Persistent Folders

These folders are mounted into the container and survive restarts:

| Host Folder             | Container Path               | Purpose                          |
|--------------------------|------------------------------|----------------------------------|
| models/checkpoints/      | /app/models/checkpoints      | Base models and checkpoints      |
| models/upscale_models/   | /app/models/upscale_models   | Upscaler models (Real-ESRGAN, etc.) |
| models/vae/              | /app/models/vae              | VAE models                       |
| models/refiners/         | /app/models/refiners         | Refiners                         |
| outputs/                 | /app/outputs                 | Generated images and results     |
| hf_download/             | /app/hf_download             | Hugging Face cache               |

---

## 📦 Preloading Models (Optional)

To add more models before first launch, place them in the appropriate subfolder under ./models/. For example:

mkdir -p ~/FramePack_Docker/models/checkpoints
wget -O ~/FramePack_Docker/models/checkpoints/sd_xl_refiner_1.0.safetensors \
  https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors

---

## 🔁 Daily Usage: Bringing the Container Up and Down

To start FramePack each day, always run setup.sh — not just docker compose up. This ensures all folders, models, and updates are in place before launch.

bash setup.sh

This will:

- Pull the latest repo updates
- Rebuild the container only if needed
- Verify all persistent folders and models
- Launch the FramePack container

Access the interface at http://localhost:7860

---

### 🧪 Optional: Force Rebuild with --no-cache

If you're troubleshooting or testing Dockerfile changes, you can force a full rebuild:

bash setup.sh --no-cache

---

### 🛑 To Stop the Container

docker compose down

This stops the running container but preserves all persistent data.
