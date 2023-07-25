resource "google_compute_instance" "vm_instance"{
	name = "ubuntu"
	machine_type = "e2-standard-2"
	
	boot_disk {
		initialize_params {
			image = "ubuntu-os-cloud/ubuntu-2204-lts"
		}
		
		type = "pd-standard"
		disk_encryption_key {
		raw_key = google_kms_crypto_key.key.id
    }
	}
	
	network_interface {
		network = "wave-3"
		subnetwork = "asia-south-1"
		access_config {
		
		}
	}
		
		
	metadata_startup_script = "echo hello world !! "
}

resource "google_compute_firewall" "http-server" {

	name = "default-allow-http-terraform"
	network = "wave-3"
	
	allow {
		protocol = "tcp"
		ports = ["22"]
	}

	source_ranges = ["0.0.0.0/0"]
}

