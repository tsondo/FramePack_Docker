![Build](https://img.shields.io/badge/build-passing-brightgreen)
![CUDA](https://img.shields.io/badge/CUDA-12.8-blue)
![Torch](https://img.shields.io/badge/Torch-2.2.2-informational)
![License](https://img.shields.io/github/license/tsondo/FramePack_Docker)

---

# 🎞️ FramePack-Docker

A reproducible Docker setup for running vanilla FramePack with GPU acceleration and persistent storage.
For setup help, see GETTING_STARTED.md and HOWTO.md.

---

## 🚀 Quick Start

    git clone https://github.com/tsondo/FramePack_Docker.git
    cd FramePack_Docker
    cp .env.template .env   # edit .env to set your paths and options
    bash setup.sh
    docker compose up

Then open http://localhost:7860

---

## 📂 Persistent Folders

- models/ → FramePack model weights
- outputs/ → generated outputs
- hf_download/ → Hugging Face cache

---

## 📌 Scope

This project does not add new features to FramePack. It simply provides a clean, reproducible Docker environment. Future plans may include optional integration with A1111 for text‑to‑image and Lora support, but today this is vanilla FramePack in Docker.

---

## 📖 Documentation

- GETTING_STARTED.md — plain‑language intro for Docker/FramePack beginners
- HOWTO.md — step‑by‑step WSL + Docker + NVIDIA setup guide

⚠️ Note on .env changes:
If you edit your .env file after the container is already running, you need to recreate the container for the new values to apply. A simple `docker compose restart` is not enough. Use:

    docker compose up -d --force-recreate

This will restart the service with the updated environment variables.
