root = "/opt/pwnix/chef"
file_cache_path root
cookbook_path "#{root}/cookbooks"
role_path "#{root}/roles"
log_level :info
log_location STDOUT
