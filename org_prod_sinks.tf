
locals {
  org_prod_logs_filter     = <<EOF
    log_id(\"cloudaudit.googleapis.com/activity\") OR 
    log_id(\"cloudaudit.googleapis.com/policy\") OR 
    log_id(\"cloudaudit.googleapis.com/data_access\") OR 
    log_id(\"cloudaudit.googleapis.com/access_transparency\")
    EOF
  all_logs_filter_defaulti_org      = ""
}


/* set up the log sinks and permissions for org level only 
 * step 1: set up the log sinks 
 * step 2: set up the right permission for the logging services account in the related BigQuery datasets 
*/

resource "google_logging_organization_sink" "org_log_sink_prod" {
    name        = "org_log_sink_prod"
    description = "sink the org level orgs into "
    destination = "bigquery.googleapis.com/projects/logging-blueprint/datasets/${google_bigquery_dataset.prod_dataset.dataset_id}"
    filter      = local.org_prod_logs_filter
     
    org_id     = var.org_id
    include_children = false

    # Whether or not to create a unique identity associated with this sink.
#    unique_writer_identity = true

    bigquery_options {
    # options associated with big query
    # Refer to the resource docs for more information on the options you can use
    use_partitioned_tables = true
  }
}



resource "google_bigquery_dataset_iam_member" "dataset_org_prod" {
  dataset_id  = google_bigquery_dataset.prod_dataset.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = google_logging_organization_sink.org_log_sink_prod.writer_identity 
  project    = var.log_project_id
}



// resource "google_project_iam_member" "log_writer_ord_prod" {
//    role = "roles/bigquery.dataEditor"
//    member = google_logging_folder_sink.org_log_sink_prod.writer_identity
//    project = "logging-blueprint"
//}


