include_recipe 'directory_helper'

HOME_DIR = DirectoryHelper.home(node) + "/" + node[:user]

execute "Install mise" do
  user node[:user]
  command "curl https://mise.run | sh"
end

node[:mise][:packages].each do |package|
  execute "Install #{package} via mise" do
    user node[:user]
    command "#{HOME_DIR}/.local/bin/mise install #{package}"
    only_if "test -z $(#{HOME_DIR}/.local/bin/mise ls #{package.split("@").first} | grep #{package.split("@").last})"
  end
end

node[:mise][:plugins].each do |plugin|
  execute "Install #{plugin} via mise" do
    user node[:user]
    command "#{HOME_DIR}/.local/bin/mise plugins install #{plugin}"
    only_if "test -z $(#{HOME_DIR}/.local/bin/mise ls #{plugin})"
  end

  execute "Update #{plugin} via mise" do
    user node[:user]
    command "#{HOME_DIR}/.local/bin/mise plugins update #{plugin}"
  end
end
