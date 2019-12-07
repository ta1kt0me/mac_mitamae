node[:pip].each do |tool|
  pip tool do
    user node[:user]
    pip_binary "/home/#{node[:user]}/.pyenv/shims/pip3"
  end
end
