/* definition of the log filters for security analytics monitoring purpose */

locals {
  folder_prod_logs_filter     = <<EOF
    log_id("cloudaudit.googleapis.com/activity")
    OR log_id("cloudaudit.googleapis.com/policy")
    OR log_id("cloudaudit.googleapis.com/data_access")
    OR log_id("cloudaudit.googleapis.com/access_transparency")
    OR log_id("dns.googleapis.com/dns_queries")
    OR (log_id("compute.googleapis.com/nat_flows") AND resource.type="nat_gateway")
    OR (log_id("compute.googleapis.com/firewall") AND resource.type="gce_subnetwork")
    OR (log_id("compute.googleapis.com/vpc_flows") AND resource.type="gce_subnetwork")
    OR ((log_id("ids.googleapis.com/threat") OR log_id("ids.googleapis.com/traffic")) AND resource.type="ids.googleapis.com/Endpoint")
    OR (log_id("requests") AND resource.type="http_load_balancer")
    OR (log_id("syslog") AND resource.type="gce_instance")
    OR ((log_id("winevt.raw") OR log_id("windows_event_log")) AND resource.type="gce_instance")
    EOF
  all_logs_filter_default_folder      = ""
}


/* set up the log sinks and permissions for prod folder 
 * step 1: set up the log sinks 
 * step 2: set up the right permission for the logging services account in the related BigQuery datasets 
*/
resource "google_logging_folder_sink" "folder_prod_log_sink" {
    name        = "folder_prod_log_sink"
    description = "export the logs of prod folder and all projects into bigquery"
    destination = "bigquery.googleapis.com/projects/logging-blueprint/datasets/${google_bigquery_dataset.prod_dataset.dataset_id}"
    filter      = local.folder_prod_logs_filter
  
    folder     = var.prod_folder

    # include all the child folders and projects in this sink
    include_children = true

    # Whether or not to create a unique identity associated with this sink.
#    unique_writer_identity = true

    bigquery_options {
    # options associated with big query
    # Refer to the resource docs for more information on the options you can use
    use_partitioned_tables = true
  }
}

resource "google_bigquery_dataset_iam_member" "dataset_folder_prod" {
  dataset_id  = google_bigquery_dataset.prod_dataset.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = google_logging_folder_sink.folder_prod_log_sink.writer_identity
  project    = var.log_project_id 
}


/* set up the log sinks and permissions for test folder 
 * step 1: set up the log sinks 
 * step 2: set up the right permission for the logging services account in the related BigQuery datasets 
*/
/* resource "google_logging_folder_sink" "folder_test_log_sink" {
    name        = "folder_test_log_sink"
    description = "export the logs of test folder and all projects into bigquery"
    destination = "bigquery.googleapis.com/projects/logging-blueprint/datasets/${google_bigquery_dataset.test_dataset.dataset_id}"
    filter      = local.folder_prod_logs_filter //may need to define different log filters than the prod
  
    folder     = var.test_folder

    # include all the child folders and projects in this sink
    include_children = true

    # Whether or not to create a unique identity associated with this sink.
#    unique_writer_identity = true

    bigquery_options {
    # options associated with big query
    # Refer to the resource docs for more information on the options you can use
    use_partitioned_tables = true
  }
}

resource "google_bigquery_dataset_iam_member" "dataset_folder_test" {
  dataset_id  = google_bigquery_dataset.test_dataset.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = google_logging_folder_sink.folder_test_log_sink.writer_identity
  project    = var.log_project_id 
} */



/* resource "google_project_iam_member" "log_writer" {
    role = "roles/bigquery.dataEditor"
    member = google_logging_folder_sink.folder_log_sink.writer_identity
    project = "logging-blueprint"
} */


