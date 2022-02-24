#############################################################################
# © Copyright IBM Corp. 2021, 2021

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#############################################################################

##############################################################################
# Account Variables
##############################################################################

variable "ibmcloud_api_key" {
    description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
    type        = string
    sensitive   = true
}

variable "ibmcloud_account_id" {
    description = "The IBM Cloud account id needed to create a hosting connection from Citrix."
    type        = string
}

variable "ibmcloud_ssh_key_name" {
    description = "The IBM Cloud platform SSH key name used to deploy CVAD instances"
    type        = string
}

variable "resource_group" {
    description = "The IBM resource group name to be associated with this IBM Cloud VPC CVAD deployment"
    type        = string
}


variable "personal_access_token" {
  description = "Personal access token used to get plugin installer from ghe."
  type        = string
  sensitive   = true
  default     = ""
}

variable "citrix_customer_id" {
    description = "The Citrix Cloud customer id needed to connect to Citrix"
    type        = string
}

variable "citrix_api_key_client_id" {
    description = "The Citrix Cloud API key client id needed to connect to Citrix"
    type        = string
    sensitive   = true
}

variable "citrix_api_key_client_secret" {
    description = "The Citrix Cloud API key client secret needed to connect to Citrix"
    type        = string
    sensitive   = true
}

variable "resource_location_names" {
    description = "The Citrix resource location name to be associated with this IBM Cloud VPC CVAD deployment"
    type        = list(string)
    validation {
        condition = length(var.resource_location_names) >= 1
        error_message = "There should at be least one resource location name specified."
    }
}

variable "region" {
    description = "IBM Cloud region where all resources will be deployed"
    type        = string

    validation  {
      error_message = "Must use an IBM Cloud region. Use `ibmcloud regions` with the IBM Cloud CLI to see valid regions."
      condition     = can(
        contains([
          "au-syd",
          "jp-tok",
          "eu-de",
          "eu-gb",
          "us-south",
          "us-east"
        ], var.region)
      )
    }
}

variable "zones" {
  type        = list(string)
  description = "IBM Cloud zone name within the selected region where the CVAD infrastructure should be deployed. [Learn more](https://cloud.ibm.com/docs/vpc?topic=vpc-creating-a-vpc-in-a-different-region#get-zones-using-the-cli)"

  validation {
    condition = length(var.zones) >= 1
    error_message = "There should be at least one zone specified."
  }
}

variable "connector_per_zone" {
    type        = number
    description = "Number of connector instances per zone"
    default     = 2
    validation {
      condition     = var.connector_per_zone >= 1 && var.connector_per_zone <=5
      error_message = "Depth must be between 1 and 5."
    }
}

variable "basename" {
    description = "Basename of the created resource"
    type        = string
    default     = "cvad"
}

variable "active_directory_domain_name" {
    description = "Active Directory domain name"
    type        = string
}

variable "active_directory_vsi_name" {
    description = "Appended name of the created VSI"
    type        = string
    default     = "ad"
}

variable "active_directory_safe_mode_password" {
    description = "Safe mode password for the Active Directory administrator account."
    type        = string
    sensitive   = true
}

variable "active_directory_topology" {
    description = "There are two topologies named IBM Cloud and Extended supported currently"
    type        = string
    default     = "IBM Cloud"

    validation  {
      error_message = "IBM Cloud and Extended are the only supported Active Directory topologies."
      condition     = contains(["IBM Cloud", "Extended"], var.active_directory_topology)
    }
}

variable "deploy_custom_image_vsi" {
    description = "Deploy VSI for creating a custom image to be used for master image when set to true"
    type        = bool
    default     = false
}

variable "control_plane_profile" {
    description = "Profile to use for creating Active Directory and Cloud Connector VSIs"
    type        = string
    default     = "cx2-4x8"
}

variable "custom_image_vsi_profile" {
    description = "Profile to use for creating custom image VSI"
    type        = string
    default     = "cx2-4x8"
}

variable "vpc_name" {
    description = "Use an existing VPC to deploy Citrix Virtual Apps and Desktops on."
    type        = string
    default     = ""
}

variable "plugin_download_url" {
    description = "Used by Cloud Connector setup to download IBM Cloud VPC plugin."
    type        = string
    default     = "https://api.github.com/repos/IBM-Cloud/citrix-virtual-apps-and-desktops"
}
