# Getting Started with FramePack-Docker

This guide is for anyone new to Docker or FramePack. It explains the basics in plain language and points you back to the main [README.md](README.md) for deeper technical details.

---

## 🐳 What is Docker?

Docker packages software into **containers** — lightweight, portable boxes that include everything the program needs.  
The benefit: FramePack runs the same way on any machine, without you manually installing CUDA, Python, or dependencies.

---

## 🎞️ What is FramePack?

FramePack is a research‑oriented video generation pipeline. It can take images and extend them into temporal sequences, producing short video clips.  
This build runs FramePack inside a Docker container, so you don’t have to worry about CUDA or Python setup.

---

## 📦 Why this build?

This Docker setup separates what’s **ephemeral** (rebuilt each time) from what’s **persistent** (your data and models):

- **Ephemeral (inside the container):**
  - Python environment
  - Installed packages
  - Container filesystem

- **Persistent (mounted from your host):**
  - `models/` → FramePack model weights
  - `outputs/` → generated videos
  - `hf_download/` → Hugging Face cache

This means you can rebuild or update the container at any time without losing your models or outputs.

---

## 🚀 How to run

See the [README.md](README.md) for full setup instructions.  
In short: run the provided `setup.sh` script, then open your browser to:

http://localhost:7860

That’s the FramePack UI.

---

## 🧩 Adding models

FramePack requires specific pretrained models (downloaded automatically by `setup.sh`).  
If you want to preload additional models, place them under `./models/` before launch.

---

## 🪟 Accessing folders from Windows

If you’re running Docker Desktop on Windows:

- The `FramePack_Docker` folder on your host is mounted into the container.
- Drop models into `FramePack_Docker/models/` directly from Windows Explorer.
- Outputs will appear in `FramePack_Docker/outputs/` on your host.

---

## ✅ Summary

- Docker runs FramePack in a clean, reproducible environment.
- Your models and outputs are **persistent** on your host.
- Access the UI at http://localhost:7860.
- For full details, see the main [README.md](README.md).
