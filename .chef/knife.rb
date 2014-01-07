<<<<<<< HEAD
current_dir = File.dirname(__FILE__)
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
log_level                :info
log_location             STDOUT
node_name                'oluetkeh'
client_key               "#{current_dir}/oluetkeh.pem"
validation_client_name   'chef-validator'
validation_key           "#{current_dir}/chef-validator.pem"
chef_server_url          'https://sinefo'
syntax_check_cache_path  "#{current_dir}/syntax_check_cache"
=======
log_level                :info
log_location             STDOUT
node_name                'oluetkeh'
client_key               '/home/oluetkeh/chef-repo/.chef/oluetkeh.pem'
validation_client_name   'chef-validator'
validation_key           '/home/oluetkeh/chef-repo/.chef/chef-validator.pem'
chef_server_url          'https://sinefo'
syntax_check_cache_path  '/home/oluetkeh/chef-repo/.chef/syntax_check_cache'
cookbook_path [ '/home/oluetkeh/chef-repo/cookbooks' ]
>>>>>>> 25a33c42826baa76f1167c6661193a4d9a726c59
