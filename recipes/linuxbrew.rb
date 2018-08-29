git "#{ENV['HOME']}/.linuxbrew" do
  user node[:user]
  repository "git@github.com:Linuxbrew/brew.git"
end
