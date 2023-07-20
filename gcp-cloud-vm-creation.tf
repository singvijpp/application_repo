provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-south1"
  zone        ="asia-south1-a"
}
/*resource "google_compute_firewall" "wave3-firewall" {
  name    = "firewall-externalssh-wave3"
  network = "terraform-network"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
source_ranges = ["0.0.0.0/0"] 
  target_tags   = ["externalssh-wave3"]
}*/
resource "google_compute_firewall" "allow-ssh" {
  name = "fw-allow-ssh"
  network = "wave-3"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}
resource "google_compute_instance" "vm_instance" {
    name         = "gcpwave3-linux-vm"
    machine_type = "f1-micro"
  
    boot_disk {
      initialize_params {
        image = "centos-cloud/centos-7"
      }
    }    
    network_interface {
    network = "wave-3"
    subnetwork = "asia-south-1"
    access_config {}
  }
  }
