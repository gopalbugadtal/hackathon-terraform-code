# Artificial Instinct Infrastructure - Terraform

This is a modular Terraform infrastructure-as-code project for AWS resources in the ap-south-1 (Mumbai) region.

## Prerequisites

1. **AWS Account** with appropriate IAM permissions
2. **Terraform** 
3. **S3 Bucket** for state locking: `artificial-instinct-bucket`
4. **EC2 Key Pair** named: `artificial-instinct-key`

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

## Terraform Commands

```bash
# Initialize Terraform
cd terraform
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

## Troubleshooting

### Backend Error
If you get S3 backend errors, ensure:
- S3 bucket exists and is accessible
- AWS credentials have proper permissions

### EC2 Key Pair Error
Ensure the key pair `artificial-instinct-key` exists in ap-south-1

## Security Best Practices

1. ✅ State file encryption enabled
2. ✅ EBS volume encryption enabled
4. ✅ Security groups with restricted access

## Support

For issues or questions, refer to:
- Terraform Documentation: https://www.terraform.io/docs
- AWS Documentation: https://docs.aws.amazon.com/
