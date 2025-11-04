![Build](https://img.shields.io/badge/build-passing-brightgreen)
![CUDA](https://img.shields.io/badge/CUDA-12.8-blue)
![Torch](https://img.shields.io/badge/Torch-2.2.2-informational)
![License](https://img.shields.io/github/license/tsondo/FramePack_Docker)

---

📖 **New to WSL/Docker on Windows?**  
See the [HOWTO guide](HOWTO.md) for step‑by‑step instructions on installing Docker inside WSL (Ubuntu 22.04) before using this project.

📘 **New to Docker or FramePack in general?**  
Check out the [GETTING_STARTED.md](GETTING_STARTED.md) guide for a plain‑language introduction: what Docker is, what FramePack does, what’s persistent vs. ephemeral in this build, and how to add your first models.

---

# 🎞️ FramePack-Docker

A reproducible Docker setup for running vanilla FramePack with GPU acceleration and persistent storage.

---

## 🚀 Quick Start

git clone https://github.com/tsondo/FramePack_Docker.git
cd FramePack_Docker
bash setup.sh
docker compose up

Then open http://localhost:7860

---

## 📂 Persistent Folders

- models/ → FramePack model weights
- outputs/ → generated outputs
- hf_download/ → Hugging Face cache

---

## 📖 Documentation

- GETTING_STARTED.md — plain‑language intro for Docker/FramePack beginners
- HOWTO.md — step‑by‑step WSL + Docker + NVIDIA setup guide

---

## 📌 Scope

This project does not add new features to FramePack. It simply provides a clean, reproducible Docker environment. Future plans may include optional integration with A1111 for text‑to‑image and Lora support, but today this is vanilla FramePack in Docker.
