resource "google_compute_instance" "wave3_java_app_windows_instance" {
  name         = "wave3-java-app-windows-instance"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "windows-10"
    }
  }
  metadata_startup_script = <<-EOT
    #!/bin/bash
    git clone https://github.com/shashirajraja/onlinebookstore.git
    cd onlinebookstore
    # Add additional commands for building and deploying the Java application
  
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
  network_interface {
    network = "default"
    }
  metadata_startup_script = file("java-startup-script.ps1")
}
