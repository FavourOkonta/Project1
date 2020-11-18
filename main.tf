provider "aws" {
  profile = "default"
  version = "3.0"
  region  = "us-east-1"
}
# create the VPC
resource "aws_vpc" "Voting_VPC" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames
  tags = {
    Name = "Voting VPC"
  }
} # end resource
# create the Subnet

resource "aws_subnet" "Public" {
  vpc_id                  = aws_vpc.Voting_VPC.id
  cidr_block              = var.subnetCIDRblock
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone
  tags = {
    Name = "WebServers"
  }
}

resource "aws_subnet" "Grafana" {
  vpc_id                  = aws_vpc.Voting_VPC.id
  cidr_block              = var.subnetCIDRblock5
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone
  tags = {
    Name = "Monitoring"
  }
}

# create the Subnet
resource "aws_subnet" "Application_1" {
  vpc_id            = aws_vpc.Voting_VPC.id
  cidr_block        = var.subnetCIDRblock1
  availability_zone = var.availabilityZone
  tags = {
    Name = "Private App"
  }
} # end resource

# create the Subnet
resource "aws_subnet" "Redis_Database_1" {
  vpc_id            = aws_vpc.Voting_VPC.id
  cidr_block        = var.subnetCIDRblock2
  availability_zone = var.availabilityZone
  tags = {
    Name = "Private DB1"
  }
} # end resource


# create the Subnet
resource "aws_subnet" "Application_2" {
  vpc_id            = aws_vpc.Voting_VPC.id
  cidr_block        = var.subnetCIDRblock3
  availability_zone = var.availabilityZone1
  tags = {
    Name = "Private App"
  }
} # end resource

# create the Subnet
resource "aws_subnet" "Redis_Database_2" {
  vpc_id            = aws_vpc.Voting_VPC.id
  cidr_block        = var.subnetCIDRblock4
  availability_zone = var.availabilityZone1
  tags = {
    Name = "Private DB2"
  }
} # end resource

# Create the Security Group
resource "aws_security_group" "Webservers" {
  vpc_id      = aws_vpc.Voting_VPC.id
  name        = "WebserversSG"
  description = "WebserversSG"

  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
  }

  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "Web Security Group"
    Description = "My VPC Security Group"
  }
} # end resource

# Create the Security Group
resource "aws_security_group" "Voting_App" {
  vpc_id      = aws_vpc.Voting_VPC.id
  name        = "AppSG"
  description = "AppSG"

  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
  }
  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "App Security Group"
    Description = "App VPC Security Group"
  }
} # end resource

# Create the Security Group2
resource "aws_security_group" "Grafana" {
  vpc_id      = aws_vpc.Voting_VPC.id
  name        = "Grafana Security Group"
  description = "Grafana Security Group"

  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 9300
    to_port     = 9300
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 9115
    to_port     = 9115
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 9093
    to_port     = 9093
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
  }

  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "Grafana Security Group"
    Description = "Grafana Security Group"
  }
} # end resource

# Create the Security Group
resource "aws_security_group" "RedisDB" {
  name        = "RedisDBSG"
  vpc_id      = aws_vpc.Voting_VPC.id
  description = "RedisDBSG"

  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
  }

  # allow egress of all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "RedisDB Security Group"
    Description = "RedisDB VPC Security Group"
  }
} # end resource


# Create the Internet Gateway
resource "aws_internet_gateway" "My_VPC_GW" {
  vpc_id = aws_vpc.Voting_VPC.id
  tags = {
    Name = "Voting VPC Internet Gateway"
  }
} # end resource


# Create the Route Table
resource "aws_route_table" "My_VPC_route_table" {
  vpc_id = aws_vpc.Voting_VPC.id
  tags = {
    Name = "Voting VPC Route Table"
  }
} # end resource

# Create the Route Table
resource "aws_route_table" "My_VPC_route_table1" {
  vpc_id = aws_vpc.Voting_VPC.id
  tags = {
    Name = "My VPC Route Table1"
  }
} # end resource

# Create the Internet Access
resource "aws_route" "My_VPC_internet_access" {
  route_table_id         = aws_route_table.My_VPC_route_table.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.My_VPC_GW.id
} # end resource

# Create the Internet Access
resource "aws_route" "My_VPC_internet_access1" {
  route_table_id         = aws_route_table.My_VPC_route_table1.id
  destination_cidr_block = var.destinationCIDRblock
  gateway_id             = aws_internet_gateway.My_VPC_GW.id
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association" {
  subnet_id      = aws_subnet.Public.id
  route_table_id = aws_route_table.My_VPC_route_table.id
} # end resource

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "My_VPC_association1" {
  subnet_id      = aws_subnet.Grafana.id
  route_table_id = aws_route_table.My_VPC_route_table1.id
} # end resource

data "aws_ami" "Private_Template" {
  most_recent = true
  owners      = ["697430341089"] # Canonical

  filter {
    name   = "name"
    values = ["Project"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# Create EC2 instance
resource "aws_instance" "Webserver" {
  ami                    = "ami-0947d2ba12ee1ff75"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.Public.id
  key_name               = "crossovertest"
  vpc_security_group_ids = [aws_security_group.Webservers.id]
  user_data              = file("start.sh")
  tags = {
    Name        = "WebServer Node"
    name        = "WebServer Node"
    provisioner = "Terraform"
  }
}

# Create EC2 instance
resource "aws_instance" "Voting_App" {
  ami                    = data.aws_ami.Private_Template.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.Application_1.id
  key_name               = "crossovertest"
  vpc_security_group_ids = [aws_security_group.Voting_App.id]
  user_data              = file("start.sh")
  tags = {
    Name        = "App1 Node"
    name        = "App1 Node"
    provisioner = "Terraform"
  }
}


# Create EC2 instance
resource "aws_instance" "Voting_App_2" {
  ami                    = data.aws_ami.Private_Template.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.Application_2.id
  key_name               = "crossovertest"
  user_data              = file("start.sh")
  vpc_security_group_ids = [aws_security_group.Voting_App.id]
  tags = {
    Name        = "App2 Node"
    name        = "App2 Node"
    provisioner = "Terraform"
  }
}

# Create EC2 instance
resource "aws_instance" "RedisDB_1" {
  ami                    = data.aws_ami.Private_Template.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.Redis_Database_1.id
  key_name               = "crossovertest"
  vpc_security_group_ids = [aws_security_group.RedisDB.id]
  user_data              = file("start.sh")
  tags = {
    Name        = "DB1 Node"
    name        = "DB1 Node"
    provisioner = "Terraform"
  }
}

# Create EC2 instance
resource "aws_instance" "RedisDB_2" {
  ami                    = data.aws_ami.Private_Template.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.Redis_Database_2.id
  key_name               = "crossovertest"
  vpc_security_group_ids = [aws_security_group.RedisDB.id]
  user_data              = file("start.sh")
  tags = {
    Name        = "DB2 Node"
    name        = "DB2 Node"
    provisioner = "Terraform"
  }
}

# Create EC2 instance2
resource "aws_instance" "Grafana" {
  ami                    = data.aws_ami.Private_Template.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.Grafana.id
  key_name               = "crossovertest"
  vpc_security_group_ids = [aws_security_group.Grafana.id]
  user_data              = file("jenkins.sh")
  tags = {
    Name        = "Grafana Node"
    name        = "Grafana Node"
    provisioner = "Terraform"
  }
}

output "Webserver" {
  value       = aws_instance.Webserver.public_ip
  description = "The IP address of the instance."
}


output "Grafana" {
  value       = aws_instance.Grafana.public_ip
  description = "The IP address of the instance."
}