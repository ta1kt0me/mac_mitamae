include_recipe 'mise_helper'

mise = MiseHelper.path(node)

execute "Install mise" do
  user node[:user]
  command "curl -fsSL https://mise.run | sh"
  not_if "test -x #{mise}"
end

node[:mise][:plugins].each do |plugin|
  execute "Install #{plugin} via mise" do
    user node[:user]
    command "#{mise} plugins install #{plugin}"
    not_if "#{mise} plugins ls | grep -qx #{plugin}"
  end
end

MiseHelper.pinned_tools(node).each do |tool|
  execute "Install #{tool} via mise" do
    user node[:user]
    command "#{mise} install #{tool}"
    not_if "#{mise} where #{tool}"
  end
end

# `mise use` keeps one version per tool, so only the newest one is activated
MiseHelper.default_pinned_tools(node).each do |tool|
  name, version = tool.split("@")
  execute "Activate #{tool} via mise" do
    user node[:user]
    command "#{mise} use --global #{tool}"
    not_if "test \"$(#{mise} config get -f #{DirectoryHelper.home_path(node)}/.config/mise/config.toml tools.#{name})\" = #{version}"
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
