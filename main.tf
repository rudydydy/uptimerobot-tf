terraform {
  required_providers {
    uptimerobot = {
      source = "bartekbp/uptimerobot"
      version = "0.10.0"
    }
  }
}

provider "uptimerobot" {
}

resource "uptimerobot_alert_contact" "alert" {
  for_each      = var.uptimerobot_alert_contacts
  friendly_name = each.value.friendly_name
  type          = lookup(each.value, "type", null)
  value         = each.value.value

  lifecycle {
    ignore_changes = [
      type
    ]
  }
}

resource "uptimerobot_monitor" "website" {
  for_each      = var.uptimerobot_monitors
  friendly_name = each.value.friendly_name
  type          = each.value.type
  url           = each.value.url
  interval      = each.value.interval

  dynamic "alert_contact" {
    for_each = each.value.alert_contacts
    content {
      id = uptimerobot_alert_contact.alert[alert_contact.value].id
    }
  }
  
  depends_on = [
    uptimerobot_alert_contact.alert
  ]
}

resource "uptimerobot_status_page" "status_page" {
  friendly_name  = var.status_page_name
  custom_domain  = var.status_page_custom_domain
  password       = var.status_page_password
  sort           = var.status_page_sort
  monitors       = [
    for m in uptimerobot_monitor.website : m.id
  ]
}
