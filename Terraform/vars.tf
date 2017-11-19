########################################
### Variables ##########################
########################################

data "aws_availability_zones" "available" {}

variable "global" {
    type = "map"
    default = {
        environment = "Development"
        region      = "us-west-2"
    }
}

variable "vpc" {
    type = "map"
    default = {
        vpc_name            = "ScriptMyJob VPC 1"
        name_subnet_1       = "Public Web Server"
        name_subnet_2       = "Master Web Server"
        name_subnet_3       = "RDS 1"
        name_subnet_4       = "RDS 2"
        vpc_cidr            = "100.64.0.0/16"
        pub_ws_subnet_1     = "100.64.101.0/24"
        pub_ws_subnet_2     = "100.64.102.0/24"
        pub_ws_subnet_3     = "100.64.103.0/24"
        cidr_2              = "100.64.128.0/17"
        efs_subnet_1        = "100.64.131.0/24"
        efs_subnet_2        = "100.64.132.0/24"
        efs_subnet_3        = "100.64.133.0/24"
        lambda_subnet_1     = "100.64.141.0/24"
        lambda_subnet_2     = "100.64.142.0/24"
        priv_ws_subnet_1    = "100.64.151.0/24"
        priv_ws_subnet_2    = "100.64.152.0/24"
        priv_ws_subnet_3    = "100.64.153.0/24"
        rds_subnet_1        = "100.64.200.0/24"
        rds_subnet_2        = "100.64.201.0/24"
        ansible_subnet      = "100.64.202.0/24"
        eip_address         = "52.36.181.100"

    }
}

variable "ec2" {
    type = "map"
    default = {
        policy      = <<EC2_POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EC2_POLICY
    }
}

variable "efs" {
    type = "map"
    default = {
        name_1  = "EFS Subnet 1"
        name_2  = "EFS Subnet 2"
        name_3  = "EFS Subnet 3"
    }
}

variable "lambda" {
    type = "map"
    default = {
        name_1  = "Lambda Subnet 1"
        name_2  = "Lambda Subnet 2"
    }
}
