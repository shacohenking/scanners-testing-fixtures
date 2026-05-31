# IAC scanner testing fixture - GCP Terraform with known misconfigurations

# CKV_GCP_29 - Bucket does not have uniform bucket-level access enabled
# CKV_GCP_62 - Bucket does not have access logging configured
# CKV_GCP_78 - Bucket does not have versioning enabled
# CKV_GCP_114 - Bucket does not have public access prevention enforced
resource "google_storage_bucket" "insecure_public_bucket" {
  name                        = "insecure-public-bucket"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = false
  public_access_prevention    = "inherited"
}

# CKV_GCP_28 - Bucket is publicly accessible to allUsers
resource "google_storage_bucket_iam_member" "public_read" {
  bucket = google_storage_bucket.insecure_public_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Hardcoded service-account key path (also triggers secrets scanner)
# CKV_GCP_49 - Service account user role assigned at project level
resource "google_project_iam_member" "overly_permissive_sa" {
  project = "my-test-project"
  role    = "roles/owner"
  member  = "serviceAccount:insecure-sa@my-test-project.iam.gserviceaccount.com"
}
