/* Set up the BigQuery datasets for the logs from prodcution */

resource "google_bigquery_dataset" "prod_dataset" {
        dataset_id                  = var.prod_dataset
        friendly_name               = "csa_prod"
        description                 = "the datasets with logs from prod envirnoment + org level audit/data-access"
        location                    = "US"
        project                     = var.log_project_id

        labels = {
            env = "prod_csa"
        }

        access {
            role          = "OWNER"
            user_by_email = var.owner_prod_dataset
        }

        access {
            role   = "READER"
            group_by_email = var.viewer_prod_dataset
        }
    }

/* Set up the BigQuery datasets for the logs from test/dev environment */
resource "google_bigquery_dataset" "test_dataset" {
        dataset_id                  = var.test_dataset
        friendly_name               = "csa_test"
        description                 = "the datasets with logs from test envirnoment"
        location                    = "US"
        project                     = var.log_project_id

        labels = {
            env = "test_csa"
        }

        access {
            role          = "OWNER"
            user_by_email = var.owner_test_dataset
        }

        access {
            role   = "READER"
            group_by_email = var.viewer_test_dataset
        }
    }


