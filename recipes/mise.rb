include_recipe 'directory_helper'

mise = "#{DirectoryHelper.local_bin_path(node)}/mise"

execute "Install mise" do
  user node[:user]
  command "curl https://mise.run | sh"
  not_if "test -x #{mise}"
end

# `mise use` installs the version if it is missing
node[:mise][:packages].each do |package|
  tool, version = package.split("@")
  execute "Activate #{package} via mise" do
    user node[:user]
    command "#{mise} use --global #{package}"
    # @latest is updated by bin/update
    not_if "test -n \"$(#{mise} ls --global #{tool})\"" if version == "latest"
  end
end

node[:mise][:plugins].each do |plugin|
  execute "Install #{plugin} via mise" do
    user node[:user]
    command "#{mise} plugins install #{plugin}"
    not_if "#{mise} plugins ls | grep -qx #{plugin}"
  end

  execute "Activate #{plugin} via mise" do
    user node[:user]
    command "#{mise} use --global #{plugin}@latest"
    not_if "test -n \"$(#{mise} ls --global #{plugin})\""
  end
end
