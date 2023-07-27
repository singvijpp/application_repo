resource "google_compute_instance" "wave3_compute_linux_instance" {
  name         = "wave3-compute-linux-instance"
  machine_type = "n1-standard-1"
  zone      = "asia-south2-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = { my_label = "wave3-cicd" }
	}
	}
  attached_disk {
    source      = google_compute_disk.wave3_compute_linux_disk.id
    device_name = "extra-disk"
  }

  network_interface {
    network = "default"
    access_config {}
  }
 }
resource "google_compute_disk" "wave3_compute_linux_disk" {
  name  = "wave3-compute-linux-disk"
  type  = "pd-ssd"
  zone      = "asia-south2-a"
  size  = 8
}