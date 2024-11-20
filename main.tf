provider "google" {
  project = "micro-environs-442313-i6"  # Replace with your GCP project ID
  region  = "us-central1"      # Replace with your preferred region
}

resource "google_compute_instance" "vm_instance" {
  name         = "example-instance"
  machine_type = "e2-micro"          # Replace with your desired machine type
  zone         = "us-central1-a"    # Replace with your preferred zone

  # Boot Disk Configuration
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"  # Replace with your desired image
      size  = 10                        # Disk size in GB
    }
  }

  # Network Interface Configuration
  network_interface {
    network = "default"  # Use the default network
    access_config {}     # Add an external IP
  }

  # Metadata for instance
  metadata = {
    ssh-keys = "username:ssh-rsa your-ssh-public-key"  # Replace with your public SSH key
  }

  tags = ["http-server", "https-server"]  # Add firewall rules if needed
}

# Firewall Rule to Allow HTTP and HTTPS
resource "google_compute_firewall" "default" {
  name    = "default-allow-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allow traffic from all IPs
  target_tags   = ["http-server", "https-server"]
}