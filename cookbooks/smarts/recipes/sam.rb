#
# Cookbook Name:: smarts
# Recipe:: sam
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

install_media_file = "setup-SAM-9_2_1_0-linux64.bin"
response_file = "SAM_SUITE-response.txt"
product_name = "SAM"

template "SAM_SUITE-response.txt" do
  path "#{Chef::Config[:file_cache_path]}/#{response_file}"
  source "smarts.samSuite.erb"
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
#    ./#{install_media_file} -is:javahome -options #{Chef::Config[:file_cache_path]}/#{response_file}
    ./#{install_media_file} -is:log ./sam.log -is:tempdir #{Chef::Config[:file_cache_path]} -options #{Chef::Config[:file_cache_path]}/#{response_file}
  EOH
  creates "/opt/InCharge/SAM/smarts/bin/sm_server"
end
