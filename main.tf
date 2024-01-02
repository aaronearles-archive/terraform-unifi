terraform {
  required_providers {
    unifi = {
      source = "paultyng/unifi"
    }
    # random = {
    #   source = "hashicorp/random"
    #   version = "3.5.1"
    # }
    # http = {
    #   source = "hashicorp/http"
    #   version = "3.3.0"
    # }
  }
  # backend "azurerm" {
  #   resource_group_name = "tfstateRG01"
  #   storage_account_name = "tfstate01895424281"
  #   container_name = "tfstate"
  #   key = "terraform-demo_modules.tfstate"
  # }
}


provider "unifi" {
  username = var.username # optionally use UNIFI_USERNAME env var
  password = var.password # optionally use UNIFI_PASSWORD env var
  api_url  = var.api_url  # optionally use UNIFI_API env var

  # you may need to allow insecure TLS communications unless you have configured
  # certificates for your controller
  allow_insecure = var.insecure # optionally use UNIFI_INSECURE env var

  # if you are not configuring the default site, you can change the site
  # site = "foo" or optionally use UNIFI_SITE env var
}

##### STATIC ROUTE #####

 resource "unifi_static_route" "blackhole" {
   type     = "blackhole"
   network  = var.blackhole_cidr
   name     = "blackhole traffice to cidr"
   distance = 1
 }

##### WLAN #####

variable "vlan_id" {
  default = 1
}

#retrieve network data by unifi network name
data "unifi_network" "vlan" {
  name = "Default"
}

data "unifi_ap_group" "default" {
}

data "unifi_user_group" "default" {
}

resource "unifi_wlan" "test" {
  name       = "test"
  passphrase = "87654321"
  security   = "wpapsk"

 # enable WPA2/WPA3 support
  wpa3_support    = true
  wpa3_transition = true
  pmf_mode        = "optional"

  network_id    = data.unifi_network.vlan.id
  ap_group_ids  = [data.unifi_ap_group.default.id]
  user_group_id = data.unifi_user_group.default.id
}
