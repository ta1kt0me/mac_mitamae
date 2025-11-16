include_recipe 'directory_helper'

home_dir = DirectoryHelper.home(node)
home_path = "#{home_dir}/" + node[:user]

# bundler
file "#{home_path + "/.default-gems"}" do
  user node[:user]
  content <<-EOS
bundler
gemdiff
mgem
neovim
rubocop
  EOS
  owner node[:user]
  mode '644'
end

# pip
file "#{home_path + "/.default-python-packages"}" do
  user node[:user]
  content <<-EOS
boto
httpie
neovim
powerline-status
pynvim
  EOS
  owner node[:user]
  mode '644'
end