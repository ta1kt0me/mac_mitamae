include_recipe 'directory_helper'

home_dir = DirectoryHelper.home(node)
home_path = "#{home_dir}/" + node[:user]
dirs = [
  home_path + "/.vim",
  home_path + "/.ghq",
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
