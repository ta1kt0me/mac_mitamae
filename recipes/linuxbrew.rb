LINUXBREW_PREFIX = "#{ENV["HOME"]}/.linuxbrew".freeze

execute "Make directory for linuxbrew" do
  user node[:user]
  command "mkdir -p #{LINUXBREW_PREFIX}"
  not_if "test -d #{LINUXBREW_PREFIX}"
end

git "#{LINUXBREW_PREFIX}/Homebrew" do
  user node[:user]
  repository "git@github.com:Homebrew/brew.git"
end

%w(bin sbin).each do |dir|
  execute "Link brew command in #{dir}" do
    user node[:user]
    command "ln -s #{LINUXBREW_PREFIX}/Homebrew/#{dir} #{LINUXBREW_PREFIX}/#{dir}"
    not_if "test -L #{LINUXBREW_PREFIX}/#{dir}"
  end
end
