#!/bin/bash

echo "🧪 Testing CST8918 Lab 9 Setup..."

# Test 1: Check if all required files exist
echo "📁 Checking project structure..."
required_files=(
    "infrastructure/main.tf"
    ".github/workflows/action-terraform-verify.yml"
    "package.json"
    "README.md"
    ".gitignore"
    ".tflint.hcl"
    "setup.sh"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file exists"
    else
        echo "❌ $file missing"
    fi
done

# Test 2: Check if Husky is installed
echo ""
echo "🐕 Checking Husky installation..."
if [ -d ".husky" ]; then
    echo "✅ Husky directory exists"
    if [ -f ".husky/pre-commit" ]; then
        echo "✅ Pre-commit hook exists"
        if [ -x ".husky/pre-commit" ]; then
            echo "✅ Pre-commit hook is executable"
        else
            echo "❌ Pre-commit hook is not executable"
        fi
    else
        echo "❌ Pre-commit hook missing"
    fi
else
    echo "❌ Husky directory missing"
fi

# Test 3: Check Terraform formatting
echo ""
echo "🔧 Testing Terraform formatting..."
if command -v terraform &> /dev/null; then
    cd infrastructure
    if terraform fmt -check -recursive; then
        echo "✅ Terraform formatting is correct"
    else
        echo "❌ Terraform formatting issues found"
    fi
    cd ..
else
    echo "⚠️  Terraform not installed"
fi

# Test 4: Check Terraform validation
echo ""
echo "✅ Testing Terraform validation..."
if command -v terraform &> /dev/null; then
    cd infrastructure
    if terraform init -backend=false > /dev/null 2>&1; then
        if terraform validate; then
            echo "✅ Terraform validation passed"
        else
            echo "❌ Terraform validation failed"
        fi
    else
        echo "❌ Terraform init failed"
    fi
    cd ..
else
    echo "⚠️  Terraform not installed"
fi

# Test 5: Check TFLint
echo ""
echo "🔍 Testing TFLint..."
if command -v tflint &> /dev/null; then
    if tflint; then
        echo "✅ TFLint passed"
    else
        echo "❌ TFLint failed"
    fi
else
    echo "⚠️  TFLint not installed"
fi

# Test 6: Check GitHub Actions workflow syntax
echo ""
echo "⚡ Checking GitHub Actions workflow..."
if [ -f ".github/workflows/action-terraform-verify.yml" ]; then
    echo "✅ GitHub Actions workflow file exists"
    # Basic YAML syntax check
    if python3 -c "import yaml; yaml.safe_load(open('.github/workflows/action-terraform-verify.yml'))" 2>/dev/null; then
        echo "✅ GitHub Actions workflow YAML syntax is valid"
    else
        echo "❌ GitHub Actions workflow YAML syntax error"
    fi
else
    echo "❌ GitHub Actions workflow file missing"
fi

echo ""
echo "🎯 Test Summary:"
echo "If you see mostly ✅ marks, your setup is ready!"
echo "If you see ❌ marks, please fix those issues before proceeding."
echo ""
echo "Next steps:"
echo "1. Initialize git: git init"
echo "2. Add files: git add ."
echo "3. Commit: git commit -m 'Initial commit'"
echo "4. Create GitHub repo and push"
echo "5. Test pre-commit hook with formatting changes"
echo "6. Create PR to test GitHub Actions" 