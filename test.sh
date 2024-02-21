#!/bin/bash

# Script to create a Python virtual environment

# Name of the virtual environment directory
VENV_DIR="test"

# Check for Python installation
if ! command -v python3 &> /dev/null
then
    echo "Python 3 is not installed. Please install it first."
    exit 1
fi

# Check for virtualenv installation
if ! command -v virtualenv &> /dev/null
then
    echo "virtualenv is not installed. Installing virtualenv..."
    pip3 install virtualenv
    if [ $? -ne 0 ]; then
        echo "Failed to install virtualenv. Please install it manually."
        exit 1
    fi
fi

# Create the virtual environment
echo "Creating virtual environment in ./$VENV_DIR"
virtualenv -p python3 $VENV_DIR

# Check if virtual environment creation was successful
if [ $? -eq 0 ]; then
    echo "Virtual environment created successfully."
else
    echo "Failed to create virtual environment."
    exit 1
fi

# Optional: Activate the virtual environment
command source $VENV_DIR/bin/activate

