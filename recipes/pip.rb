node[:pip].each do |tool|
  pip tool do
    user node[:user]
    pip_binary "#{ENV['HOME']}/.pyenv/shims/pip3"
  end
end
