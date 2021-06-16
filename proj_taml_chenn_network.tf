# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE  VPC and Subnet
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#------------------------------------------------------------------
# proj_taml_chenn_vpc
#------------------------------------------------------------------

module "proj_taml_chenn_vpc" {
  source         = "./mod_vpc"
  vpc_cidr_block = "10.1.0.0/16"
  vpc_id         = module.proj_taml_chenn_vpc.vpc_id
  vpc_arn        = module.proj_taml_chenn_vpc.vpc_arn
}
#------------------------------------------------------------------
# proj_taml_chenn_subnet
#------------------------------------------------------------------

module "proj_taml_chenn_subnet" {
  source                  = "./mod_subnet"
  subnet_cidr_block       = "10.1.1.0/24"
  map_public_ip_on_launch = true

  vpc_id     = module.proj_taml_chenn_vpc.vpc_id
  subnet_id  = module.proj_taml_chenn_subnet.subnet_id
  subnet_arn = module.proj_taml_chenn_subnet.subnet_arn
}

module "proj_taml_chenn_subnet_zone02" {
  source                  = "./mod_subnet"
  subnet_cidr_block       = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  vpc_id                  = module.proj_taml_chenn_vpc.vpc_id
  subnet_id               = module.proj_taml_chenn_subnet_zone02.subnet_id
  subnet_arn              = module.proj_taml_chenn_subnet_zone02.subnet_arn
}


#------------------------------------------------------------------
# proj_taml_chenn_inet_gw
#------------------------------------------------------------------

module "proj_taml_chenn_inet_gw" {
  source      = "./mod_inet_gw"
  vpc_id      = module.proj_taml_chenn_vpc.vpc_id
  inet_gw_id  = module.proj_taml_chenn_inet_gw.inet_gw_id
  inet_gw_arn = module.proj_taml_chenn_inet_gw.inet_gw_arn
}
#------------------------------------------------------------------
# proj_taml_chenn_route_table
#------------------------------------------------------------------

module "proj_taml_chenn_route_table" {
  source = "./mod_route_table"
  vpc_id = module.proj_taml_chenn_vpc.vpc_id

  route_statements = [
    {
      destination       = "0.0.0.0/0"
      target_gateway_id = module.proj_taml_chenn_inet_gw.inet_gw_id
    }
  ]

  route_table_id = module.proj_taml_chenn_route_table.route_table_id
}

#------------------------------------------------------------------
# proj_taml_chenn_route_association
#------------------------------------------------------------------

module "proj_taml_chenn_route_association" {
  source               = "./mod_route_association"
  route_table_id       = module.proj_taml_chenn_route_table.route_table_id
  subnet_id            = module.proj_taml_chenn_subnet.subnet_id
  route_association_id = module.proj_taml_chenn_route_association.route_association_id
}

#------------------------------------------------------------------
# proj_taml_chenn_secur_group
#------------------------------------------------------------------

module "proj_taml_chenn_secur_group4ssh" {
  source = "./mod_secur_group"
  vpc_id = module.proj_taml_chenn_vpc.vpc_id

  ingress_statements = [
    {
      source    = ["0.0.0.0/0"]
      from_port = "22"
      to_port   = "22"
      protocol  = "tcp"
    },
    {
      source    = ["0.0.0.0/0"]
      from_port = "80"
      to_port   = "80"
      protocol  = "tcp"
    }
  ]

  egress_statements = [
    {
      destination = ["0.0.0.0/0"]
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
    }
  ]

  secur_group_id  = module.proj_taml_chenn_secur_group4ssh.secur_group_id
  secur_group_arn = module.proj_taml_chenn_secur_group4ssh.secur_group_arn
}


#------------------------------------------------------------------
# proj_taml_chenn_net_interface
#------------------------------------------------------------------

module "proj_taml_chenn_net_interface" {
  source                    = "./mod_net_interface"
  subnet_id                 = module.proj_taml_chenn_subnet.subnet_id
  private_ips               = ["10.1.1.12"]
  net_interface_id          = module.proj_taml_chenn_net_interface.net_interface_id
  net_interface_mac_address = module.proj_taml_chenn_net_interface.net_interface_mac_address
  security_groups           = [module.proj_taml_chenn_secur_group4ssh.secur_group_id]
}

#------------------------------------------------------------------
# proj_taml_chenn_ec2
#------------------------------------------------------------------
/*
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
*/


