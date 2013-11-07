#
# Cookbook Name:: smarts
# Recipe:: console
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

product_name = "CONSOLE"
install_media_file = "setup-#{product_name}-9_2_1_0-linux64.bin"
response_file = "#{product_name}-response.txt"
install_root_dir = node['smarts']['gereral']['install_root_dir']
marker_file_name = "#{install_root_dir}/#{product_name}/smarts/bin/sm_server"

template "#{response_file}" do
  path "#{Chef::Config[:file_cache_path]}/#{response_file}"
  source "smarts.#{product_name}.erb"
  owner "root"
  group "root"
  mode "0644"
end

remote_file "#{Chef::Config[:file_cache_path]}/#{install_media_file}" do
  source "http://192.168.1.123/DSL/SMARTS/#{install_media_file}"
  owner "root"
  group "root"
  mode "0700"
  action :create_if_missing
end

bash "Smarts #{product_name} Silent Install" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    ./#{install_media_file} -is:log #{Chef::Config[:file_cache_path]}/#{product_name}.log -is:tempdir #{Chef::Config[:file_cache_path]} -options #{Chef::Config[:file_cache_path]}/#{response_file}
  EOH
  creates "#{marker_file_name}"
end

execute "check #{product_name} service" do
      command "#{marker_file_name} --version > #{Chef::Config[:file_cache_path]}/#{product_name}-result.log"
end

log "#{product_name} install completed."