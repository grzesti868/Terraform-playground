#todo: make it azure provider

##################################################################################
# DATA
##################################################################################

# data "aws_ssm_parameter" "ami" {
#   name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
# }

data "aws_availability_zones" "available" {
  state = "available"
}


##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #
# Using module instead
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "=3.14.2"

  cidr = var.vpc_cidr_block[terraform.workspace]

  azs = slice(data.aws_availability_zones.available.names, 0, (var.vpc_subnet_count[terraform.workspace]))
  #private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = [for subnet in range(var.vpc_subnet_count[terraform.workspace]) : cidrsubnet(var.vpc_cidr_block[terraform.workspace], 8, subnet)]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc"
  })
}

# resource "aws_vpc" "vpc" {
#   cidr_block           = var.vpc_cidr_block
#   enable_dns_hostnames = var.enable_dns_hostnames

#   tags = merge(local.common_tags, {
#     Name = "${local.name_prefix}-vpc"
#   })
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.vpc.id

#   tags = merge(local.common_tags, {
#     Name = "${local.name_prefix}-igw"
#   })
# }

# resource "aws_subnet" "subnets" {
#   count                   = var.vpc_subnet_count
#   cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index)
#   vpc_id                  = aws_vpc.vpc.id
#   map_public_ip_on_launch = var.map_public_ip_on_launch
#   availability_zone       = data.aws_availability_zones.available.names[count.index]

#   tags = merge(local.common_tags, {
#     Name = "${local.name_prefix}-subnet-${count.index}"
#   })
# }


# # ROUTING #
# resource "aws_route_table" "rtb" {
#   vpc_id = aws_vpc.vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   tags = merge(local.common_tags, {
#     Name = "${local.name_prefix}-rtb"
#   })
# }

# resource "aws_route_table_association" "rta-subnets" {
#   count          = var.vpc_subnet_count
#   subnet_id      = aws_subnet.subnets[count.index].id
#   route_table_id = aws_route_table.rtb.id
#   #gateway_id = aws_internet_gateway.igw.id
# }
# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "nginx_sg"
  vpc_id = module.vpc.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_security_group" "nginx-sg2" {
  name   = "nginx_sg2"
  vpc_id = module.vpc.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    #allow traffic from addresses that are in the vpc_cidr_block
    cidr_blocks = [var.vpc_cidr_block[terraform.workspace]]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}