module "proj_taml_chenn_ec2" {
  source = "./mod_ec2"
  #ami                 = data.aws_ami.ubuntu.id
  ami           = "ami-0915bcb5fa77e4892"
  instance_type = "t2.micro"
  key_name      = "deena_key_pair"

  net_interface_statements = [
    {
      network_interface_id = module.proj_taml_chenn_net_interface.net_interface_id
      device_index         = 0
    }
  ]

  # Security Group
  ##security_groups = [module.proj_taml_chenn_secur_group4ssh.secur_group_id]


  # nginx installation
  prov_file_source      = "nginx.sh"
  prov_file_destination = "/tmp/nginx.sh"

  remote_exec_commands = ["sudo chmod 777 /tmp/nginx.sh", "sudo /tmp/nginx.sh"]

  private_key_str = file("./deena_key_pair.pem")
  ##host_ip_address = .public_ip

  ec2_instance_state = module.proj_taml_chenn_ec2.ec2_instance_state
  ec2_arn            = module.proj_taml_chenn_ec2.ec2_arn
  ec2_id             = module.proj_taml_chenn_ec2.ec2_id
}

module "proj_taml_chenn_lb_target_group" {
  source = "./mod_lb_target_group"

  name                = "proj-taml-chenn-lb-target-group"
  port                = 80
  protocol            = "HTTP"
  vpc_id              = module.proj_taml_chenn_vpc.vpc_id
  health_check_path   = "/"
  health_check_port   = 80
  lb_target_group_id  = module.proj_taml_chenn_lb_target_group.lb_target_group_id
  lb_target_group_arn = module.proj_taml_chenn_lb_target_group.lb_target_group_arn
}


module "proj_taml_chenn_lb_target_group_atch" {
  source                        = "./mod_lb_target_group_attachment"
  target_group_arn              = module.proj_taml_chenn_lb_target_group.lb_target_group_arn
  target_id                     = module.proj_taml_chenn_ec2.ec2_id
  port                          = 80
  lb_target_group_attachment_id = module.proj_taml_chenn_lb_target_group_atch.lb_target_group_attachment_id
}

module "proj_taml_chenn_s3_bucket" {
  source        = "./mod_s3_bucket"
  bucket        = "proj-taml-chenn-s3-bucket"
  acl           = "private"
  s3_bucket_id  = module.proj_taml_chenn_s3_bucket.s3_bucket_id
  s3_bucket_arn = module.proj_taml_chenn_s3_bucket.s3_bucket_arn
}

module "proj_taml_chenn_appl_lb" {
  source                     = "./mod_appl_lb"
  name                       = "proj-taml-chenn-appl-lb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [module.proj_taml_chenn_secur_group4ssh.secur_group_id]
  subnets                    = [module.proj_taml_chenn_subnet.subnet_id, module.proj_taml_chenn_subnet_zone02.subnet_id]
  enable_deletion_protection = false
  access_logs_bucket         = module.proj_taml_chenn_s3_bucket.s3_bucket_id
  access_logs_prefix         = "test"
  appl_lb_id                 = module.proj_taml_chenn_appl_lb.appl_lb_id
  appl_lb_arn                = module.proj_taml_chenn_appl_lb.appl_lb_arn

}

module "proj_taml_chenn_lb_listener" {
  source            = "./mod_lb_listener"
  load_balancer_arn = module.proj_taml_chenn_appl_lb.appl_lb_arn
  port              = 80
  protocol          = "HTTP"

  default_action_type = "forward"
  target_group_arn    = module.proj_taml_chenn_lb_target_group.lb_target_group_arn

  lb_listener_id  = module.proj_taml_chenn_lb_listener.lb_listener_id
  lb_listener_arn = module.proj_taml_chenn_lb_listener.lb_listener_arn

}


module "proj_taml_chenn_lb_listener_rule" {
  source       = "./mod_lb_listener_rule"
  listener_arn = module.proj_taml_chenn_lb_listener.lb_listener_arn
  priority     = 100

  action_statements = [
    {
      type             = "forward"
      target_group_arn = module.proj_taml_chenn_lb_target_group.lb_target_group_arn
    }
  ]

  condition_statements1 = [
    {
      path_pattern = [{ values = ["/static/*"] }]
    }
  ]

  condition_statements2 = [
    {
      host_header = [{ values = ["example.com"] }]
    }
  ]

  lb_listener_rule_id  = module.proj_taml_chenn_lb_listener_rule.lb_listener_rule_id
  lb_listener_rule_arn = module.proj_taml_chenn_lb_listener_rule.lb_listener_rule_arn
}


