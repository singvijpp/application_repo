resource "google_compute_instance" "wave3_java_app_windows_instance" {
  name         = "wave3-java-app-windows-instance"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "windows-10"
    }
  }
  network_interface {
    network = "default"
    }
  }
}
