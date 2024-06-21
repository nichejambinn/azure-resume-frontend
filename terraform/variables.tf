variable "default_tags" {
  default = {
    Environment = "DEV"
    Owner       = "nichejambinn"
    Project     = "Resume"
  }
  description = "Default Tags for Resume"
  type        = map(string)
}
