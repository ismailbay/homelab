terraform {

  cloud {
    organization = "ismailbay"

    workspaces {
      name = "cloudflare-provisioner"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.1.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.2.1"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }
  }
}

data "sops_file" "cloudflare_secrets" {
  source_file = "secret.sops.yaml"
}

provider "cloudflare" {
  email   = data.sops_file.cloudflare_secrets.data["cloudflare_email"]
  api_key = data.sops_file.cloudflare_secrets.data["cloudflare_apikey"]
}

data "cloudflare_zones" "domain" {
  filter {
    status = "active"
  }
}

resource "cloudflare_zone_settings_override" "cloudflare_settings" {
  for_each = { for k, v in data.cloudflare_zones.domain.zones : v.name => v }
  zone_id  = each.value.id
  settings {
    ssl                      = "strict"
    always_use_https         = "on"
    min_tls_version          = "1.2"
    opportunistic_encryption = "on"
    tls_1_3                  = "zrt"
    automatic_https_rewrites = "on"
    universal_ssl            = "on"
    browser_check            = "on"
    challenge_ttl            = 1800
    privacy_pass             = "on"
    security_level           = "medium"
    brotli                   = "on"
    minify {
      css  = "on"
      js   = "on"
      html = "on"
    }
    rocket_loader       = "on"
    always_online       = "off"
    development_mode    = "off"
    http3               = "on"
    zero_rtt            = "on"
    ipv6                = "on"
    websockets          = "on"
    opportunistic_onion = "on"
    pseudo_ipv4         = "off"
    ip_geolocation      = "on"
    email_obfuscation   = "on"
    server_side_exclude = "on"
    hotlink_protection  = "off"
    security_header {
      enabled = false
    }
  }
}

data "http" "ipv4" {
  url = "http://ipv4.icanhazip.com"
}

resource "cloudflare_record" "ipv4" {
  for_each = { for k, v in data.cloudflare_zones.domain.zones : v.name => v }
  name     = "ipv4"
  zone_id  = each.value.id
  value    = chomp(data.http.ipv4.response_body)
  proxied  = true
  type     = "A"
  ttl      = 1
}

resource "cloudflare_record" "root" {
  for_each = { for k, v in data.cloudflare_zones.domain.zones : v.name => v }
  name     = each.key
  zone_id  = each.value.id
  value    = "ipv4.${each.key}"
  proxied  = true
  type     = "CNAME"
  ttl      = 1
}
