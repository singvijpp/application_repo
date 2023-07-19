resource "google_compute_instance" "vm_instance" {
  name		= "gcp-wave3-vm"
  machine_type	= "f1-micro"
  region	= "us-central1"

  boot_disk {
    initialize_params {
	image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
   }
}
