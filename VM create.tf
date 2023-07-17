resource "google_compute_instance" "VM_Test" {
  name         = "VMtest"
  machine_type = "e2-medium"
  zone         = "asia-south2-a"

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
