# Artificial Instinct Infrastructure - Terraform

This is a modular Terraform infrastructure-as-code project for AWS resources in the ap-south-1 (Mumbai) region.

## Project Structure

```
terraform/
├── provider.tf                 # AWS Provider configuration with S3 backend
├── variables.tf                # Input variables
├── main.tf                     # Main infrastructure module calls
├── outputs.tf                  # Output values
├── terraform.tfvars.example    # Example variables file
└── modules/
    ├── security_group/         # Security Group module
    ├── ec2/                    # EC2 instance module
    ├── rds/                    # RDS database module
    ├── ecr/                    # ECR repositories module
    └── alb/                    # Application Load Balancer module
```

## Prerequisites

1. **AWS Account** with appropriate IAM permissions
2. **Terraform** >= 1.0 installed
3. **AWS CLI** configured with credentials
4. **S3 Bucket** for state locking: `artificial-instinct-bucket`
5. **DynamoDB Table** for state locking: `terraform-locks`
6. **EC2 Key Pair** named: `artificial-instinct-key`

## Setup Instructions

### 1. Create S3 Bucket for State (One-time)

```bash
aws s3api create-bucket \
  --bucket artificial-instinct-bucket \
  --region ap-south-1 \
  --create-bucket-configuration LocationConstraint=ap-south-1
```

### 2. Enable Versioning on S3 Bucket

```bash
aws s3api put-bucket-versioning \
  --bucket artificial-instinct-bucket \
  --versioning-configuration Status=Enabled
```

### 3. Create DynamoDB Table for Locking

```bash
aws dynamodb create-table \
  --table-name terraform-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --region ap-south-1
```

### 4. Create EC2 Key Pair

```bash
aws ec2 create-key-pair \
  --key-name artificial-instinct-key \
  --region ap-south-1 \
  --query 'KeyMaterial' \
  --output text > artificial-instinct-key.pem

chmod 600 artificial-instinct-key.pem
```

### 5. Initialize Terraform

```bash
cd terraform
terraform init
```

### 6. Create terraform.tfvars File

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your specific values
```

### 7. Plan and Apply

```bash
# Review the plan
terraform plan

# Apply the configuration
terraform apply
```

## Infrastructure Components

### 1. **Security Group**
- Ingress Rules: 22 (SSH), 80 (HTTP), 443 (HTTPS), 3000, 8247
- Egress Rules: All traffic allowed

### 2. **EC2 Instance**
- Instance Type: `t4g.medium`
- AMI: Amazon Linux 2
- EBS Volume: 20 GB, GP3
- Public IP: Yes
- Key Pair: `artificial-instinct-key`

### 3. **RDS Database**
- Engine: MySQL 8.0
- Instance Type: `db.t4g.small`
- Storage: 10 GB
- Database Name: `artificial-instinct-db`
- Multi-AZ: No
- Proxy: Disabled
- Enhanced Monitoring: Disabled

### 4. **ECR Repositories**
- `backend/nexus-agent`
- `frontend/co-agent`
- Image Expiration: 30 days
- Tag Mutability: Mutable

### 5. **Application Load Balancer**
- Type: Application Load Balancer
- Internet-Facing: Yes
- Listeners: 80 (HTTP), 443 (HTTPS)
- Target: EC2 instance on port 80

### 6. **VPC**
- Using default VPC in ap-south-1

## Tagging Strategy

All resources are tagged with:
```
Name = "Artificial-Instinct"
```

## State Management

State is stored in S3 bucket with:
- **Bucket**: `artificial-instinct-bucket`
- **Key**: `terraform-state-file/terraform.tfstate`
- **Encryption**: Enabled
- **Versioning**: Enabled
- **Locking**: DynamoDB table `terraform-locks`

## Important Notes

1. **Cost Consideration**: This infrastructure will incur AWS costs. Monitor your usage.
2. **Security**: Change RDS password from default "root" in production.
3. **HTTPS Certificate**: ALB uses self-signed certificate. Replace with valid certificate in production.
4. **Backup**: RDS has 7-day backup retention.
5. **Deletion**: To destroy all resources: `terraform destroy`

## Useful Commands

```bash
# Initialize Terraform
terraform init

# Format code
terraform fmt -recursive

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes
terraform apply

# Destroy infrastructure
terraform destroy

# Show outputs
terraform output

# State management
terraform state list
terraform state show aws_instance.main
terraform refresh
```

## Outputs

After applying, you can retrieve outputs with:

```bash
terraform output ec2_instance_public_ip
terraform output rds_instance_endpoint
terraform output alb_dns_name
terraform output ecr_repository_urls
```

## Troubleshooting

### Backend Error
If you get S3 backend errors, ensure:
- S3 bucket exists and is accessible
- DynamoDB table exists
- AWS credentials have proper permissions

### EC2 Key Pair Error
Ensure the key pair `artificial-instinct-key` exists in ap-south-1

### ALB Certificate Error
Self-signed certificate is created for testing. For production, use a valid certificate from ACM.

## Security Best Practices

1. ✅ State file encryption enabled
2. ✅ EBS volume encryption enabled
3. ✅ RDS encryption enabled
4. ✅ Security groups with restricted access
5. ✅ No public RDS endpoint
6. ⚠️ Update RDS password before production
7. ⚠️ Use valid SSL certificates for ALB in production

## Support

For issues or questions, refer to:
- Terraform Documentation: https://www.terraform.io/docs
- AWS Documentation: https://docs.aws.amazon.com/
