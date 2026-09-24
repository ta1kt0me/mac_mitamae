include_recipe 'directory_helper'

home_path = DirectoryHelper.home_path(node)
dirs = [
  home_path + "/.vim",
  home_path + "/.ssh_local",
  home_path + "/.gotools"
]

dirs.each do |dir|
  execute "mkdir #{dir}" do
    user node[:user]
    command "mkdir -p #{dir}"
    not_if "test -d #{dir}"
  end
end
