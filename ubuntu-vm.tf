resource "google_compute_instance" "vm_instance"{
	name = "ubuntu"
	machine_type = "e2-standard-2"
	zone = "asia-south1-c"
	
	boot_disk {
		initialize_params {
			image = "Ubuntu"
		}
	}
	
	network_interface {
		network = "default"
		
		access_config {
		
		}
	}
		
		
	metadata_startup_script = "echo hello world !! "
}

resource "google_compute_firewall" "http-server" {
	name = "default-allow-http-terraform"
	network = "default"
	
	allow {
		protocol = "tcp"
		ports = ["80"]
	}

	source_ranges = ["0.0.0.0/0"]
}

