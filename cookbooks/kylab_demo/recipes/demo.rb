apt_package "nginx" do
  action :install
end

service "nginx" do
  action [ :enable, :start ]
end

template "/usr/share/nginx/www/index.html" do
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
  
  cookbook_file "/usr/share/nginx/www/puppy.jpg" do
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
  
  cookbook_file "/usr/share/nginx/www/kitty.jpg" do
    source "kitty.jpg"
    action :create
    owner "kitty"
    group "kitty"
    mode "664"
  end
end
