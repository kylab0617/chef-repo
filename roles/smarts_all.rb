name "smarts_all"
description "This role installs all SMARTS Components (SAM, IP, ESM, MPLS, VoIP, and NPM Managers)"
run_list ["recipe[smarts::os_patches]", "recipe[smarts::sam]"]
