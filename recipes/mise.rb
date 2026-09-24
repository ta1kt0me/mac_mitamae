include_recipe 'directory_helper'

home_path = DirectoryHelper.home_path(node)
mise = "#{home_path}/.local/bin/mise"

execute "Install mise" do
  user node[:user]
  command "curl https://mise.run | sh"
end

node[:mise][:packages].each do |package|
  execute "Install #{package} via mise" do
    user node[:user]
    command "#{mise} install #{package}"
    only_if "test -z $(#{mise} ls #{package.split('@').first} | grep #{package.split('@').last})"
  end

  execute "Activate #{package} via mise" do
    user node[:user]
    command "#{mise} use --global #{package}"
  end
end

node[:mise][:plugins].each do |plugin|
  execute "Install #{plugin} via mise" do
    user node[:user]
    command "#{mise} plugins install #{plugin}"
    only_if "test -z $(#{mise} ls #{plugin})"
  end

  execute "Update #{plugin} via mise" do
    user node[:user]
    command "#{mise} plugins update #{plugin}"
  end

  execute "Activate #{plugin} via mise" do
    user node[:user]
    command "#{mise} use --global #{plugin}@latest"
  end
end
