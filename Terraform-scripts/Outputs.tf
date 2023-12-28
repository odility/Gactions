output "cluster_endpoint" {
  value       = google_container_cluster.my_cluster.endpoint
  description = "The endpoint for the GKE cluster"
}

output "cluster_master_version" {
  value       = google_container_cluster.my_cluster.master_version
  description = "The version of the GKE master"
}
