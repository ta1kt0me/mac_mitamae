node[:pip].each do |tool|
  pip tool do
    user node[:user]
    pip_binary "#{node[:platform] == "darwin" ? "/Users" : "/home"}/#{node[:user]}/.pyenv/shims/pip3"
  end
end
