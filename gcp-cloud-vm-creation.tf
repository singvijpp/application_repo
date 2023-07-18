 provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-south1"
  zone        ="asia-south1-a"
}
resource "google_compute_instance" "vm_instance" {
    name         = "gcptutorials-vm"
    machine_type = "f1-micro"
  
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