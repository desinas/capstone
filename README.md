### 1. Introduction Phase
- **Architecture Overview**:
  - **VPC Setup**: Virtual Private Cloud (VPC) divided into public and private subnets for better security and control.
  - **Application Load Balancer (ALB)**: Distributes incoming traffic across multiple EC2 instances.
  - **Auto Scaling Group**: Automatically scales EC2 instances based on demand.
  - **MySQL Database in Multi-AZ**: Ensures high availability and fault tolerance by deploying across multiple Availability Zones (AZs).

- **Tools Overview**:
  - **AWS**: Cloud platform for deployment.
  - **Terraform**: Infrastructure as Code (IaC) tool to automate the provisioning of AWS resources.
  - **Git & GitHub**: Version control system and repository hosting service.
  - **Scrum**: Agile methodology for project management.

### 2. Setup Phase
- **Tools Installation**:
  - **AWS CLI**: Install and configure with your credentials.
  - **Terraform**: Download and install the Terraform CLI.
  - **Git**: Install Git and set up your GitHub repository.
  - **VS Code**: Install Visual Studio Code for code editing and management.

### 3. Scrum Methodology
- **Sprints**:
  1. **Sprint 1**: Set up the VPC and networking.
  2. **Sprint 2**: Launch EC2 instances and configure Auto Scaling Groups.
  3. **Sprint 3**: Set up the Application Load Balancer and Security Groups.
  4. **Sprint 4**: Configure RDS for the WordPress database.
  5. **Sprint 5**: Deploy WordPress on EC2 and connect it to the RDS.

- **Roles**:
  - **Scrum Master**: Facilitates Scrum processes.
  - **Product Owner**: Defines the project vision and backlog.
  - **Development Team**: Executes the tasks and builds the product.

- **Meetings**:
  - **Daily Stand-ups**: Brief daily meetings to discuss progress and obstacles.
  - **Sprint Reviews**: Review completed work and plan for the next sprint.

### 4. Implementation Phase
- **Sprint 1**: Create the VPC with Terraform.
  - Define VPC, subnets, route tables, and internet gateway in Terraform configuration files.

- **Sprint 2**: Deploy EC2 and Auto Scaling Groups.
  - Use Terraform modules to launch EC2 instances and define Auto Scaling policies.

- **Sprint 3**: Configure the Load Balancer.
  - Set up ALB with target groups and listeners, and attach appropriate Security Groups.

- **Sprint 4**: Deploy the MySQL Database.
  - Create an RDS instance with primary and standby configurations and configure database parameters for WordPress.

- **Sprint 5**: Deploy WordPress.
  - Use an S3 bucket to store and retrieve WordPress files, install WordPress on EC2 using a user data script, and configure the WordPress site to connect to the RDS database.

### 5. Collaboration with GitHub
- **Repository Management**:
  - Create a GitHub repository for Terraform scripts.
  - Use Git branches to collaborate on different sprints.
  - Submit and review pull requests to merge changes.

### 6. Testing and Validation
- **Load Balancing**:
  - Simulate traffic using tools like Apache Benchmark to test the load balancer.
  
- **Scalability**:
  - Trigger Auto Scaling policies to validate scalability.

- **Fault Tolerance**:
  - Terminate an instance to ensure failover mechanisms are working.

- **Security**:
  - Verify access restrictions through Security Groups.

### Implementation Phase

#### Sprint 1: Create the VPC
- **Objective**: Set up the Virtual Private Cloud (VPC) and networking.
- **Tasks**:
  - Define the VPC in a Terraform configuration file.
  - Create public and private subnets.
  - Set up route tables and associate them with the subnets.
  - Create and attach an internet gateway to the VPC for internet access.

#### Sprint 2: Deploy EC2 and Auto Scaling Groups
- **Objective**: Launch EC2 instances and set up Auto Scaling.
- **Tasks**:
  - Use Terraform to define EC2 instances in the configuration files.
  - Create an Auto Scaling Group with a launch configuration or template.
  - Define scaling policies to automatically adjust the number of instances based on load.

#### Sprint 3: Configure the Load Balancer
- **Objective**: Set up the Application Load Balancer (ALB).
- **Tasks**:
  - Define the ALB in the Terraform configuration files.
  - Create target groups for the EC2 instances.
  - Set up listeners and listener rules to forward traffic to the target groups.
  - Attach Security Groups to the ALB to control traffic flow.

#### Sprint 4: Deploy the MySQL Database
- **Objective**: Set up an RDS instance for the WordPress database.
- **Tasks**:
  - Use Terraform to define the RDS instance with Multi-AZ deployment.
  - Configure database parameters for optimal performance and security.
  - Set up database security groups to allow traffic from the web server instances.

#### Sprint 5: Deploy WordPress
- **Objective**: Deploy WordPress on the EC2 instances and connect it to the RDS database.
- **Tasks**:
  - Use an S3 bucket to store WordPress installation files.
  - Write a user data script in Terraform to install and configure WordPress during the instance boot.
  - Configure WordPress to connect to the RDS database for data storage.
  - Ensure all necessary permissions and security groups are in place.

Each sprint builds on the previous one, leading to a fully deployed and functional WordPress website by the end of the Implementation Phase. This structured approach ensures that all components are correctly set up and integrated.

### Sprint 1: Create the VPC

#### **Objective:**
Set up the Virtual Private Cloud (VPC) and networking components necessary for your WordPress deployment.

#### **Tasks:**

1. **Define the VPC:**
   - Create a new VPC.
   - Specify the CIDR block for the VPC (e.g., `10.0.0.0/16`).

2. **Create Subnets:**
   - Create public subnets in different Availability Zones.
   - Create private subnets in different Availability Zones.

3. **Set Up Route Tables:**
   - Create a route table for the public subnets and associate it with an internet gateway.
   - Create a route table for the private subnets and configure it to route traffic through a NAT gateway (if needed).

4. **Create and Attach an Internet Gateway:**
   - Create an internet gateway and attach it to your VPC.
   - Update the public route table to route outbound traffic to the internet gateway.

5. **Create a NAT Gateway (Optional):**
   - If your private subnets need internet access, create a NAT gateway in one of the public subnets.
   - Update the private route table to route outbound traffic to the NAT gateway.

### Terraform Configuration Example:

Here's an example of a Terraform configuration for creating a VPC, subnets, and an internet gateway:

```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}
```

### Explanation:
- **VPC**: Defines the main VPC with a CIDR block of `10.0.0.0/16`.
- **Subnets**: Creates two public subnets in different Availability Zones (`us-west-2a` and `us-west-2b`) with CIDR blocks `10.0.1.0/24` and `10.0.2.0/24` respectively.
- **Internet Gateway**: Creates an internet gateway and attaches it to the VPC.
- **Route Table**: Creates a public route table that routes all outbound traffic (`0.0.0.0/0`) to the internet gateway.
- **Route Table Association**: Associates the public subnets with the public route table.
