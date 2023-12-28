provider "google" {
  credentials = file("path/to/your/credentials.json")
  project     = "core-era-359304"
  region      = "us-central1"
}

resource "google_container_cluster" "my_cluster" {
  name     = "my-wafi-gke-cluster"
  location = "us-central1"

  remove_default_node_pool = true

  node_pool {
    name       = "pool-1"
    initial_node_count = 3
    min_count = 1
    max_count = 5
    machine_type = "n2-standard-4"
    disk_size_gb = 100

    node_config {
      preemptible  = true
      oauth_scopes = [
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
      ]
    }
  }

  network {
    subnetwork = "custom-subnet"
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "01:00"
    }
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }

    http_load_balancing {
      disabled = false
    }
  }

  master_authorized_network_cidr_blocks = ["0.0.0.0/0"]  # Restrict based on your needs

  master_authorized_network {
    cidr_blocks = ["10.0.10.0/24"]  # Assuming this is our trusted CIDR block
  }
}
