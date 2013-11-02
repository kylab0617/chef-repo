#
# Cookbook Name:: smarts
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

install_media_file = "setup-SAM-9_2_1_0-linux64.bin"
response_file = "SAM_CONSOLE_SUITE-response.txt"

yum_package "glibc >= 2.2.4-32.i386"
yum_package "glibc >= 2.2.4-32.x86_64"
yum_package "glibc-common >= 2.2.4-32"
yum_package "icompat-libstdc++-33 >= 3.2.3-47.3.i686"
yum_package "icompat-libstdc++-33 >= 3.2.3-47.3.x86_64"

template "SAM_CONSOLE_SUITE-response.txt" do
  path "#{Chef::Config[:file_cache_path]}/SAM_CONSOLE_SUITE-response.txt"
  source "smarts.samConsoleSuite.erb"
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

bash "Smarts Console Suite Silent Install" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
#    ./#{install_media_file} -is:javahome -options #{Chef::Config[:file_cache_path]}/#{response_file}
    ./#{install_media_file} -is:log ./sam.log -options #{Chef::Config[:file_cache_path]}/#{response_file}
  EOH
#  creates "/usr/local/bin/...."
end
