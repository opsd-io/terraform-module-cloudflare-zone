locals {
  records = yamldecode(file("${path.cwd}/example.io-records.yml"))
}

module "example" {
  source = "github.com/opsd-io/terraform-module-cloudflare-zone"

  zone_name             = "example.io"
  records               = local.records
  cloudflare_account_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
