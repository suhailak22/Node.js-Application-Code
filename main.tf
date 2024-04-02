provider "google" {
  credentials = file("tera.json")
  project     = "cogent-theater-412814"
  region      = "us-central1"
}

terraform {
  backend "gcs" {
    bucket  = "terraform-12"
    prefix  = "terraform/state"
  }
}

resource "google_compute_instance" "demo-instance" {
  name         = "demo-instance-1"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-arm64-v20240307b"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "echo 'Hello, World!' > /var/www/html/index.html && sudo service apache2 restart"
}
