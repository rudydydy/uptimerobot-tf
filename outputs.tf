output monitor_with_alert_contacts {
  description = "Map of monitor and it's alert contacts"
  value       = {
    for v in var.uptimerobot_monitors :
    v.friendly_name => v.alert_contacts 
  }
}
