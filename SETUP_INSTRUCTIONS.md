# CST8918 Lab 9 - Complete Setup Instructions

## 🎯 Project Overview

This project implements a complete CI/CD pipeline for Infrastructure as Code using:
- **Terraform** for Azure resource management
- **Husky** for pre-commit hooks
- **GitHub Actions** for automated validation
- **TFLint** for code linting

## 📁 Project Structure Created

```
Lab9/
├── infrastructure/
│   └── main.tf                    # Terraform script (Azure RG + Storage Account)
├── .github/
│   └── workflows/
│       └── action-terraform-verify.yml  # GitHub Actions workflow
├── .husky/                        # Will be created by setup script
│   └── pre-commit                 # Pre-commit hook
├── package.json                   # Node.js project config
├── .gitignore                     # Git ignore rules
├── .tflint.hcl                    # TFLint configuration
├── setup.sh                       # Automated setup script
├── test-setup.sh                  # Verification script
├── README.md                      # Project documentation
└── SETUP_INSTRUCTIONS.md          # This file
```

## 🚀 Step-by-Step Setup

### 1. Prerequisites Installation

Install the required tools:

```bash
# Install Node.js and npm (if not already installed)
# Visit: https://nodejs.org/

# Install Terraform
# Visit: https://developer.hashicorp.com/terraform/downloads

# Install TFLint
# Visit: https://github.com/terraform-linters/tflint#installation

# Install Azure CLI (for deployment)
# Visit: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli
```

### 2. Run Automated Setup

```bash
# Make setup script executable and run it
chmod +x setup.sh
./setup.sh
```

This script will:
- Install npm dependencies
- Initialize Husky
- Configure pre-commit hooks
- Initialize Terraform
- Verify installations

### 3. Verify Setup

```bash
# Run the test script to verify everything is working
chmod +x test-setup.sh
./test-setup.sh
```

### 4. Initialize Git Repository

```bash
# Initialize git repository
git init

# Add all files
git add .

# Make initial commit
git commit -m "Initial commit: CST8918 Lab 9 - DevOps Infrastructure as Code"
```

### 5. Create GitHub Repository

1. Go to GitHub and create a new repository
2. Push your local repository to GitHub:

```bash
git remote add origin <your-github-repo-url>
git branch -M main
git push -u origin main
```

## 🧪 Testing the Pipeline

### Test 1: Pre-commit Hook (Husky)

1. **Create a formatting error** in `infrastructure/main.tf`:
   ```bash
   # Add extra spaces or remove proper indentation
   echo "  resource \"azurerm_resource_group\" \"rg\" {" >> infrastructure/main.tf
   ```

2. **Try to commit** (should fail):
   ```bash
   git add infrastructure/main.tf
   git commit -m "test formatting error"
   ```

3. **Fix the formatting**:
   ```bash
   cd infrastructure
   terraform fmt
   cd ..
   ```

4. **Commit again** (should succeed):
   ```bash
   git add infrastructure/main.tf
   git commit -m "fixed formatting"
   ```

### Test 2: GitHub Actions Workflow

1. **Create a new branch**:
   ```bash
   git checkout -b test-github-actions
   ```

2. **Make a formatting error** and commit with `--no-verify`:
   ```bash
   # Add formatting error to main.tf
   git add infrastructure/main.tf
   git commit --no-verify -m "test github actions with formatting error"
   ```

3. **Push and create Pull Request**:
   ```bash
   git push origin test-github-actions
   ```

4. **Create Pull Request** on GitHub from `test-github-actions` to `main`

5. **Check GitHub Actions** - the workflow should fail due to formatting issues

6. **Fix the formatting** and push again:
   ```bash
   cd infrastructure
   terraform fmt
   cd ..
   git add infrastructure/main.tf
   git commit -m "fixed formatting for github actions"
   git push origin test-github-actions
   ```

7. **Check GitHub Actions** - the workflow should now pass

## 🔧 Manual Setup (Alternative)

If the automated setup doesn't work, follow these manual steps:

### 1. Initialize Node.js Project
```bash
npm init -y
npm install husky --save-dev
```

### 2. Initialize Husky
```bash
npx husky-init
```

### 3. Configure Pre-commit Hook
```bash
echo "terraform fmt -check -recursive" > .husky/pre-commit
echo "terraform validate" >> .husky/pre-commit
echo "tflint" >> .husky/pre-commit
chmod +x .husky/pre-commit
```

### 4. Initialize Terraform
```bash
cd infrastructure
terraform init
cd ..
```

## 📋 What the Pipeline Does

### Pre-commit Hook (.husky/pre-commit)
- **terraform fmt -check -recursive**: Ensures proper formatting
- **terraform validate**: Validates syntax and configuration
- **tflint**: Lints code for best practices

### GitHub Actions Workflow (.github/workflows/action-terraform-verify.yml)
1. **Format Validation Job**: Checks formatting on changed Terraform files
2. **Terraform Validation Job**: 
   - Initializes Terraform
   - Validates configuration
   - Creates a plan

## 🎓 Learning Objectives Met

✅ **Simple Terraform script** - Creates Azure Resource Group and Storage Account  
✅ **Code formatting** - Husky pre-commit hooks with terraform fmt  
✅ **Code validation** - terraform validate and tflint  
✅ **GitHub Actions workflow** - Automated CI/CD pipeline  
✅ **Testing** - Both pre-commit hooks and GitHub Actions  

## 🚨 Troubleshooting

### Common Issues:

1. **Husky not working**: Make sure `.husky/pre-commit` is executable
2. **Terraform not found**: Install Terraform and add to PATH
3. **TFLint not found**: Install TFLint and add to PATH
4. **GitHub Actions failing**: Check YAML syntax and workflow permissions

### Useful Commands:

```bash
# Check Terraform formatting
terraform fmt -check -recursive

# Format Terraform files
terraform fmt -recursive

# Validate Terraform
terraform validate

# Run TFLint
tflint

# Test pre-commit hook manually
.husky/pre-commit
```

## 📝 Submission

Submit the URL of your GitHub repository that contains:
- ✅ Working Terraform script
- ✅ Husky pre-commit hooks
- ✅ GitHub Actions workflow
- ✅ Successful pipeline tests 