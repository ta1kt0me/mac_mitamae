execute "Install nodebrew" do
  user node[:user]
  command "curl -L git.io/nodebrew | perl - setup"
end

execute "Install nodejs" do
  nodebrew = "$HOME/.nodebrew/current/bin/nodebrew"
  user node[:user]
  command "#{nodebrew} install-binary #{node[:nodejs][:version]} && #{nodebrew} use #{node[:nodejs][:version]}"
  not_if "[[ ! -z $(#{nodebrew} ls | grep #{node[:nodejs][:version]}) ]]"
end

RBENV_PATH = ENV["HOME"] + "/.rbenv"
DEFAULT_GEM_PATH = RBENV_PATH + "/default-gems"

execute "Create rbenv-default-gems file" do
  user node[:user]
  command "touch #{DEFAULT_GEM_PATH}"
  not_if "test -e #{DEFAULT_GEM_PATH}"
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
    command "rbenv install #{version}"
    not_if "test $(rbenv versions --bare | grep #{version})"
  end
end

node[:rbenv][:global].tap do |version|
  execute "Set rbenv global #{version}" do
    user node[:user]
    command "rbenv global #{version}"
    not_if "test $(rbenv version-name | grep #{version})"
  end
end

node[:pyenv][:versions].each do |version|
  execute "Install python #{version}" do
    user node[:user]
    command "pyenv install #{version}"
    not_if "test $(pyenv versions --bare | grep #{version})"
  end
end

node[:pyenv][:global].tap do |version|
  execute "Set pyenv global #{version}" do
    user node[:user]
    command "pyenv global #{version}"
    not_if "test $(pyenv version-name | grep #{version})"
  end
end
