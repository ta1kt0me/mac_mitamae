node[:pip].each do |tool|
  pip tool do
    pip_binary 'pip3'
  end
end
