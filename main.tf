provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "vm_service_account" {
  account_id   = var.service_account_id
  display_name = var.service_account_display_name
}

resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.vpc_network_name
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_firewall" "ssh_rule" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "icmp_rule" {
  name    = "allow-icmp"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = var.subnetwork_name
  region        = var.region
  ip_cidr_range = var.subnetwork_cidr
  stack_type    = "IPV4_ONLY"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_address" "static_ip" {
  name         = var.static_ip_name
  address_type = "EXTERNAL"
  network_tier = "STANDARD"
}

resource "google_compute_instance" "encrypted_vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  guest_accelerator {
    type  = var.accelerator_type
    count = var.accelerator_count
  }

  scheduling {
    preemptible         = true
    provisioning_model  = "SPOT"
    on_host_maintenance = "TERMINATE"
    automatic_restart   = false
  }

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.vpc_subnetwork.self_link
    stack_type = "IPV4_ONLY"

    access_config {
      nat_ip       = google_compute_address.static_ip.address
      network_tier = "STANDARD"
    }
  }

  service_account {
    email  = google_service_account.vm_service_account.email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = <<-SCRIPT
    #!/bin/bash
    if test -f /opt/google/cuda-installer
    then
      exit
    fi

    mkdir -p /opt/google/cuda-installer
    cd /opt/google/cuda-installer/ || exit

    curl -fSsL -O https://github.com/GoogleCloudPlatform/compute-gpu-installation/releases/download/cuda-installer-v1.2.0/cuda_installer.pyz
    python3 cuda_installer.pyz install_cuda
  SCRIPT

  metadata = {
    ssh-keys = var.ssh_public_key
  }
}
