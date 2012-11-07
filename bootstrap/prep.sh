#!/usr/bin/env bash

JSON="${1}"

# Work around annoying debconf bug
# https://bugs.launchpad.net/ubuntu/+source/debconf/+bug/130519
DEBIAN_FRONTEND=noninteractive

# Verify we are root
if [[ $EUID -ne 0 ]]; then
   echo "[-] This script must be run as root, exiting."
   exit 1
fi

if ! [ -f /opt/chef/bootstrap.sh ]; then 
  echo "[+] First run detected. Bootstrapping system with Pwnix dependencies."

  ###
  ### Update the system and install package deps
  ###
  apt-get -y install build-essential
  apt-get -y install ruby1.9.3
  apt-get -y install git
  gem install bundler --no-ri --no-rdoc
else
  echo "[+] Skipping chef install - system has been bootstrapped."
fi

###
### Return to the chef directory
###
cd /opt/chef

###
### Install dependencies (including latest chef gem)
###
#(remove any local / copied bundle first)
rm -rf .bundle/ruby
bundle install

###
### Run chef-solo on server
###
bundle exec chef-solo --config bootstrap/prod.rb --JSON-attributes "$JSON"
