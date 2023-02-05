# Distribute 3 ec2 instances amoung the 2 subnets
resource "aws_instance" "web-servers" {
  count = 3
  ami           = "${data.aws_ami_ids.ubuntu.ids[0]}"
#   ami           = data.aws_ami.ubuntu.id
  instance_type = "${var.instance_type}"
  subnet_id = "${element(data.aws_subnets.selected.ids, count.index)}"
  associate_public_ip_address = true
  key_name = "${var.ssh_key}"
  vpc_security_group_ids = setunion(data.aws_security_groups.sg.ids, [])

  tags = {
    Name = "web-server-0${count.index + 1}"
  }
}


# Create ansible hostfile containing ip address of instances
resource "local_file" "ip_address_to_ansible_inventory" {
  filename = "${var.ansible_hosts}"
  content = <<EOF
[web_servers]
${join("\n", aws_instance.web-servers.*.public_ip)}
EOF
}
