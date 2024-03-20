terraform {
  required_version = ">= 1.5.7"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.26.0"
    }
  }
}

locals {
  records = flatten([
    for zone_id, zone in var.dns_zones : [
      for record in zone.records : [
        for value in record.content : {
          zone_id  = zone_id
          name     = record.name
          content  = value
          type     = record.type
          priority = try(record.priority, "")
        }
      ] if record.content != null
    ]
  ])

  data_records = flatten([
    for zone_id, zone in var.dns_zones : [
      for record in zone.records : [
        {
          zone_id  = zone_id
          name     = record.name
          type     = record.type
          priority = try(record.priority, "")

          data = {
            service  = try(record.data.service, "")
            proto    = try(record.data.proto, "")
            name     = try(record.data.name, "")
            priority = try(record.data.priority, "")
            weight   = try(record.data.weight, "")
            port     = try(record.data.port, "")
            target   = try(record.data.target, "")
          }
        }
      ] if record.data != null
    ]
  ])
}

resource "cloudflare_zone" "main" {
  for_each = var.dns_zones

  account_id = var.cloudflare_account_id
  zone       = each.key
  jump_start = each.value.jump_start
  paused     = each.value.paused
  plan       = var.plan
}

resource "cloudflare_zone_dnssec" "main" {
  for_each = {
    for zone_id, zone in var.dns_zones : zone_id => zone
    if zone.dnssec == true
  }

  zone_id = cloudflare_zone.main[each.key].id
}

resource "cloudflare_record" "a" {
  for_each = {
    for record in local.records : "${record.zone_id}.${record.name}.${record.content}" => record
    if record.type == "A"
  }

  zone_id  = cloudflare_zone.main[each.value.zone_id].id
  name     = each.value.name
  value    = each.value.content
  type     = "A"
  priority = try(each.value.priority, null)
  proxied  = try(each.value.proxied, true)
  ttl      = try(each.value.ttl, null)
}

resource "cloudflare_record" "cname" {
  for_each = {
    for record in local.records : "${record.zone_id}.${record.name}.${record.content}" => record
    if record.type == "CNAME"
  }

  zone_id  = cloudflare_zone.main[each.value.zone_id].id
  name     = each.value.name
  value    = each.value.content
  type     = "CNAME"
  priority = try(each.value.priority, null)
  proxied  = try(each.value.proxied, true)
  ttl      = try(each.value.ttl, null)
}

resource "cloudflare_record" "mx" {
  for_each = {
    for record in local.records : "${record.zone_id}.${record.name}.${record.content}" => record
    if record.type == "MX"
  }

  zone_id  = cloudflare_zone.main[each.value.zone_id].id
  name     = each.value.name
  value    = each.value.content
  type     = "MX"
  priority = try(each.value.priority, null)
  proxied  = try(each.value.proxied, null)
  ttl      = try(each.value.ttl, null)
}

resource "cloudflare_record" "txt" {
  for_each = {
    for record in local.records : "${record.zone_id}.${record.name}.${record.content}" => record
    if record.type == "TXT"
  }

  zone_id  = cloudflare_zone.main[each.value.zone_id].id
  name     = each.value.name
  value    = each.value.content
  type     = "TXT"
  priority = try(each.value.priority, null)
  proxied  = try(each.value.proxied, null)
  ttl      = try(each.value.ttl, null)
}

resource "cloudflare_record" "srv" {
  for_each = {
    for record in local.data_records : "${record.zone_id}.${record.name}" => record
    if record.type == "SRV"
  }

  zone_id  = cloudflare_zone.main[each.value.zone_id].id
  name     = each.value.name
  type     = "SRV"
  priority = try(each.value.priority, null)
  proxied  = try(each.value.proxied, null)
  ttl      = try(each.value.ttl, null)

  data {
    service  = try(each.value.data.service, "")
    proto    = try(each.value.data.proto, "")
    name     = try(each.value.data.name, "")
    priority = try(each.value.data.priority, "")
    weight   = try(each.value.data.weight, "")
    port     = try(each.value.data.port, "")
    target   = try(each.value.data.target, "")
  }
}
