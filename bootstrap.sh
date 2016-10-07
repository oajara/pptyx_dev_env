#!/bin/bash

### Install Ansible in the Vagrant machine

echo "Installing Ansible..."
sudo apt-get install -y software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y --force-yes ansible


### Prepare the data to be loadable on db containers init

echo "Preparing sql date for initial import..."
cd /vagrant/test_db && sed '/^source/d' employees.sql > /vagrant/init_data/init.sql && cat load_departments.dump load_employees.dump load_dept_emp.dump load_dept_manager.dump load_titles.dump load_salaries[1-3].dump >> /vagrant/init_data/init.sql
