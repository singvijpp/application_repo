resource "google_compute_instance" "wave3_compute_windows_instance" {
  name         = "wave3-compute-windows-instance"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "windows-10"
    }
  }

  attached_disk {
    source      = google_compute_disk.wave3_compute_windows_disk.id
    device_name = "extra-disk"
	  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_compute_disk" "wave3_compute_windows_disk" {
  name  = "wave3-compute-windows-disk"
  type  = "pd-ssd"
   size  = 8
}