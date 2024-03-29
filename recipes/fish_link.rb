include_recipe 'directory_helper'

home_dir = DirectoryHelper.home(node)
home_path    = "#{home_dir}/" + node[:user]
dropbox_path = home_path + "/Dropbox"
fish_path    = home_path + "/.config/fish"

links = [
  { from: fish_path + "/local.fish", to: dropbox_path + "/Public/fish/local.fish" }
]

links.each do |link|
  link link[:from] do
    user node[:user]
    to link[:to]
  end
end
