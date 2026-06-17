yum install python3.11-devel python3.11-pip -y
pip3.11 install ansible botocore boto3
cd /tmp
ansible-pull -U https://github.com/jana-tech0/ansible-roboshop-roles-tf.git -e component=catalogue -e app_version=$APP_VERSION -e env=$ENVIRONMENT main.yaml