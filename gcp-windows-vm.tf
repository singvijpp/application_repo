resource "google_compute_instance" "vm_instance" {
    name         = "gcpwave3-windows-vm"
    machine_type = "n1-standard-1"
    
    boot_disk {
      initialize_params {
        image = "windows-10"
      }
    }    
    network_interface {
      network = "wave-3"
      subnetwork = "asia-south-1"
    access_config {}
  }
  }
