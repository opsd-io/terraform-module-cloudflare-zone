variable "cloudflare_account_id" {
  description = "CloudFlare account id"
  type        = string
}

variable "plan" {
  description = "CloudFlare commercial plan"
  type        = string
  default     = "free"
}

variable "dns_zones" {
  description = ""
  type = map(object({
    dnssec     = optional(bool, false)
    jump_start = optional(bool, false)
    paused     = optional(bool, false)
    records = list(object({
      name     = string
      type     = string
      content  = optional(list(string))
      data     = optional(map(string))
      priority = optional(number)
      proxied  = optional(bool)
      ttl      = optional(number)
    }))
  }))
}
