output "merged_nested_map" {
  value = merge(var.nested_map1, var.nested_map2)
}