resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "n1-micro"
  zone         = "asia-south1"

boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }
 network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}
