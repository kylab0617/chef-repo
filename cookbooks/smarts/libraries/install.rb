def doInstall(product_name, customerId, product_version, product_os, media_location, install_root_dir)
     

  license_file_name = "smarts.lic"

  response_file            = "#{product_name}-response.txt"
  install_media_file_name  = "setup-#{product_name}-#{product_version}-linux64.bin"
  license_target_file_name = "#{install_root_dir}/#{product_name}/smarts/local/conf/#{license_file_name}"
  marker_file_name         = "#{install_root_dir}/#{product_name}/smarts/bin/sm_server"

  unless File.exists?("#{marker_file_name}")
    ####Stop all EMC Smarts Services
    service "ic-serviced" do
      action :stop
      ignore_failure true
    end
    remote_file "#{Chef::Config[:file_cache_path]}/#{install_media_file_name}" do
      source "#{media_location}/#{product_os}/#{install_media_file_name}"
      owner "root"
      group "root"
      mode "0700"
      action :create_if_missing
    end

    template "#{response_file}" do
      path "#{Chef::Config[:file_cache_path]}/#{response_file}"
      source "smarts.#{product_name}.erb"
      owner "root"
      group "root"
      mode "0644"
    end

    execute "Smarts #{product_name} Silent Install" do
      cwd Chef::Config[:file_cache_path]
      command "./#{install_media_file_name} -is:log #{Chef::Config[:file_cache_path]}/#{product_name}.log -is:tempdir #{Chef::Config[:file_cache_path]} -options #{Chef::Config[:file_cache_path]}/#{response_file}"
      creates "#{marker_file_name}"
    end

    execute "Smarts Version Check" do
      command "#{marker_file_name} --version > #{Chef::Config[:file_cache_path]}/#{product_name}-result.log"
    end
  end

  remote_file "SMARTS_license" do
    source "#{media_location}/#{license_file_name}"
    path "#{license_target_file_name}"
    owner "root"
    group "root"
    mode "0444"
    action :create_if_missing
  end

  template "Install helper functions" do
    path "#{install_root_dir}/#{product_name}/smarts/local/conf/install-helper-functions.sh"
    source "install-helper-functions.sh.erb"
    owner "root"
    group "root"
    mode "0755"
  end

  # log "****DEBUG: #{product_name}"
  if node['smarts'].include?("#{product_name}") && node['smarts']["#{product_name}"].include?("service")
    tmpProd= node['smarts']["#{product_name}"]['service'].flatten.to_s
    node['smarts']["#{product_name}"]['service'].each do |serviceName, serviceParams|
      # log "****DEBUG: processing service #{serviceName}"
      if serviceParams.include?("active") && serviceParams["active"] == "true" 
        # log "****DEBUG: #{serviceName} is marked as active in node attributes"
        template "Install script for service #{customerId}-#{serviceName}" do
          path "#{install_root_dir}/#{product_name}/smarts/local/conf/install-#{customerId}-#{product_name}-#{serviceName}.sh"
          source "install-cust-#{product_name}-#{serviceName}.sh.erb"
          owner "root"
          group "root"
          mode "0755"
        end
      end
    end
  end

  log "#{product_name} install done."
end

def doUninstall(product_name)
  license_file_name = "smarts.lic"
  product_version   = node['smarts']['gereral']['version']
  product_os        = node['smarts']['gereral']['os']
  media_location    = node['smarts']['gereral']['repo']
  install_root_dir  = node['smarts']['gereral']['install_root_dir']

  uninstaller_bin="#{install_root_dir}/#{product_name}/_uninst/uninstaller.bin"
  if File.exists?("#{uninstaller_bin}")
    service "ic-serviced" do
      action :stop
      ignore_failure true
    end
    execute "Smarts #{product_name} Silent Uninstall" do
      command "#{uninstaller_bin} -silent"
    end
    service "ic-serviced" do
      action :start
    end
    log "#{product_name} uninstall done."
  end
end
