
include_recipe "smarts::os_patches"

prod="SAM"
if node['smarts']["#{prod}"]['SAM_SUITE']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_BROKER']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_ICOI']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_MBIM']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_SAM']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_TRAP']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_UIM']['active'] == 'true'

  doInstall("#{prod}")
else
  doUninstall("#{prod}")
end 

prod="CONSOLE"
if node['smarts']["#{prod}"]['CONSOLE']['active'] == 'true' or
   node['smarts']["#{prod}"]['NOTIF']['active'] == 'true'   or
   node['smarts']["#{prod}"]['SERVICE_DASHBOARD']['active'] == 'true'

  doInstall("#{prod}")
else
  doUninstall("#{prod}")
end

prod="IP"
if node['smarts']["#{prod}"]['AM_PM_DISCOVERY']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_AM']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_AM_PM']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_BROKER']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_CM']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_PM']['active'] == 'true' 

  doInstall("#{prod}")
else
  doUninstall("#{prod}")
end 

prod="ESM"
if node['smarts']["#{prod}"]['SERVICE_ESM_Server']['active'] == 'true' or
   node['smarts']["#{prod}"]['ESM']['active'] == 'true'

  doInstall("#{prod}")
else
  doUninstall("#{prod}")
end 

prod="NGP"
if node['smarts']["#{prod}"]['NGP']['active'] == 'true' or
   node['smarts']["#{prod}"]['SERVICE_BGP']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_EIGRP']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_ISIS']['active'] == 'true' or 
   node['smarts']["#{prod}"]['SERVICE_OSPF']['active'] == 'true'

  doInstall("#{prod}")
else
  doUninstall("#{prod}")
end

prod="VoIP"
if node['smarts']["#{prod}"]['SERVICE_VOIP_ADAPTER']['active'] == 'true'
  
  log "installing #{prod}."
  doInstall("#{prod}")
else
  log "uninstalling #{prod}."
  doUninstall("#{prod}")
end 
