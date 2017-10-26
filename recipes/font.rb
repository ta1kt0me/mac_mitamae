execute "Install font for powerline" do
  user node[:user]
  command 'cd "$(ghq list -p | grep powerline/fonts)" && ./install.sh'
end
