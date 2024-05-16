#random_id
resource "random_id" "random_id" {
  byte_length = 4
}

locals {
  version = "1.0.0"
}

locals {
  local_tags = random_id.random_id.hex
}

module "ec2" {
source = "./ec2" 
random_id = local.local_tags
cidr_block_value = var.cidr_block_value
pub_sub_cidr_value= var.pub_sub_cidr_value
availability_zone_value= var.availability_zone_value
ami_id_value= var.ami_id_value
key_pair_value= var.key_pair_value
instance_type = var.instance_type
}

module "s3" {
  source = "./s3"
  random_id = local.local_tags
}