
resource "aws_instance" "main_ec2" {

  ##ami           = data.aws_ami.ubuntu.id
  ami           = var.ami
  instance_type = var.instance_type

  dynamic "network_interface" {
    for_each = var.net_interface_statements
    content {
      network_interface_id  = try(network_interface.value.network_interface_id, null)
      device_index          = try(network_interface.value.device_index, null)
      delete_on_termination = try(network_interface.value.delete_on_termination, null)
    }
  }

  key_name = var.key_name
  #security_groups = var.security_groups

  # nginx installation
  provisioner "file" {
    source      = var.prov_file_source
    destination = var.prov_file_destination
  }

  provisioner "remote-exec" {
    inline = var.remote_exec_commands
  }

  #
  #  dynamic "connection" {
  #    for_each = var.connection_statements
  #    content {
  #      type        = "ssh"
  ##host          = self.public_ip
  #      user        = try(connection.value.user, null)
  #      private_key = try(connection.value.private_key, null)
  #      host        = try(connection.value.host_ip_address, null)
  #    }
  #  }
  #

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = var.private_key_str
    ##host        = var.host_ip_address
    host = self.public_ip
  }

  tags = {
    Name = "main_vpc"
  }

}

output "ec2_instance_state" {
  value = aws_instance.main_ec2.instance_state
}

output "ec2_arn" {
  value = aws_instance.main_ec2.arn
}

output "ec2_id" {
  value = aws_instance.main_ec2.id
}


/*
Following for Reference.
-----------------------
ami - (Required) AMI to use for the instance.

associate_public_ip_address - (Optional) Whether to associate a public IP address with an instance in a VPC.

availability_zone - (Optional) AZ to start the instance in.

cpu_core_count - (Optional) Sets the number of CPU cores for an instance. This option is only supported on creation of instance type that support CPU Options CPU Cores and Threads Per CPU Core Per Instance Type - specifying this option for unsupported instance types will return an error from the EC2 API.


credit_specification - (Optional) Customize the credit specification of the instance. See Credit Specification below for more details.

disable_api_termination - (Optional) If true, enables EC2 Instance Termination Protection.


ebs_block_device - (Optional) Additional EBS block devices to attach to the instance. Block device configurations only apply on resource creation. See Block Devices below for details on attributes and drift detection.


ebs_optimized - (Optional) If true, the launched EC2 instance will be EBS-optimized. Note that if this is not set on an instance type that is optimized by default then this will show as disabled but if the instance type is optimized by default then there is no need to set this and there is no effect to disabling it. See the EBS Optimized section of the AWS User Guide for more information.

enclave_options - (Optional) Enable Nitro Enclaves on launched instances. See Enclave Options below for more details.


ephemeral_block_device - (Optional) Customize Ephemeral (also known as "Instance Store") volumes on the instance. See Block Devices below for details.


get_password_data - (Optional) If true, wait for password data to become available and retrieve it. Useful for getting the administrator password for instances running Microsoft Windows. The password data is exported to the password_data attribute. See GetPasswordData for more information.


hibernation - (Optional) If true, the launched EC2 instance will support hibernation.

host_id - (Optional) ID of a dedicated host that the instance will be assigned to. Use when an instance is to be launched on a specific dedicated host.

iam_instance_profile - (Optional) IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. Ensure your credentials have the correct permission to assign the instance profile according to the EC2 documentation, notably iam:PassRole.

instance_initiated_shutdown_behavior - (Optional) Shutdown behavior for the instance. Amazon defaults this to stop for EBS-backed instances and terminate for instance-store instances. Cannot be set on instance-store instances. See Shutdown Behavior for more information.

instance_type - (Required) Type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance.

ipv6_address_count- (Optional) A number of IPv6 addresses to associate with the primary network interface. Amazon EC2 chooses the IPv6 addresses from the range of your subnet.

ipv6_addresses - (Optional) Specify one or more IPv6 addresses from the range of the subnet to associate with the primary network interface

key_name - (Optional) Key name of the Key Pair to use for the instance; which can be managed using the aws_key_pair resource.

metadata_options - (Optional) Customize the metadata options of the instance. See Metadata Options below for more details.

monitoring - (Optional) If true, the launched EC2 instance will have detailed monitoring enabled. (Available since v0.6.0)

network_interface - (Optional) Customize network interfaces to be attached at instance boot time. See Network Interfaces below for more details.

placement_group - (Optional) Placement Group to start the instance in.

private_ip - (Optional) Private IP address to associate with the instance in a VPC.

root_block_device - (Optional) Customize details about the root block device of the instance. See Block Devices below for details.

secondary_private_ips - (Optional) A list of secondary private IPv4 addresses to assign to the instance's primary network interface (eth0) in a VPC. Can only be assigned to the primary network interface (eth0) attached at instance creation, not a pre-existing network interface i.e. referenced in a network_interface block. Refer to the Elastic network interfaces documentation to see the maximum number of private IP addresses allowed per instance type.

security_groups - (Optional, EC2-Classic and default VPC only) A list of security group names (EC2-Classic) or IDs (default VPC) to associate with.

source_dest_check - (Optional) Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs. Defaults true.

subnet_id - (Optional) VPC Subnet ID to launch in.

tags - (Optional) A map of tags to assign to the resource. Note that these tags apply to the instance and not block storage devices.

tenancy - (Optional) Tenancy of the instance (if the instance is running in a VPC). An instance with a tenancy of dedicated runs on single-tenant hardware. The host tenancy is not supported for the import-instance command.

user_data - (Optional) User data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead.
user_data_base64 - (Optional) Can be used instead of user_data to pass base64-encoded binary data directly. Use this instead of user_data whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption.
*/
