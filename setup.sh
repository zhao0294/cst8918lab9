#!/bin/bash

echo "Setting up CST8918 Lab 9 - DevOps Infrastructure as Code project..."

# Check if Node.js and npm are installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

echo "✅ Node.js and npm are installed"

# Install dependencies
echo "📦 Installing npm dependencies..."
npm install

# Initialize Husky
echo "🐕 Initializing Husky..."
npx husky-init

# Configure pre-commit hook
echo "🔧 Configuring pre-commit hook..."
echo "terraform fmt -check -recursive" > .husky/pre-commit
echo "terraform validate" >> .husky/pre-commit
echo "tflint" >> .husky/pre-commit

# Make pre-commit hook executable
chmod +x .husky/pre-commit

echo "✅ Pre-commit hook configured"

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "⚠️  Terraform is not installed. Please install Terraform to use the infrastructure code."
else
    echo "✅ Terraform is installed"
    
    # Initialize Terraform
    echo "🔧 Initializing Terraform..."
    cd infrastructure
    terraform init
    cd ..
fi

# Check if TFLint is installed
if ! command -v tflint &> /dev/null; then
    echo "⚠️  TFLint is not installed. Please install TFLint for linting."
    echo "   Installation: https://github.com/terraform-linters/tflint#installation"
else
    echo "✅ TFLint is installed"
fi

echo ""
echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Initialize git repository: git init"
echo "2. Add files: git add ."
echo "3. Make initial commit: git commit -m 'Initial commit'"
echo "4. Create GitHub repository and push your code"
echo "5. Test the pre-commit hook by making formatting changes"
echo "6. Create a pull request to test GitHub Actions" 