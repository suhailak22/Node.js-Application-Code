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
  name         = "demo-instance-2"
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

// Enable the Network Management API
resource "google_project_service" "networkmanagement" {
  service = "networkmanagement.googleapis.com"
  project = "cogent-theater-412814"

  // Ensure that the API is enabled
  disable_on_destroy = false
}
