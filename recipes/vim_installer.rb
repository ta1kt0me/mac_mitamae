ghq "vim/vim" do
  action :update
  options "-p --shallow"
end

vimsrc = "#{ENV['HOME']}/.ghq/github.com/vim/vim"

execute "checkout tag" do
  user node[:user]
  cwd vimsrc
  command "git fetch --tags | git checkout $(git describe --tags)"
  not_if "test -z \"$(git fetch --dry-run --tags 2>&1 | grep 'new tag')\""
end

execute "install vim" do
  configure = "./configure --with-features=huge --enable-python3interp --enable-rubyinterp --enable-luainterp --enable-fail-if-missing --with-luajit --enable-multibyte --enable-gui=auto --with-x"
  user node[:user]
  cwd vimsrc
  command "#{configure} && make && sudo make install"
  not_if "test -n \"$(git branch | grep 'master')\""
end

execute "checkout master" do
  user node[:user]
  cwd vimsrc
  command "git checkout master"
end
