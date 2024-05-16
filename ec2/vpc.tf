resource "aws_vpc" "practice_vpc" {
  cidr_block = var.cidr_block_value
  tags = {
    Name = "tf-demo-${var.random_id}"
  }
}

resource "aws_subnet" "tf-pub-sub" {
  vpc_id = aws_vpc.practice_vpc.id
  cidr_block = var.pub_sub_cidr_value
  availability_zone = var.availability_zone_value
  map_public_ip_on_launch = "true"
  tags = {
    Name = "tf-pub-sub-${var.random_id}"
  }
}

resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.practice_vpc.id
  tags = {
    Name = "tf-igw-${var.random_id}"
  }
}

resource "aws_route_table" "tf-pub-rt" {
  tags = {
    Name = "tf-pub-rt-${var.random_id}"
  }
  vpc_id = aws_vpc.practice_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-igw.id
  }
}

resource "aws_route_table_association" "tf-rt-association" {
  subnet_id = aws_subnet.tf-pub-sub.id
  route_table_id = aws_route_table.tf-pub-rt.id
}