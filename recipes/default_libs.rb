include_recipe 'directory_helper'

home_path = DirectoryHelper.home_path(node)

{
  ".default-gems"            => :default_gems,            # bundler
  ".default-python-packages" => :default_python_packages, # pip
  ".default-npm-packages"    => :default_npm_packages,    # npm
  ".default-go-packages"     => :default_go_packages,     # go
}.each do |filename, key|
  file "#{home_path}/#{filename}" do
    user node[:user]
    content node[key].join("\n").concat("\n")
    owner node[:user]
    mode '644'
  end
end
