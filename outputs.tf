output "active_api_key" {
    value       = confluent_api_key.resouce_api_key[local.latest_api_key]
    description = ""
}

output "all_api_keys" {
    value       = [for d in local.sorted_dates : confluent_api_key.resouce_api_key[lookup(local.dates_and_count, d)]]
    description = "All API keys sorted by creation date.  With the current active API Key being the 1st in the collection."
}