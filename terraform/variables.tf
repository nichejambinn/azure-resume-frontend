variable "default_tags" {
  default = {
    Environment = "dev"
    Owner       = "nichejambinn"
    Project     = "resume frontend"
  }
  description = "default tags for resume"
  type        = map(string)
}
