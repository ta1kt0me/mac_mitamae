include_recipe 'directory_helper'

home_path = DirectoryHelper.home_path(node)
dirs = [
  home_path + "/.vim",
  home_path + "/.ssh_local",
  home_path + "/.gotools",
  home_path + "/.local/bin",         # eget and mise
  home_path + "/.local/share/fonts", # font.rb
]

dirs.each do |dir|
  directory dir do
    user node[:user]
  end
end
