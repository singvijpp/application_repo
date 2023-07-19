resource "google_compute_instance" "vm_instance"{
	name = "Ubuntu"
	region = "asia-south1"
	zone = "asia-south1-c"
	
	boot_disk {
		initalize_param {
			image = "Ubuntu"
		}
	}
	
	network_interface {
		networ = "default"
		
		access_config {
		
		}
	}
		
		
	metadata_startup_script = "echo hello world !! "
}

resource "google_compute_firewall" "http-server" {
	name = "default allow http terraform"
	network = "default"
	
	allow {
		protocol = "tcp"
		ports = ["80"]
	}

	source_ranges = ["0.0.0.0/0"]
	target_ranges = ["http-server"]
}

