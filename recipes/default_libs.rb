include_recipe 'directory_helper'

home_dir = DirectoryHelper.home(node)
home_path = "#{home_dir}/" + node[:user]

# bundler
file "#{home_path + "/.default-gems"}" do
  user node[:user]
  content node[:default_gems].join("\n").concat("\n")
  owner node[:user]
  mode '644'
end

# pip
file "#{home_path + "/.default-python-packages"}" do
  user node[:user]
  content node[:default_python_packages].join("\n").concat("\n")
  owner node[:user]
  mode '644'
end

# npm
file "#{home_path + "/.default-npm-packages"}" do
  user node[:user]
  content node[:default_npm_packages].join("\n").concat("\n")
  owner node[:user]
  mode '644'
end
