## Create the Project VPC Resource ... 
resource "aws_vpc" "project_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = true
  tags = {
    Name = "Subhash_Project_VPC"
    }
}

## Create One Public and One Private Subnet ...
resource "aws_subnet" "public_subnet" {
    count = 1
    cidr_block = var.public_subnet_cidr_block
    availability_zone = "us-east-2a"
    vpc_id = aws_vpc.project_vpc.id
    map_public_ip_on_launch = true
    tags = {
      Name = "Subhash_Project_PublicSubnet"
    }
}

resource "aws_subnet" "private_subnet" {
    count = 1
    cidr_block = var.private_subnet_cidr_block
    availability_zone = "us-east-2a"
    vpc_id = aws_vpc.project_vpc.id
    tags = {
      Name = "Subhash_Project_PrivateSubnet"
    }
}

## Create and attach an Internet Gateway to the VPC ...
resource "aws_internet_gateway" "project_igw" {
    vpc_id = aws_vpc.project_vpc.id
    tags = {
      Name = "Subhash_Project_IGW"
    }
}

## Create Public and Private RouteTables ...
resource "aws_route_table" "PublicRouteTable" {
    vpc_id = aws_vpc.project_vpc.id
    tags = {
      Name = "Subhash_Project_PublicRouteTable"
    }
}

resource "aws_route_table" "PrivateRouteTable" {
    vpc_id = aws_vpc.project_vpc.id
    tags = {
      Name = "Subhash_Project_PrivateRouteTable"
    }
}

## Associate Public Route Table with Public Subnet ... 
resource "aws_route_table_association" "PublicSubnetAssociation" {
    subnet_id = aws_subnet.public_subnet[0].id
    route_table_id = aws_route_table.PublicRouteTable.id
}

## Associate Private Route Table with Private Subnet ... 
resource "aws_route_table_association" "PrivateSubnetAssociation" {
    subnet_id = aws_subnet.private_subnet[0].id
    route_table_id = aws_route_table.PrivateRouteTable.id
}

## Define a default route (0.0.0.0/0) for Public Route Table to Internet Gateway ...
resource "aws_route" "PublicDefaultRoute" {
    route_table_id = aws_route_table.PublicRouteTable.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_igw.id
}

## Create Elastic IP to associate with NAT GW
resource "aws_eip"  "public_eip" {
  tags = {
    Name = "Subhash_Project_Elastic_IP"
  }
}

## Create NAT GW and associate EIP with NAT GW
resource "aws_nat_gateway" "subhash_project_nat_gw" {
  subnet_id = aws_subnet.public_subnet[0].id
  allocation_id = aws_eip.public_eip.id
}

## Add NAT GW route to the Private RouteTable's route entry ... 
resource "aws_route" "NATGW_Route" {
  route_table_id = aws_route_table.PrivateRouteTable.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.subhash_project_nat_gw.id
  
}
