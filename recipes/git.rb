node[:git].each do |item|
  git "/home/#{node[:user]}/#{item[:dist]}" do
    user node[:user]
    repository item[:repo]
  end
end
