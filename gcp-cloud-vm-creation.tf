/*provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-south2"
  zone        ="asia-south2-a"
}*/
/*resource "google_compute_firewall" "wave3-firewall" {
  name    = "firewall-externalssh-wave3"
  network = "terraform-network"
  allow {
    protocol = "ssh"
    ports    = ["22"]
  }
source_ranges = ["0.0.0.0/0"] 
  target_tags   = ["externalssh-wave3"]
}*/
/*resource "google_compute_firewall" "allow-ssh" {
  name = "allow-ssh"
  network = "wave-3"
  allow {
    protocol = "ssh"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["gcpwave3-linux-vm"]
}*/
/*resource "google_compute_instance" "vm_instance" {
    name         = "gcpwave3-linux-vm"
    machine_type = "f1-micro"
    tags = ["ssh"]
  
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
  }*/
