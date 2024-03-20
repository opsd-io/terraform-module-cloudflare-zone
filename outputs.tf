output "name_servers" {
  description = "A list of Cloudflare-assigned name servers."
  value = cloudflare_zone.main.name_servers
}
