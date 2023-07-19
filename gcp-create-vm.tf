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
    network = "default"
    subnetwork = "custom"
    access_config {
    nat_ip = google_compute_address.static.address
    }
   }
}
resource "google_compute_address" "static" {
  name = "vm-public-address"
  project = "db-cicdpipeline-wave3"
  region = "us-central1-a"
  
}
