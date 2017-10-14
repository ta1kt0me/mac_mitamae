execute "Install vim-plug" do
  user node[:user]
  command "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && vim -c 'PlugInstall|q!|q!'"
end

execute "Update vim's plugin" do
  user node[:user]
  command "vim -c 'PlugUpdate|q!|q!'"
end
