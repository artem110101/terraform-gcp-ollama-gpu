# terraform-gcp-ollama-gpu 🚀🦙

Spin up a **low-cost** pre-emptible (spot) GPU VM on Google Cloud that auto-installs CUDA and is ready for **Ollama** or any other LLM workload.

## Why? 🤔
* 💸  Spot pricing keeps costs tiny.  
* 🛠️  One `terraform apply` sets up VPC, firewall, static IP, service account **and** the VM (with CUDA installed on first boot).  
