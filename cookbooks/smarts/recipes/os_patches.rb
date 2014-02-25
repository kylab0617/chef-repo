#
# Cookbook Name:: smarts
# Recipe:: os_patches
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

centos_mirror = "ftp://ftp.muug.mb.ca"
rpm_loc_x86_64 = "/mirror/centos/6/os/x86_64/Packages"
rpm_loc_386 = "/mirror/centos/6/os/i386/Packages"

case node[:platform]
when "redhat"
    rpm = "bc-1.06.95-1"
    execute "install rpm #{rpm}" do
      command "rpm -i --force #{centos_mirror}#{rpm_loc_x86_64}/#{rpm}.el6.x86_64.rpm"
      # not_if { ::File.exists?("/tmp/#{rpm}")}
      ignore_failure true
    end
    %w{glibc-2.12-1.107 
       compat-libstdc++-33-3.2.3-69
       libstdc++-4.4.7-3   
       libXau-1.0.6-4
       libxcb-1.8.1-1
       libX11-1.5.0-4
       libXext-1.3.1-2
       libXi-1.6.1-3
       libXtst-1.2.1-2}.each do |rpm|
      execute "install rpm #{rpm}" do
        command "rpm -i --force #{centos_mirror}#{rpm_loc_x86_64}/#{rpm}.el6.x86_64.rpm"
        # not_if { ::File.exists?("/tmp/#{rpm}")}
        ignore_failure true
      end
      execute "install rpm #{rpm}" do
        command "rpm -i --force #{centos_mirror}#{rpm_loc_x86_64}/#{rpm}.el6.i686.rpm"
        # not_if { ::File.exists?("/tmp/#{rpm}")}
        ignore_failure true
      end    
      # package rpm do
      #   action :install
      #   source "#{centos_mirror}#{rpm_loc_x86_64}/#{rpm}.el6.x86_64.rpm"
      #   provider Chef::Provider::Package::Rpm
      #   options "--force-yes"
      #   ignore_failure true
      # end
      # package rpm do
      #   action :install
      #   source "#{centos_mirror}#{rpm_loc_386}/#{rpm}.el6.i686.rpm"
      #   provider Chef::Provider::Package::Rpm
      #   options "--force-yes"
      #   ignore_failure true
      # end
    end
when "fedora", "centos"
  yum_package "bc"
  yum_package "glibc" do
    version "2.2.4-32"  
    arch "i686" 
    action :upgrade
  end
  yum_package "glibc" do
    version "2.2.4-32"  
    arch "x86_64" 
    action :upgrade
  end
  yum_package "glibc-common >= 2.2.4-32"
  yum_package "compat-libstdc++-33" do
    version "3.2.3-47.3"  
    arch "x86_64" 
    action :upgrade
  end
  yum_package "compat-libstdc++-33" do
    version "3.2.3.-47.3" 
    arch "i686" 
    action :upgrade
  end
  yum_package "libstdc++" do
    version "4.4.6-3.el6" 
    arch "i686" 
    action :upgrade
  end
  yum_package "libXi" do
    version "1.3-3.el6" 
    arch "i686" 
    action :upgrade
  end
  yum_package "libXext" do
    version "1.1-3.el6" 
    arch "i686" 
    action :upgrade
  end
  yum_package "libXtst" do
    version "1.0.99.2-3.el6" 
    arch "i686" 
    action :upgrade
  end
end

=begin
#yum_package "glibc >= 2.2.4-32.i386"
#yum_package "glibc.i386"
#yum_package "glibc >= 2.2.4-32.x86_64"
#yum_package "glibc.x86_64"
#yum_package "glibc-common >= 2.2.4-32"
#yum_package "glibc-common"
#yum_package "compat-libstdc++-33 >= 3.2.3-47.3.i686"
#yum_package "compat-libstdc++-33.i686"
#yum_package "compat-libstdc++-33 >= 3.2.3-47.3.x86_64"
#yum_package "compat-libstdc++-33.x86_64"


=end
