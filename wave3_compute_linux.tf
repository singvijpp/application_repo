resource "google_compute_instance" "wave3_compute_linux_instance" {
  name         = "wave3-compute-linux-instance"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "ubuntu-latest"
    }
  }

  attached_disk {
    source      = google_compute_disk.wave3_compute_linux_disk.id
    device_name = "extra-disk"
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_compute_disk" "wave3_compute_linux_disk" {
  name  = "wave3-compute-linux-disk"
  type  = "pd-ssd"
  location = "asia-south2"
  size  = 8
}