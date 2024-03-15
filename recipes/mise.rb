include_recipe 'directory_helper'

HOME_DIR = DirectoryHelper.home(node) + "/" + node[:user]

execute "Install mise" do
  user node[:user]
  command "curl https://mise.run | sh"
  not_if "test -e #{HOME_DIR}/.local/bin/mise"
end

# node
node[:mise][:node][:versions].each do |version|
  execute "Install node@#{version}}" do
    user node[:user]
    command "#{HOME_DIR}/.local/bin/mise install -q node@#{version}"
    only_if "test -z $(#{HOME_DIR}/.local/bin/mise ls node | grep #{version})"
  end
end

execute "Install node@#{node[:mise][:node][:use]}}" do
  user node[:user]
  command "#{HOME_DIR}/.local/bin/mise use node@#{node[:mise][:node][:use]}"
end

# ruby
node[:mise][:ruby][:versions].each do |version|
  execute "Install ruby@#{version}}" do
    user node[:user]
    command "#{HOME_DIR}/.local/bin/mise install -q ruby@#{version}"
    only_if "test -z $(#{HOME_DIR}/.local/bin/mise ls ruby | grep #{version})"
  end
end

execute "Install ruby@#{node[:mise][:ruby][:use]}}" do
  user node[:user]
  command "#{HOME_DIR}/.local/bin/mise use ruby@#{node[:mise][:ruby][:use]}"
end
