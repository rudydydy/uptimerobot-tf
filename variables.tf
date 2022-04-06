variable uptimerobot_alert_contacts {
  description = "uptimerobot list of alert contacts"
  type        = map
  default     = {}
}

variable uptimerobot_monitors {
  description = "uptimerobot list of monitors"
  type        = map
  default     = {}
}

variable status_page_name {
  description = "name for your status page"
  type        = string
}

variable status_page_custom_domain {
  description = "custom domain for your status page"
  type        = string
}

variable status_page_password {
  description = "password for your status page"
  type        = string
}

variable status_page_sort {
  description = "sorting by list of monitors"
  type        = string
}
