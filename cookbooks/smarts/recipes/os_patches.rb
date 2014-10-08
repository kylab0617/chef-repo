#
# Cookbook Name:: smarts
# Recipe:: os_patches
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "file" 
package "bc"
package "glibc-common >= 2.2.4-32"

case node[:platform]
when "redhat", "fedora", "centos"
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
else
  raise "OS not supported for EMC Smarts Installation."   
end
