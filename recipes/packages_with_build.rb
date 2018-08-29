execute "Install z" do
  user node[:user]
  command "cd $(git config --get ghq.root)/github.com/rupa/z && make"
end
