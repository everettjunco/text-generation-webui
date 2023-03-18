#!/bin/bash

# Clone the PyTorch repository
git clone --recursive https://github.com/pytorch/pytorch

# Change to the PyTorch directory
cd pytorch

# Checkout the desired version (e.g., v1.10.0)
git checkout v1.10.0
git submodule sync
git submodule update --init --recursive

# Create a Python virtual environment (optional)
python -m venv venv
source venv/bin/activate

# Install Python dependencies
pip install -r requirements.txt

# Set the environment variables for the build
export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
export USE_CUDA=1
export USE_CUDNN=1
export USE_NCCL=1

# Build PyTorch
python setup.py install

# Test your installation (optional)
cd ..
git clone --recursive https://github.com/pytorch/vision
cd vision
python setup.py install
python -c "import torch; print('CUDA available:', torch.cuda.is_available()); print('Version:', torch.__version__)"
