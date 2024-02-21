#!/bin/bash

# Script to create a Python virtual environment

# Name of the virtual environment directory
VENV_DIR="test"

# Check for Python installation
if ! command -v python3 &> /dev/null; then
    echo "Python 3 is not installed. Please install it first."
    exit 1
fi

# Use Python's built-in venv module to create a virtual environment
echo "Creating virtual environment in ./$VENV_DIR"
python3 -m venv $VENV_DIR

# Check if virtual environment creation was successful
if [ $? -eq 0 ]; then
    echo "Virtual environment created successfully."
else
    echo "Failed to create virtual environment."
    exit 1
fi

# Inform the user on how to activate the virtual environment
echo "To activate the virtual environment, run: source $VENV_DIR/bin/activate"
