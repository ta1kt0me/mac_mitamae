LINUXBREW_PREFIX = "$HOME/.linuxbrew".freeze

execute "Make directory for linuxbrew" do
  user node[:user]
  command "mkdir -p #{LINUXBREW_PREFIX}"
  not_if "test -d #{LINUXBREW_PREFIX}"
end

git "#{LINUXBREW_PREFIX}/Homebrew" do
  user node[:user]
  repository "git@github.com:Homebrew/brew.git"
end

execute "Link brew command" do
  user node[:user]
  command "ln -s #{LINUXBREW_PREFIX}/Homebrew/bin #{LINUXBREW_PREFIX}/bin"
  not_if "test -L #{LINUXBREW_PREFIX}/bin"
end
