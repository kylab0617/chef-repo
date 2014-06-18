case node[:platform]
  when "fedora", "centos"
    execute "install nginx repository" do
      command "rpm -i http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm"
      # not_if { ::File.exists?("/tmp/#{rpm}")}
      ignore_failure true
    end
    yum_package "nginx"
  when "ubuntu"
    apt_package "nginx" do
      action :install
    end
end

service "nginx" do
  action [ :enable, :start ]
end

template "/usr/share/nginx/html/index.html" do
  source "index.html.erb"
  action :create
  mode "664"
end

if node['hostname'] == "puppy" 
  group "puppy" do
    action :create
  end
  
  user "puppy" do
    action :create
    gid "puppy"
  end
  
  cookbook_file "/usr/share/nginx/html/puppy.jpg" do
    source "puppy.jpg"
    action :create
    owner "puppy"
    group "puppy"
    mode "664"
  end
#end
else
#if node['hostname'] == "kitty" 
  group "kitty" do
    action :create
  end

  user "kitty" do
    action :create
    gid "kitty"
  end
  
  cookbook_file "/usr/share/nginx/html/kitty.jpg" do
    source "kitty.jpg"
    action :create
    owner "kitty"
    group "kitty"
    mode "664"
  end
end
