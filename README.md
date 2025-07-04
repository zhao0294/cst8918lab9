# CST8918 - DevOps: Infrastructure as Code
## Lab 9: Hybrid-A09 Husky and GitHub Actions

This project demonstrates a CI/CD pipeline for Infrastructure as Code (IaC) using Terraform, Husky pre-commit hooks, and GitHub Actions.

### Project Structure

```
Lab9/
├── infrastructure/
│   └── main.tf              # Terraform script for Azure resources
├── .github/
│   └── workflows/
│       └── action-terraform-verify.yml  # GitHub Actions workflow
├── .husky/
│   └── pre-commit          # Husky pre-commit hook
├── package.json            # Node.js project configuration
└── README.md              # This file
```

### Prerequisites

- Node.js and npm installed
- Terraform installed
- Azure CLI installed and configured
- Git repository initialized

### Setup Instructions

1. **Initialize the Node.js project and install Husky:**
   ```bash
   npm install
   npx husky-init
   ```

2. **Configure the pre-commit hook:**
   ```bash
   echo "terraform fmt -check -recursive" > .husky/pre-commit
   echo "terraform validate" >> .husky/pre-commit
   echo "tflint" >> .husky/pre-commit
   ```

3. **Make the pre-commit hook executable:**
   ```bash
   chmod +x .husky/pre-commit
   ```

### Terraform Resources

The Terraform script in `infrastructure/main.tf` creates:
- Azure Resource Group
- Azure Storage Account (with random naming)
- Random string generator for unique naming

### CI/CD Pipeline

#### Pre-commit Hooks (Husky)
- **terraform fmt -check -recursive**: Ensures proper formatting
- **terraform validate**: Validates syntax and configuration
- **tflint**: Lints Terraform code for best practices

#### GitHub Actions Workflow
The workflow in `.github/workflows/action-terraform-verify.yml` includes:

1. **Format Validation Job**: Checks Terraform formatting on changed files
2. **Terraform Validation Job**: 
   - Initializes Terraform
   - Validates configuration
   - Creates a plan

### Testing the Pipeline

#### Test Pre-commit Hook
1. Make formatting changes to `infrastructure/main.tf`
2. Try to commit: `git commit -m "test formatting"`
3. The hook should prevent the commit
4. Fix formatting and commit again

#### Test GitHub Actions
1. Make changes and commit with `--no-verify` to bypass pre-commit:
   ```bash
   git commit --no-verify -m "test github actions"
   ```
2. Create a pull request
3. The GitHub Actions workflow should run and validate the changes

### Azure Authentication

To deploy the Terraform resources, you'll need to authenticate with Azure:

```bash
az login
az account set --subscription <your-subscription-id>
```

### Commands

- **Initialize Terraform**: `cd infrastructure && terraform init`
- **Validate Terraform**: `cd infrastructure && terraform validate`
- **Format Terraform**: `cd infrastructure && terraform fmt`
- **Plan Terraform**: `cd infrastructure && terraform plan`
- **Apply Terraform**: `cd infrastructure && terraform apply`

### Notes

- The GitHub Actions workflow runs on pull requests to main/master branches
- The workflow uses Terraform version 1.2.4
- All Azure resources are tagged with Environment and Project tags
- The storage account name includes a random string to ensure uniqueness 