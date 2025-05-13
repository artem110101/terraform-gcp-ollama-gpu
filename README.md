# terraform-gcp-ollama-gpu

Terraform configuration for deploying a GPU-enabled Google Compute Engine (GCE) VM that is ready out-of-the-box for running Ollama or other large-language-model workloads.  
The module creates and wires together:

* A service account with the minimum permissions required by the VM.
* A custom VPC network, sub-network, and firewall rules that allow SSH (`tcp/22`) and ICMP.
* An external static IPv4 address.
* A pre-emptible (spot) GPU VM that installs CUDA automatically on first boot via a start-up script.

Every project-specific value has been parameterised in `variables.tf`, so no secrets or personal defaults are committed to the repository.

## Quick start

