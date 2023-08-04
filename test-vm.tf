 resource "google_compute_instance" "vm_instance" {
    name         = "test-linux-vm"
    machine_type = "f1-micro"
    tags = ["sonarqube"]
  
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
