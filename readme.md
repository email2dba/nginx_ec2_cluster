


### EC2 cluster with web server[nginx] installation on AWS


#### Summary

proj_taml_chenn_network.tf script creates the following resources

* aws_vpc resource
  Name = "main_vpc"

* aws_subnet resource
  Two subnet resources are getting created inthe following zones.
  availability_zone = us-east-1a
  availability_zone = "us-east-1b"

* aws_internet_gateway resource
   main_gw attached with above VPC.


* aws_route_table resource

   It creates route table with target_gateway_id to above aws_internet_gateway.

* aws_security_group resource

  It creates security group to open ingress route on port 80 and 22.

* aws_network_interface resource

  It creates network interface and configured with subnet_id, security_groups and with private_ips "10.1.1.12".


* aws_instance resource
  It creates EC2 instance using ubunto  image "ami-0915bcb5fa77e4892"
  Scripts assumes we have key pair created already and  key stored in "deena_key_pair"
  Also, In this aws_instance we provisioning nginx web server.

* aws_lb_target_group resource
 It creates Load balancer for http:80 port.

* aws_lb_target_group_attachment resource
   It attaching aws_lb_target_group with aws_instance(EC2)


* aws_s3_bucket resource
  It creates S3 bucket.

* aws_lb resource
  It creates applicaiton load balancer

* aws_lb_listener resource
  It creates applicaiton load balancer listener. It attached with aws_lb_target_group on other end.

* aws_lb_listener_rule resource
 It defines  Forward rule to forward the traffic listener to target group.
