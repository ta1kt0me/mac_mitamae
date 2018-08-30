execute "Install font for powerline" do
  user node[:user]
  command 'cd "$($HOME/src/bin/ghq list -p | grep powerline/fonts)" && ./install.sh'
end
