![design](/AWSinfrastructureWPress.pdf)
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

Great! Let's move on to **Sprint 2: Deploy EC2 and Auto Scaling Groups**. Here are the detailed steps:

### Sprint 2: Deploy EC2 and Auto Scaling Groups

#### **Objective:**
Launch EC2 instances and set up Auto Scaling to ensure your WordPress deployment can handle variable loads.

#### **Tasks:**

1. **Define EC2 Instances:**
   - Use Terraform to specify the configurations for your EC2 instances.
   - Define the AMI (Amazon Machine Image) to be used, instance type, key pair for SSH access, and security groups.

2. **Create an Auto Scaling Group (ASG):**
   - Define the launch configuration or launch template for the EC2 instances.
   - Set the desired capacity, minimum size, and maximum size of the ASG.
   - Attach the ASG to the public subnets created in Sprint 1.

3. **Define Scaling Policies:**
   - Create policies to automatically scale the number of EC2 instances based on CloudWatch metrics (e.g., CPU utilization).

```hcl
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              service httpd start
              chkconfig httpd on
            EOF
```
#### Explanation:
- **EC2 Instance**: Defines the EC2 instance with the specified AMI, instance type, key pair, and security group. The `user_data` script installs and starts the Apache web server.

With this setup, the EC2 instances will be automatically scaled based on the defined policies, ensuring your WordPress deployment can handle varying traffic loads.

### Sprint 3: Configure the Load Balancer

#### **Objective:**
Set up an Application Load Balancer (ALB) to distribute incoming traffic across multiple EC2 instances for improved reliability and performance.

#### **Tasks:**

1. **Define the Application Load Balancer (ALB):**
   - Create the ALB in your Terraform configuration.
   - Specify the subnets for the ALB (use the public subnets created in Sprint 1).
   - Configure the load balancer to listen for HTTP (and/or HTTPS) traffic.

2. **Create Target Groups:**
   - Set up target groups to manage the EC2 instances that will receive traffic from the ALB.
   - Define health check settings to monitor the health of the instances.

3. **Set Up Listeners and Listener Rules:**
   - Create listeners to route incoming traffic to the appropriate target groups.
   - Define rules to specify how traffic is directed based on conditions (e.g., URL paths).

4. **Attach Security Groups:**
   - Ensure that the ALB and target groups have appropriate security groups attached to allow and control traffic.

#### Explanation:
- **Load Balancer (ALB)**: Creates an ALB in the specified subnets with a security group allowing HTTP traffic.
- **Target Group**: Defines a target group for the EC2 instances, with health check settings to monitor instance health.
- **Listener**: Creates a listener on the ALB to listen for HTTP traffic on port 80 and forwards it to the target group.
- **Security Group**: Sets up a security group to allow HTTP traffic to the load balancer.

This configuration will ensure that your ALB is set up to distribute incoming traffic across your EC2 instances, improving your application's availability and scalability.

### Sprint 4: Deploy the MySQL Database

#### **Objective:**
Set up an RDS instance with MySQL in a Multi-AZ configuration to ensure high availability and fault tolerance for your WordPress database.

#### **Tasks:**

1. **Create the RDS Instance:**
   - Use Terraform to define the RDS instance with MySQL as the database engine.
   - Configure the instance for Multi-AZ deployment to ensure high availability.

2. **Configure Database Parameters:**
   - Set the necessary parameters for optimal performance and security of the MySQL database.
   - Create a parameter group and associate it with your RDS instance if needed.

3. **Set Up Security Groups:**
   - Define security groups to control access to your RDS instance.
   - Allow traffic from your web server instances to the RDS instance.

### Sprint 5: Deploy WordPress (Without S3 Bucket)
- **Objective**: Deploy WordPress directly on the EC2 instances and connect it to the RDS database.
- **Tasks**:
  1. **Prepare the EC2 Instances**:
     - Use Terraform to define the necessary configurations for your EC2 instances.
     - Write a user data script in Terraform to install the necessary software (Apache/Nginx, PHP, and MySQL client) during the instance boot.

  2. **Install WordPress**:
     - In the user data script, include commands to download the latest WordPress package directly from the [official WordPress website](https://wordpress.org/download/).
     - Unzip and move the WordPress files to the web server's root directory (e.g., `/var/www/html`).

  3. **Configure WordPress**:
     - In the user data script, create a wp-config.php file with database connection details, pointing to your RDS instance.
     - Set necessary file permissions for WordPress to operate correctly.

  4. **Finalize Configuration**:
     - Ensure all necessary security groups are set up to allow traffic to your EC2 instances and RDS database.
     - Verify that WordPress is up and running by accessing your website's URL.

Here is an example of a user data script for installing WordPress directly on an EC2 instance:

```bash
#!/bin/bash
yum update -y
yum install -y httpd php php-mysqlnd
service httpd start
chkconfig httpd on
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress/* .
rmdir wordpress
rm latest.tar.gz
cp wp-config-sample.php wp-config.php
# Replace database details with your RDS configuration
sed -i 's/database_name_here/YOUR_DB_NAME/' wp-config.php
sed -i 's/username_here/YOUR_DB_USER/' wp-config.php
sed -i 's/password_here/YOUR_DB_PASSWORD/' wp-config.php
sed -i 's/localhost/YOUR_RDS_ENDPOINT/' wp-config.php
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html
```

Replace `YOUR_DB_NAME`, `YOUR_DB_USER`, `YOUR_DB_PASSWORD`, and `YOUR_RDS_ENDPOINT` with your actual database details. This script will install Apache, PHP, download WordPress, configure it, and set the required permissions.

This way, you can avoid using an S3 bucket and still deploy WordPress effectively.
