node[:npm].each do |package|
  execute "Install #{package}" do
    user node[:user]
    command "PATH=$HOME/.nodebrew/current/bin:$PATH npm install -g #{package}"
  end
end
