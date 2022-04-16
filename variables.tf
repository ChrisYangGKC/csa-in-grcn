/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "org_id" {
  description = "The organization id for the associated services"
  type        = string
}

/* variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
  type        = string
} */

variable "terraform_service_account" {
  description = "Service account email of the account to impersonate to run Terraform."
  type        = string
}

variable "default_region" {
  description = "Default region for BigQuery resources."
  type        = string
}

/* variable "audit_data_users" {
  description = "Google Workspace or Cloud Identity group that have access to audit logs."
  type        = string
} */

/* variable "domains_to_allow" {
  description = "The list of domains to allow users from in IAM. Used by Domain Restricted Sharing Organization Policy. Must include the domain of the organization you are deploying the foundation. To add other domains you must also grant access to these domains to the terraform service account used in the deploy."
  type        = list(string)
} */

variable "audit_logs_table_expiration_days" {
  description = "Period before tables expire for all audit logs in milliseconds. Default is 30 days."
  type        = number
  default     = 30
}

/* variable "scc_notification_name" {
  description = "Name of the Security Command Center Notification. It must be unique in the organization. Run `gcloud scc notifications describe <scc_notification_name> --organization=org_id` to check if it already exists."
  type        = string
}

variable "scc_notification_filter" {
  description = "Filter used to create the Security Command Center Notification, you can see more details on how to create filters in https://cloud.google.com/security-command-center/docs/how-to-api-filter-notifications#create-filter"
  type        = string
  default     = "state = \"ACTIVE\""
} */

variable "parent_folder" {
  description = "Optional - for an organization with existing projects or for development/validation. It will place all the example foundation resources under the provided folder instead of the root organization. The value is the numeric folder ID. The folder must already exist. Must be the same value used in previous step."
  type        = string
  default     = ""
}


/* 
variable "create_access_context_manager_access_policy" {
  description = "Whether to create access context manager access policy"
  type        = bool
  default     = true
} */

/* variable "data_access_logs_enabled" {
  description = "Enable Data Access logs of types DATA_READ, DATA_WRITE for all GCP services. Enabling Data Access logs might result in your organization being charged for the additional logs usage. See https://cloud.google.com/logging/docs/audit#data-access The ADMIN_READ logs are enabled by default."
  type        = bool
  default     = false
}



variable "gcp_audit_viewer" {
  description = "Members are part of an audit team and view audit logs in the logging project."
  type        = string
  default     = null
} */
/*********************
 * CSA demo variables
 *********************/

variable "log_folder" {
  description = "log folder for projects"
  type        = string
  default     = ""
}

variable "prod_folder" {
  description = "production folder for CSA monitoring"
  type        = string
  default     = ""
}

variable "test_folder" {
  description = "test/staging folder for CSA monitoring"
  type        = string
  default     = ""
}

variable "log_project_id" {
  description = "project with BQ datasets for CSA monitoring"
  type        = string
  default     = ""
}

variable "prod_project" {
  description = "prodcution project id for CSA monitoring demo"
  type        = string
  default     = ""
}

variable "prod_projects" {
  description = "list of prod project ids for CSA monitoring demo"
  type = list(string)
}

/* variable "test_project" {
  description = "test/dev project id for CSA monitoring demo"
  type        = string
  default     = ""
}

variable "test_projects" {
  type = list(string)
} */


/******************************
 * CSA demo BigQuery datasets
 ******************************/

variable "prod_dataset" {
  description = "BQ dataset in the logging project for prod logs"
  type        = string
  default     = ""
}

variable "test_dataset" {
  description = "BQ dataset in the logging project for test logs"
  type        = string
  default     = ""
}

variable "owner_prod_dataset" {
  description = "the identity of the owner for the BQ dataset in the logging project for prod logs"
  type        = string
  default     = ""
}

variable "owner_test_dataset" {
  description = "the identity of the owner for the BQ dataset in the logging project for test logs"
  type        = string
  default     = ""
}

variable "viewer_prod_dataset" {
  description = "the identity of the viewer for the BQ dataset in the logging project for prod logs - could be auditor group"
  type        = string
  default     = ""
}

variable "viewer_test_dataset" {
  description = "the identity of the viwer for the BQ dataset in the logging project for test logs - could be dev group"
  type        = string
  default     = ""
}