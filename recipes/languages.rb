include_recipe 'directory_helper'

home_dir = DirectoryHelper.home(node)
home_path = "#{home_dir}/" + node[:user]

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
pyenv = "#{home_path}/.pyenv/bin/pyenv"
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
