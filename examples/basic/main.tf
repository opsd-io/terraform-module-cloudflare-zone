locals {
  # dns_zones = yamldecode(file("${path.cwd}/dns-zones.yml"))

  dns_zones = {
    "example1.io" = {
      dnssec = true
      records = [
        {
          name = "@",
          type : "A",
          content : ["137.184.146.102", "137.184.146.103"]
        },
        {
          name = "www",
          type : "CNAME",
          content : ["@"]
        }
      ]
    },
    "example2.io" = {
      records = [
        {
          name = "@",
          type : "A",
          content : ["137.184.146.102", "137.184.146.103"]
        },
        {
          name = "www",
          type : "CNAME",
          content : ["@"]
        },
        {
          name    = "dev",
          type    = "A",
          content = ["137.184.144.203"]
        },
        {
          name    = "@",
          type    = "TXT",
          content = ["v=spf1 include:_spf.google.com -all"]
        },
        {
          name = "@",
          type = "MX",
          content = [
            "alt1.aspmx.l.google.com",
            "alt2.aspmx.l.google.com"
          ],
          priority = 20
        },
        {
          name = "_sip._tls",
          type = "SRV",
          data = {
            service  = "_sip",
            proto    = "_tls"
            name     = "terraform-srv"
            priority = 0
            weight   = 0
            port     = 443
            target   = "example2.io"
          },
        },
      ]
    }
  }
}

module "example" {
  source = "github.com/opsd-io/terraform-module-cloudflare-zone"

  dns_zones             = local.dns_zones
  cloudflare_account_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
