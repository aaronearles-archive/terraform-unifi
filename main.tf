terraform {
  required_providers {
    unifi = {
      source = "paultyng/unifi"
    }
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

resource "unifi_static_route" "blackhole" {
  type     = "blackhole"
  network  = var.blackhole_cidr
  name     = "blackhole traffice to cidr"
  distance = 1
}
