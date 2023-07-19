resource "google_compute_instance" "vm_instance" {
  name		= "gcp-wave3-vm"
  machine_type	= "f1-micro"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
	image = "debian-cloud/debian-11"
    }
  }

   network_interface {
    network = "wave-3"
    access_config {
    }
   }
}

