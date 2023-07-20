provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-south2"
  zone        ="asia-south2-a"
}
resource "google_compute_instance" "vm_instance" {
    name         = "gcpwave3-windows-vm"
    machine_type = "n1-standard-1"
    
    boot_disk {
      initialize_params {
        image = "windows-cloud/windows-2019"
      }
    }    
    network_interface {
      network = "wave-3"
      subnetwork = "asia-south-1"
    access_config {}
  }
  }
