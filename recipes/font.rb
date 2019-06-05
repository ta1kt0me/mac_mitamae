execute "Install font for powerline" do
  user node[:user]
  command 'cd "$(/usr/local/bin/ghq list -p | grep powerline/fonts)" && ./install.sh'
end
