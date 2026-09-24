include_recipe 'mise_helper'

mise = MiseHelper.path(node)

execute "Install mise" do
  user node[:user]
  command "curl https://mise.run | sh"
  not_if "test -x #{mise}"
end

node[:mise][:plugins].each do |plugin|
  execute "Install #{plugin} via mise" do
    user node[:user]
    command "#{mise} plugins install #{plugin}"
    not_if "#{mise} plugins ls | grep -qx #{plugin}"
  end
end

# `mise use` installs the version if it is missing
MiseHelper.pinned_tools(node).each do |tool|
  execute "Activate #{tool} via mise" do
    user node[:user]
    command "#{mise} use --global #{tool}"
  end
end

# only activate here; bin/update updates them
MiseHelper.latest_tools(node).each do |tool|
  execute "Activate #{tool} via mise" do
    user node[:user]
    command "#{mise} use --global #{tool}"
    not_if "test -n \"$(#{mise} ls --global #{tool.split('@').first})\""
  end
end
