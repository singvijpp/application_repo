provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-south1"
  zone        ="asia-south1-a"
}
/*resource "google_compute_firewall" "firewall" {
  name    = "firewall-externalssh"
  network = "terraform-network"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
source_ranges = ["0.0.0.0/0"] 
  target_tags   = ["externalssh"]
}*/
resource "google_compute_instance" "vm_instance" {
    name         = "gcpwave3-linux-vm"
    machine_type = "f1-micro"
  
    boot_disk {
      initialize_params {
        image = "centos-cloud/centos-7"
      }
    }    
    network_interface {
    network = "terraform-network"
    access_config {}
  }
depends_on = [ google_compute_firewall.firewall ]
  }
