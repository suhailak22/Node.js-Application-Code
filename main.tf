provider "google" {
  credentials = file("tera.json")
  project     = "cogent-theater-412814"
  region      = "us-central1"
}

terraform {
  backend "gcs" {
    bucket  = "alb234"
    prefix  = "terraform/state"
  }
}

resource "google_compute_instance" "demo-instance" {
  name         = "demo-instance-3"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-arm64-v20240307b"
    }
  }

  // Specify the network interface configuration
  network_interface {
    network = "default"

    // Access configuration
    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/"]  # Adjust this to your IP range
}
