output "proxy_instance_sgid" { 
  value = aws_security_group.proxy-instance-sg.id
}

output "elb_sgid" {
  value = aws_security_group.elb-securitygroup.id
}

# output "proxy_vpc_id" {
#   value = aws_vpc.main.id
# }

# output "proxy_public_subnets" {
#   value = aws_vpc.main.public-Subnets
# }

output "ELB" {
  value = aws_elb.brokentable-elb.dns_name
}