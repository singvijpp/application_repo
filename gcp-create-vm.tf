resource "google_compute_instance" "default" {
  name		= "gcp-wave3-vm"
  machine_type	= "f1-micro"
  zone         = "asia-south2-a"
  boot_disk {
    initialize_params {
	image = "debian-cloud/debian-11"
    }
  }

   network_interface {
    network = "wave-3"
    subnetwork = "asia-south-1"
    access_config {
    
    }
    
  }
}

