# nodebrew
execute "Install nodebrew" do
  user node[:user]
  command "curl -L git.io/nodebrew | perl - setup"
end

execute "Install nodejs" do
  nodebrew = "$HOME/.nodebrew/current/bin/nodebrew"
  user node[:user]
  command "#{nodebrew} install-binary #{node[:nodejs][:version]} && #{nodebrew} use #{node[:nodejs][:version]}"
  not_if "test -n \"$(#{nodebrew} ls | grep #{node[:nodejs][:version]})\""
end

# rbenv
RBENV_PATH = ENV["HOME"] + "/.rbenv"
DEFAULT_GEM_PATH = RBENV_PATH + "/default-gems"
RBENV_EXE = RBENV_PATH + "/bin/rbenv"

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

# TODO: for vim
# which pip
# curl -kL https://bootstrap.pypa.io/get-pip.py | sudo /usr/bin/python3
# sudo pip install neovim
#
# (Φ ω Φ> /usr/local/bin/pip show neov
#  14:28:13 ~ ruby:2.5.1 node:v10.13.0
# (Φ ω Φ> /usr/local/bin/pip show neovim
# Name: neovim
# Version: 0.3.0
# Summary: Python client to neovim
# Home-page: http://github.com/neovim/python-client
# Author: Thiago de Arruda
# Author-email: tpadilha84@gmail.com
# License: Apache
# Location: /usr/local/lib/python3.6/dist-packages
# Requires: greenlet, msgpack
# Required-by:

# pyenv
pyenv = "#{ENV["HOME"]}/.pyenv/bin/pyenv"
pyenv_option = 'env PYTHON_CONFIGURE_OPTS="--enable-shared"'
node[:pyenv][:versions].each do |version|
  execute "Install python #{version}" do
    user node[:user]
    command "#{pyenv_option} #{pyenv} install #{version}"
    not_if "test $(#{pyenv} versions --bare | grep #{version})"
  end
end

node[:pyenv][:global].tap do |version|
  execute "Set pyenv global #{version}" do
    user node[:user]
    command "#{pyenv} global #{version}"
    not_if "test $(#{pyenv} version-name | grep #{version})"
  end
end

# goenv
goenv = "#{ENV["HOME"]}/.goenv/bin/goenv"
node[:goenv][:versions].each do |version|
  execute "Install go #{version}" do
    user node[:user]
    command "#{goenv} install #{version}"
    not_if "test $(#{goenv} versions --bare | grep #{version})"
  end
end

node[:goenv][:global].tap do |version|
  execute "Set goenv global #{version}" do
    user node[:user]
    command "#{goenv} global #{version}"
    not_if "test $(#{goenv} version-name | grep #{version})"
  end
end

GO_PATH = ENV["HOME"] + "/src"
GO_BIN = GO_PATH + "/bin"
goexe = "#{ENV['HOME']}/.goenv/shims/go"
["go-get-release", "detect-latest-release"].each do |pkg|
  execute "Download #{pkg}" do
    user node[:user]
    command "GOBIN=#{GO_BIN} #{goexe} get -u github.com/rhysd/go-github-selfupdate/cmd/#{pkg}"
    not_if "test -e #{GO_BIN}/#{pkg}"
  end
end

execute "Install dep" do
  user node[:user]
  command "curl https://raw.githubusercontent.com/golang/dep/master/install.sh | PATH=#{ENV["HOME"]}/.goenv/shims:$PATH GOBIN=#{GO_BIN} sh"
  not_if "test -e #{GO_BIN}/dep"
end

node[:go_packages].each do |package|
  execute "Install #{package}" do
    user node[:user]
    command "GOPATH=#{GO_PATH} #{GO_BIN}/go-get-release github.com/#{package}"
  end
end

# rust
execute "Install rsvm" do
  user node[:user]
  command "curl -L https://raw.github.com/sdepold/rsvm/master/install.sh | sh"
end

RSVM_HOME = ENV["HOME"] + "/.rsvm"
execute "Link fish-config for rsvm" do
  user node[:user]
  command "ln -s #{RSVM_HOME}/rsvm.fish $HOME/.config/fish/functions"
  not_if "test -e $HOME/.config/fish/functions/rsvm.fish"
end

node[:rust][:versions].each do |version|
  execute "Install rust #{version}" do
    user node[:user]
    cwd ENV["HOME"]
    command ". #{RSVM_HOME}/rsvm.sh && rsvm install #{version}"
    not_if ". #{RSVM_HOME}/rsvm.sh && test -n \"$(rsvm ls | grep #{version})\""
  end
end

node[:rust][:global].tap do |version|
  execute "Set rsvm use #{version}" do
    user node[:user]
    command ". #{RSVM_HOME}/rsvm.sh && rsvm use #{version}"
  end
end

node[:rust_packages].each do |package|
  execute "Install rust package: #{package}" do
    user node[:user]
    command ". #{RSVM_HOME}/rsvm.sh && cargo install #{package}"
    not_if ". #{RSVM_HOME}/rsvm.sh && test -n \"$(cargo install --list | grep #{package})\""
  end
end
