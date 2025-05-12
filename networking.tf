resource "aws_vpc" "test_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.test_vpc.id
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.test_vpc.id
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rtb_ass" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rtb.id
}