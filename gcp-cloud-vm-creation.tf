/*resource "google_compute_firewall" "allow-ssh" {
  name = "allow-ssh"
  network = "wave-3"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
disabled        = false
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["gcpwave3-linux-vm"]
}
 resource "google_compute_instance" "vm_instance" {
    name         = "sonarqube-linux-vm"
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
  }*/
