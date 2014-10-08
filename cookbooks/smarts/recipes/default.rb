
include_recipe "smarts::os_patches"

customerId        = node['smarts']['gereral']['customerId']
product_version   = node['smarts']['gereral']['version']
product_os        = node['smarts']['gereral']['os']
media_location    = node['smarts']['gereral']['repo']
install_root_dir  = node['smarts']['gereral']['install_root_dir']

###Install products and create install scripts for selected services 
%w{SAM CONSOLE IP ESM NPM VoIP}.each do |product_name|
  doInstall("#{product_name}", "#{customerId}", "#{product_version}", "#{product_os}", "#{media_location}", "#{install_root_dir}")
end 

###Start service daemon
service "ic-serviced" do
  pattern "sm_serviced"
  action :start
end

#Create various configuration files 
product_name = "SAM"
template "clientConnect" do
  path "#{install_root_dir}/#{product_name}/smarts/local/conf/clientConnect.conf"
  source "#{product_name}.smarts.local.conf.clientConnect.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end
template "serverConnect" do
  path "#{install_root_dir}/#{product_name}/smarts/local/conf/serverConnect.conf"
  source "#{product_name}.smarts.local.conf.serverConnect.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "ATG notifier conf" do
  path "#{install_root_dir}/#{product_name}/smarts/local/conf/notifier/script-notify-ATG.conf"
  source "#{product_name}.smarts.local.conf.notifier.script-notify-ATG.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end
template "ATG notification list" do
  path "#{install_root_dir}/#{product_name}/smarts/local/conf/ics/nlconfig-#{customerId}-ATG.xml"
  source "#{product_name}.smarts.local.conf.nlconfig-cust-ATG.xml.erb"
  owner "root"
  group "root"
  mode "0644"
end
template "Script to execute for ATG notifications" do
  path "#{install_root_dir}/#{product_name}/smarts/local/actions/Script-#{customerId}-ATG.sh"
  source "#{product_name}.smarts.local.actions.Script-cust-ATG.sh.erb"
  owner "root"
  group "root"
  mode "0755"
end
template "test script to generate notifications" do
  path "#{install_root_dir}/#{product_name}/smarts/local/actions/notifyTests.sh"
  source "#{product_name}.smarts.local.actions.notifyTests.sh.erb"
  owner "root"
  group "root"
  mode "0755"
end

product_name = "ESM"
template "ESM conf" do
  path "#{install_root_dir}/#{product_name}/smarts/local/conf/esm/ESM.conf"
  source "#{product_name}.smarts.local.conf.esm.cust-ESM.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end


#execute install scripts for SAM services in specific order (i.e. SAM first)
#make sure there's a template file install-cust-<PRODUCT>-<SERVICE>.sh.erb for each service
product_name = "SAM"
%w{SAM OI TRAP TRAP-EXP TRAP-RCV UIM ATG}.each do |service_type|
  #check if service is activated for this installation
  if node['smarts'].include?("#{product_name}") &&
    node['smarts']["#{product_name}"].include?("service") &&
    node['smarts']["#{product_name}"]["service"].include?("#{service_type}") &&
    node['smarts']["#{product_name}"]["service"]["#{service_type}"].include?("active") &&
    node['smarts']["#{product_name}"]["service"]["#{service_type}"]["active"] == "true"

    execute "Execute install scripts for service #{service_type} of #{product_name}" do
      scriptName="#{install_root_dir}/#{product_name}/smarts/local/conf/install-#{customerId}-#{product_name}-#{service_type}.sh"
      command "echo executing #{scriptName}; #{scriptName}"
      not_if "#{install_root_dir}/#{product_name}/smarts/sm_service show #{customerId}-#{service_type} | grep #{customerId}-#{service_type}"
    end
  end
end

#execute install scripts for NPM services in specific order 
#make sure there's a template file install-cust-<PRODUCT>-<SERVICE>.sh.erb for each service
product_name = "NPM"
%w{BGP EIGRP ISIS OSPF}.each do |service_type|
  #check if service is activated for this installation
  if node['smarts'].include?("#{product_name}") &&
    node['smarts']["#{product_name}"].include?("service") &&
    node['smarts']["#{product_name}"]["service"].include?("#{service_type}") &&
    node['smarts']["#{product_name}"]["service"]["#{service_type}"].include?("active") &&
    node['smarts']["#{product_name}"]["service"]["#{service_type}"]["active"] == "true"

    execute "Execute install scripts for service #{service_type} of #{product_name}" do
      scriptName="#{install_root_dir}/#{product_name}/smarts/local/conf/install-#{customerId}-#{product_name}-#{service_type}.sh"
      command "echo executing #{scriptName}; #{scriptName}"
      not_if "#{install_root_dir}/#{product_name}/smarts/sm_service show #{customerId}-#{service_type} | grep #{customerId}-#{service_type}"
    end
  end
end

#execute install scripts for IP services in specific order 
#make sure there's a template file install-cust-<PRODUCT>-<SERVICE>.sh.erb for each service
product_name = "IP"
%w{AM PM AMPM CM}.each do |service_type|
  #check if service is activated for this installation
  if node['smarts'].include?("#{product_name}") &&
    node['smarts']["#{product_name}"].include?("service") &&
    node['smarts']["#{product_name}"]["service"].include?("#{service_type}") &&
    node['smarts']["#{product_name}"]["service"]["#{service_type}"].include?("active") &&
    node['smarts']["#{product_name}"]["service"]["#{service_type}"]["active"] == "true"

    execute "Execute install scripts for service #{service_type} of #{product_name}" do
      scriptName="#{install_root_dir}/#{product_name}/smarts/local/conf/install-#{customerId}-#{product_name}-#{service_type}.sh"
      command "echo executing #{scriptName}; #{scriptName}"
      not_if "#{install_root_dir}/#{product_name}/smarts/sm_service show #{customerId}-#{service_type} | grep #{customerId}-#{service_type}"
    end
  end
end

#execute install scripts for ESM services in specific order 
#make sure there's a template file install-cust-<PRODUCT>-<SERVICE>.sh.erb for each service
product_name = "ESM"
%w{ESM ESM-VM}.each do |service_type|
  #check if service is activated for this installation
  if node['smarts'].include?("#{product_name}") &&
    node['smarts']["#{product_name}"].include?("service") &&
    node['smarts']["#{product_name}"]["service"].include?("#{service_type}") &&
    node['smarts']["#{product_name}"]["service"]["#{service_type}"].include?("active") &&
    node['smarts']["#{product_name}"]["service"]["#{service_type}"]["active"] == "true"

    execute "Execute install scripts for service #{service_type} of #{product_name}" do
      scriptName="#{install_root_dir}/#{product_name}/smarts/local/conf/install-#{customerId}-#{product_name}-#{service_type}.sh"
      command "echo executing #{scriptName}; #{scriptName}"
      not_if "#{install_root_dir}/#{product_name}/smarts/sm_service show #{customerId}-#{service_type} | grep #{customerId}-#{service_type}"
    end
  end
end

###fail safe (redundant?) method to make sure all defined services are being started
%w{SAM CONSOLE IP ESM NPM VoIP}.each do |product_name|
	execute "Start all services for #{product_name}" do
	  command "#{install_root_dir}/#{product_name}/smarts/bin/sm_service start --all"
	end
end
