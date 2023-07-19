resource "google_compute_instance" "default" {
  name		= "gcp-wave3-vm"
  machine_type	= "f1-micro"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
	image = "debian-cloud/debian-11"
    }
  }

   network_interface {
    network = "terraform-network"
    subnet_mode = "AUTO"
    access_config {
    }
   }
}

