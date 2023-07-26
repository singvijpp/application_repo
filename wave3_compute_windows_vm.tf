/*resource "google_compute_instance" "wave3_compute_windows_instance" {
  name         = "wave3-compute-windows-instance"
  machine_type = "n1-standard-1"
  zone      = "asia-south2-a"


  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2012-r2"
      labels = {
        my_label = "wave3-cicd"
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
}
resource "google_compute_disk" "wave3_compute_windows_disk" {
  name  = "wave3-compute-windows-disk"
  type  = "pd-ssd"
  zone      = "asia-south2-a"
   size  = 8
}*/