
#-----------------------------------------------
# lb_target_group variables
#-----------------------------------------------

variable "bucket" {
  type        = string
  description = "(Required)"
  default     = "test-bucket"
}

variable "acl" {
  type        = string
  description = "(Required)"
  default     = "private"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Key-value map of tags for the IAM user."
  default     = {}
}


#variable "private_ips" {
#  type        = list(string)
#  description = "(Required)  . "
#  default = []
#}
#

##------------------------------
##Attributes Reference
##------------------------------

variable "s3_bucket_id" {
  type = string
}

variable "s3_bucket_arn" {
  type = string
}


/*
id - The name of the bucket.
arn - The ARN of the bucket. Will be of format arn:aws:s3:::bucketname.
bucket_domain_name - The bucket domain name. Will be of format bucketname.s3.amazonaws.com.
bucket_regional_domain_name - The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL.
hosted_zone_id - The Route 53 Hosted Zone ID for this bucket's region.
region - The AWS region this bucket resides in.
website_endpoint - The website endpoint, if the bucket is configured with a website. If not, this will be an empty string.
website_domain - The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records.
*/
