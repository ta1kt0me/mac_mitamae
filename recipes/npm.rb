node[:npm].each do |package|
  execute "Install #{package}" do
    user node[:user]
    command "npm install -g #{package}"
  end
end
