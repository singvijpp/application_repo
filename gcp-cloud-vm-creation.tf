/*provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-south1"
  zone        ="asia-south1-a"
}
resource "google_compute_instance" "vm_instance" {
    name         = "gcpwave3-vm"
    machine_type = "f1-micro"
  
    boot_disk {
      initialize_params {
        image = "centos-cloud/centos-7"
      }
    }    
    network_interface {       
      network = "terraform-network"
    }
  }*/