output "nameservers" {
  description = "A list of Cloudflare-assigned name servers."
  value = {
    for k, v in cloudflare_zone.main : k => v.name_servers
  }
}
