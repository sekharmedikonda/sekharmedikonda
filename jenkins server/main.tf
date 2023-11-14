#vpc
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs = data.aws_availability_zones.azs.names
  # private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = var.public_subnets
  map_public_ip_on_launch = true

  #enable_nat_gateway = true
  #enable_vpn_gateway = true

  enable_dns_hostnames = true

  tags = {
    Name        = "jenkins-vpc"
    Terraform   = "true"
    Environment = "dev"
  }


  public_subnet_tags = {

    Name = "jenkins-subnet"
  }
}



# SG
module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-sg"
  description = "security group for jenkins server"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
       from_port   =  22
      to_port     = 22
      protocol    = "tcp"
      description = "SSh"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_with_cidr_blocks = [
        {
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = "0.0.0.0/0"
         }
  ] 

          tags = {
            Name = "jenkins-sg"
  
}
}



resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits = 4096
  
}

# resource "aws_key_pair" "my_key_pair" {
#   key_name   = var.key_name
#   public_key = file("${abspath(path.cwd)}/my-key.pub")
# }


# resource "aws_instance" "windows" {
#   ami                         = data.aws_ami.Windows_2019.image_id
#   instance_type               = var.windows_instance_types
#   key_name                    = aws_key_pair.my_key_pair.key_name


# }


#EC2

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-server"

  instance_type          = "t2.micro"
  #key_name               = "aws_key_pair.my_key_pair.key_name"
  key_name = "two"
  monitoring             = true
  vpc_security_group_ids = [module.sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data = file("jenkins-install.sh")
  availability_zone = data.aws_availability_zones.azs.names[0]



  tags = {
    Name = "Jenkins-server"
    Terraform   = "true"
    Environment = "dev"
  }
}