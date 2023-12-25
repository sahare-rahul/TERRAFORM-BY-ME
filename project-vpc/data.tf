data "aws_availability_zones" "example" {
    state = "available"
  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}