variable "cloudflare_account_id" {
  description = "CloudFlare account id."
  type        = string
}

variable "zone_name" {
  description = "The zone name."
  type        = string
}

variable "plan" {
  description = "CloudFlare commercial plan."
  type        = string
  default     = "free"
}

variable "jump_start" {
  description = "Whether to scan for DNS records on creation. Ignored after zone is created."
  type        = bool
  default     = false
}

variable "paused" {
  description = "Whether this zone is paused (traffic bypasses Cloudflare)."
  type        = bool
  default     = false
}

variable "dnssec" {
  description = "Whether DNSSEC is enabled."
  type        = bool
  default     = false
}

variable "records" {
  description = "A list of DNS zone records."
  type = list(object({
    name     = string
    type     = string
    content  = optional(list(string))
    data     = optional(map(string))
    priority = optional(number)
    proxied  = optional(bool)
    ttl      = optional(number)
  }))
}
