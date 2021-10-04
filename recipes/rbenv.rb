include_recipe 'directory_helper'

home_dir = DirectoryHelper.home(node)
home_path = "#{home_dir}/" + node[:user]

# rbenv
RBENV_PATH = home_path + "/.rbenv"
DEFAULT_GEM_PATH = RBENV_PATH + "/default-gems"
RBENV_EXE = RBENV_PATH + "/bin/rbenv"

execute "Create rbenv-default-gems file" do
  user node[:user]
  command "touch #{DEFAULT_GEM_PATH}"
  not_if "test -e #{DEFAULT_GEM_PATH}"
end

execute "Create gemrc-default-gems file" do
  user node[:user]
  command "echo 'gemsrc_use_ghq: true' >> #{home_path}/.gemrc"
  not_if "test -n \"$(grep 'gemsrc_use_ghq' #{home_path}/.gemrc)\""
end

node[:rbenv_default_gems].each do |gem|
  execute "Set rbenv-default-gems to #{gem}" do
    user node[:user]
    command "echo #{gem} >> #{DEFAULT_GEM_PATH}"
    not_if "test $(grep #{gem} #{DEFAULT_GEM_PATH})"
  end
end

node[:rbenv][:versions].each do |version|
  execute "Install ruby #{version}" do
    user node[:user]
    command "#{RBENV_EXE} install #{version}"
    not_if "test $(#{RBENV_EXE} versions --bare | grep #{version})"
  end
end

node[:rbenv][:global].tap do |version|
  execute "Set rbenv global #{version}" do
    user node[:user]
    command "#{RBENV_EXE} global #{version}"
    not_if "test $(#{RBENV_EXE} version-name | grep #{version})"
  end
end
