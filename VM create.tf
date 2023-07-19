resource "google_compute_instance" "KMSVM" {
  name         = "KMS-VM"
  machine_type = "e2-medium"
  zone         = "asia-south2-a"

boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
 network_interface {
    network = "default" // This enable Private Internal IP  
    access_config {} // This enable Ephemeral public IP  
  }
}
