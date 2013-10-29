#
# Cookbook Name:: uhn_post_provision
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
windows_zipfile "c:/temp/mcafee" do
  source "http://192.168.1.123/DSL/McAfee/McAfee_Virus_Scan_v8.8.zip"
  action :unzip
  not_if {::File.exists?("c:/temp/mcafee/McAfee_Virus_Scan_v8.8/vcredist_x86.exe")}
  not_if {::File.exists?("C:/Program Files/Common Files/McAfee/SystemCore/mcshield.exe")}
end

windows_batch "install McAfee" do
  code <<-EOH
  cd c:/temp/mcafee/McAfee_Virus_Scan_v8.8
  SetupVSE.exe ADDLOCAL=ALL REBOOT=R  /q
  EOH
  not_if {::File.exists?("C:/Program Files/Common Files/McAfee/SystemCore/mcshield.exe")}
end