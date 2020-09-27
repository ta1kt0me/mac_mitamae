def home_dir
  node[:platform] == "darwin" ? "/Users" : "/home"
end

node[:git].each do |item|
  git "#{home_dir}/#{node[:user]}/#{item[:dist]}" do
    user node[:user]
    repository item[:repo]
  end
end
