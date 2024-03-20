<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/opsd-io/terraform-module-template/main/.github/img/opsd-github-repo-dark-mode.svg">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/opsd-io/terraform-module-template/main/.github/img/opsd-github-repo-light-mode.svg">
  <img alt="OPSd - the unique and effortless way of managing cloud infrastructure." src="https://raw.githubusercontent.com/opsd-io/terraform-module-template/update-tools/.github/img/opsd-github-repo-light-mode.svg" width="400">
</picture>

Meet **OPSd**. The unique and effortless way of managing cloud infrastructure.

# terraform-module-cloudflare-zone

## Introduction

Terraform module to manage CloudFlare DNS zone resources.

## Usage

```hcl
module "example" {
  source = "github.com/opsd-io/terraform-module-cloudflare-zone"

  dns_zones             = local.dns_zones
  cloudflare_account_id = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```

**IMPORTANT**: Make sure not to pin to master because there may be breaking changes between releases.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 4.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 4.26.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_record.a](https://registry.terraform.io/providers/cloudflare/cloudflare/4.26.0/docs/resources/record) | resource |
| [cloudflare_record.cname](https://registry.terraform.io/providers/cloudflare/cloudflare/4.26.0/docs/resources/record) | resource |
| [cloudflare_record.mx](https://registry.terraform.io/providers/cloudflare/cloudflare/4.26.0/docs/resources/record) | resource |
| [cloudflare_record.srv](https://registry.terraform.io/providers/cloudflare/cloudflare/4.26.0/docs/resources/record) | resource |
| [cloudflare_record.txt](https://registry.terraform.io/providers/cloudflare/cloudflare/4.26.0/docs/resources/record) | resource |
| [cloudflare_zone.main](https://registry.terraform.io/providers/cloudflare/cloudflare/4.26.0/docs/resources/zone) | resource |
| [cloudflare_zone_dnssec.main](https://registry.terraform.io/providers/cloudflare/cloudflare/4.26.0/docs/resources/zone_dnssec) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_account_id"></a> [cloudflare\_account\_id](#input\_cloudflare\_account\_id) | CloudFlare account id | `string` | n/a | yes |
| <a name="input_dns_zones"></a> [dns\_zones](#input\_dns\_zones) | n/a | <pre>map(object({<br>    dnssec     = optional(bool, false)<br>    jump_start = optional(bool, false)<br>    paused     = optional(bool, false)<br>    records = list(object({<br>      name     = string<br>      type     = string<br>      content  = optional(list(string))<br>      data     = optional(map(string))<br>      priority = optional(number)<br>      proxied  = optional(bool)<br>      ttl      = optional(number)<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_plan"></a> [plan](#input\_plan) | CloudFlare commercial plan | `string` | `"free"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nameservers"></a> [nameservers](#output\_nameservers) | A list of Cloudflare-assigned name servers. |
<!-- END_TF_DOCS -->

## Examples of usage

Do you want to see how the module works? See all the [usage examples](examples).

## Related modules

The list of related modules (if present).

## Contributing

If you are interested in contributing to the project, see see our [guide](https://github.com/opsd-io/contribution).

## Support

If you have a problem with the module or want to propose a new feature, you can report it via the project's (Github) issue tracker.

If you want to discuss something in person, you can join our community on [Slack](https://join.slack.com/t/opsd-community/signup).

## License

[Apache License 2.0](LICENSE)
