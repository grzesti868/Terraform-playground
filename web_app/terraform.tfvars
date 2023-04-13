billing_code = "TEST VALUE"
project      = "Engineering Thesis"
# aws_access_key = "access key"
# aws_secret_key = "secret key"

vpc_cidr_block = {
  Development = "10.0.0.0/16"
  Stage       = "10.1.0.0/16"
  Production  = "10.2.0.0/16"
}

vpc_subnet_count = {
  Development = 2
  Stage       = 2
  Production  = 3
}

instance_type = {
  Development = "t2.micro"
  Stage       = "t2.small"
  Production  = "t2.medium"
}

count_instances = {
  Development = 2
  Stage       = 4
  Production  = 6
}
