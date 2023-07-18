provider "google" {
  project     = "db-cicdpipeline-wave3"
  region      = "asia-south1"
  zone        ="asia-south1-a"
}
resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}
resource "google_compute_instance" "vm_instance" {
name = "terraform-instance2"
machine_type = "f1-micro"
zone = "us-central1-c"
boot_disk {
initialize_params {
image = "centos-cloud/centos-7"
}
}
 network_interface {
    network = google_compute_network.vpc_network.self.link
    access_config {
    }
  }
}
