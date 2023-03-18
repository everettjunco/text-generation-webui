#!/bin/bash

# Download miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh

# Install miniconda
bash miniconda.sh -b -p $CONDA_PATH

# Remove miniconda installer
rm miniconda.sh

# Clean conda
conda clean -a -y

# Create symlink for conda
ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh

# Update .bashrc
echo ". $CONDA_PATH/etc/profile.d/conda.sh" >> ~/.bashrc
echo "conda activate base" >> ~/.bashrc
