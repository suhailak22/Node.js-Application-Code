# Use an official Python runtime as a base image
FROM almalinux

# Set the working directory in the container
WORKDIR /usr/src/app/

# Copy the requirements.txt file into the container

COPY main.py main.py
RUN yum update -y

RUN yum install -y gcc
RUN yum install -y sudo
RUN yum install -y gnupg2
RUN sudo dnf install openssl-devel bzip2-devel libffi-devel -y
RUN sudo dnf groupinstall "Development Tools" -y
RUN sudo yum install python3.11 -y
RUN yum install epel-release -y
RUN yum install python-pip -y
RUN yum install python3-pip -y
RUN pip3 install streamlit
RUN pip3 install langchain
RUN pip3 install torch
RUN pip3 install networkx
RUN pip3 install pandas

# Install gcsfuse

RUN sudo yum install -y fuse 
RUN sudo tee /etc/yum.repos.d/gcsfuse.repo > /dev/null <<EOF
[gcsfuse]
name=gcsfuse (packages.cloud.google.com)
baseurl=https://packages.cloud.google.com/yum/repos/gcsfuse-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
      https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
RUN yum install gcsfuse -y



# Copy the GCP service account key into the Docker image

COPY "key2.json" "service-account-key.json"

# Set the GOOGLE_APPLICATION_CREDENTIALS environment variable

ENV GOOGLE_APPLICATION_CREDENTIALS="/usr/src/app/key.json"
RUN mkdir test
# Index of /apt//
# Install any needed packages specified in requirements.txt
##RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the current directory contents into the container
##COPY . .

# Run script.py when the container launches
##CMD ["python", "./embed_script.py"]
