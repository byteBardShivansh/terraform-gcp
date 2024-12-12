variable "nested_map1" {
  default = {
    db = {
      name     = "app_db"
      username = "admin"
    }
  }
}
variable "nested_map2" {
  default = {
    db = {
      username = "user"
      password = "securepassword"
    }
  }
}