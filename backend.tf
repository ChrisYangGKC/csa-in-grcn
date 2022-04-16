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

/* The Google Cloud Storage (GCS) backet here to storage the terraform run time artifacts
 * The service account "terraform_service_account" must have the following permissions to fulfill the minimum requirements
 * storage.buckets.create
 * storage.buckets.list
 * storage.objects.get
 * storage.objects.create
 * storage.objects.delete
 * storage.objects.update 
 * You can set up a custom role for this purpose. The pre-defined role with the least possible privileges to perform this purpose would be Storage Admin (roles/storage.admin). 
 
*/


terraform {
  backend "gcs" {
    bucket = "name-of-your-bucket-for-terraform"
    prefix = "terraform/org/state"
  }
}
