output "nameservers" {
  value = {
    for k, v in cloudflare_zone.main : k => v.name_servers
  }
}
